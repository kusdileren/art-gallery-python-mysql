from fastapi import FastAPI, HTTPException, Depends, UploadFile, File, Header
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, List
from database import get_db_connection
from jose import JWTError, jwt
from datetime import datetime, timedelta
import os, uuid, shutil, bcrypt, time

# ─── GİRİŞ DENEME TAKİBİ ────────────────────────────────────
# { email: {"count": int, "locked_until": float} }
login_attempts: dict = {}
MAX_ATTEMPTS = 5
LOCKOUT_SECONDS = 300

SECRET_KEY = os.getenv("JWT_SECRET")
if not SECRET_KEY:
    raise RuntimeError("JWT_SECRET ortam değişkeni tanımlanmamış!")
ALGORITHM = "HS256"
TOKEN_EXPIRE_HOURS = 24

def token_olustur(user_id: int, role: str) -> str:
    expire = datetime.utcnow() + timedelta(hours=TOKEN_EXPIRE_HOURS)
    return jwt.encode({"sub": str(user_id), "role": role, "exp": expire}, SECRET_KEY, algorithm=ALGORITHM)

def token_coz(authorization: Optional[str] = Header(None)):
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Giriş yapmanız gerekiyor")
    token = authorization.split(" ")[1]
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return {"user_id": int(payload["sub"]), "role": payload["role"]}
    except JWTError:
        raise HTTPException(status_code=401, detail="Geçersiz veya süresi dolmuş oturum")

def admin_mi(authorization: Optional[str] = Header(None)):
    user = token_coz(authorization)
    if user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Bu işlem için admin yetkisi gerekli")
    return user

app = FastAPI(title="KTÜ Sanat Galerisi API")  # ✅ Tek tanım, başlıklı

ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "http://localhost:5500").split(",")

app.add_middleware(
    CORSMiddleware,
    allow_origins=ALLOWED_ORIGINS,
    allow_methods=["GET", "POST", "PUT", "DELETE"],
    allow_headers=["Authorization", "Content-Type"],
)

# ✅ images/ klasörünü tek seferinde mount et
IMAGES_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "images")
os.makedirs(IMAGES_DIR, exist_ok=True)
app.mount("/images", StaticFiles(directory=IMAGES_DIR), name="images")

# ─── MODELLER ───────────────────────────────────────────────
class Review(BaseModel):
    user_id: int
    artwork_id: Optional[int] = None
    event_id: Optional[int] = None
    rating: int
    comment: str

class ReviewVote(BaseModel):
    review_id: int
    user_id: int
    is_helpful: bool

class ReviewReply(BaseModel):
    review_id: int
    admin_id: int
    reply: str

class User(BaseModel):
    full_name: str
    email: str
    password: str

class UserLogin(BaseModel):
    email: str
    password: str

class UserUpdate(BaseModel):
    user_id: int
    full_name: Optional[str] = None
    email: Optional[str] = None

class PasswordChange(BaseModel):
    user_id: int
    old_password: str
    new_password: str

class Favorite(BaseModel):
    user_id: int
    artwork_id: int

class Reservation(BaseModel):
    user_id: int
    event_id: int
    participant_count: int
    reservation_date: str

class ReservationUpdate(BaseModel):
    reservation_id: int
    participant_count: Optional[int] = None
    reservation_date: Optional[str] = None

class Purchase(BaseModel):
    user_id: int
    artwork_id: Optional[int] = None
    event_id: Optional[int] = None
    payment_method: str
    coupon_code: Optional[str] = None
    participant_count: Optional[int] = 1

class SupportMessage(BaseModel):
    user_id: Optional[int] = None
    name: str
    email: str
    message: str

# ─── MADDE 1: ESERLERİ İNCELEME ────────────────────────────
@app.get("/eserler")
def eserler():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT a.*, ar.name as artist_name, ar.bio as artist_bio,
               c.name as category_name,
               COALESCE(AVG(r.rating), 0) as avg_rating,
               COUNT(DISTINCT r.id) as review_count,
               COUNT(DISTINCT v.id) as view_count
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        LEFT JOIN categories c ON a.category_id = c.id
        LEFT JOIN reviews r ON r.artwork_id = a.id
        LEFT JOIN artwork_views v ON v.artwork_id = a.id
        GROUP BY a.id
    """)
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/eserler/{artwork_id}")
def eser_detay(artwork_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    # Görüntülenme sayısını artır
    cursor.execute("INSERT INTO artwork_views (artwork_id) VALUES (%s)", (artwork_id,))
    conn.commit()
    cursor.execute("""
        SELECT a.*, ar.name as artist_name, ar.bio as artist_bio,
               c.name as category_name,
               COALESCE(AVG(r.rating), 0) as avg_rating,
               COUNT(DISTINCT r.id) as review_count
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        LEFT JOIN categories c ON a.category_id = c.id
        LEFT JOIN reviews r ON r.artwork_id = a.id
        WHERE a.id = %s
        GROUP BY a.id
    """, (artwork_id,))
    res = cursor.fetchone()
    conn.close()
    if not res:
        raise HTTPException(status_code=404, detail="Eser bulunamadı")
    return res

# ─── MADDE 2: ATÖLYE VE ETKİNLİKLERİ GÖRÜNTÜLEME ──────────
@app.get("/etkinlikler")
def etkinlikler():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT e.*,
               (SELECT COUNT(id) FROM reservations r WHERE r.event_id = e.id AND r.status != 'iptal') as reserved_count,
               (SELECT COALESCE(SUM(participant_count), 0) FROM reservations r WHERE r.event_id = e.id AND r.status != 'iptal') as total_participants,
               (SELECT COALESCE(AVG(rating), 0) FROM reviews rv WHERE rv.event_id = e.id) as avg_rating
        FROM events e
        ORDER BY e.event_date ASC
    """)
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/etkinlikler/{event_id}")
def etkinlik_detay(event_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT e.*,
               (SELECT COUNT(id) FROM reservations r WHERE r.event_id = e.id AND r.status != 'iptal') as reserved_count,
               (SELECT COALESCE(SUM(participant_count), 0) FROM reservations r WHERE r.event_id = e.id AND r.status != 'iptal') as total_participants,
               (SELECT COALESCE(AVG(rating), 0) FROM reviews rv WHERE rv.event_id = e.id) as avg_rating
        FROM events e
        WHERE e.id = %s
    """, (event_id,))
    res = cursor.fetchone()
    conn.close()
    if not res:
        raise HTTPException(status_code=404, detail="Etkinlik bulunamadı")
    return res

# ─── MADDE 3: FAVORİLERE EKLEME ────────────────────────────
@app.post("/favori-ekle")
def favori_ekle(fav: Favorite, current_user=Depends(token_coz)):
    user_id = current_user["user_id"]  # ✅ JWT'den al, body'den değil
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id FROM favorites WHERE user_id=%s AND artwork_id=%s", (user_id, fav.artwork_id))
    if cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=400, detail="Zaten favorilerde")
    cursor.execute("INSERT INTO favorites (user_id, artwork_id) VALUES (%s, %s)", (user_id, fav.artwork_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Favorilere eklendi"}

@app.get("/favoriler/{user_id}")
def favoriler(user_id: int, current_user=Depends(token_coz)):
    if current_user["user_id"] != user_id and current_user["role"] != "admin":  # ✅ Yetki kontrolü
        raise HTTPException(status_code=403, detail="Bu işlem için yetkiniz yok")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT a.*, ar.name as artist_name
        FROM favorites f
        JOIN artworks a ON f.artwork_id = a.id
        LEFT JOIN artists ar ON a.artist_id = ar.id
        WHERE f.user_id = %s
    """, (user_id,))
    res = cursor.fetchall()
    conn.close()
    return res

@app.delete("/favori-kaldir/{user_id}/{artwork_id}")
def favori_kaldir(user_id: int, artwork_id: int, current_user=Depends(token_coz)):
    if current_user["user_id"] != user_id and current_user["role"] != "admin":  # ✅ Yetki kontrolü
        raise HTTPException(status_code=403, detail="Bu işlem için yetkiniz yok")
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM favorites WHERE user_id=%s AND artwork_id=%s", (user_id, artwork_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Favorilerden kaldırıldı"}

# ─── MADDE 4 & 5: REZERVASYON OLUŞTURMA VE GÜNCELLEME ──────
@app.post("/rezervasyon")
def rezervasyon_olustur(res: Reservation, current_user=Depends(token_coz)):
    user_id = current_user["user_id"]  # ✅ JWT'den al
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    # Kontenjan kontrolü
    cursor.execute("SELECT capacity FROM events WHERE id = %s", (res.event_id,))
    event = cursor.fetchone()
    if not event:
        conn.close()
        raise HTTPException(status_code=404, detail="Etkinlik bulunamadı")
    cursor.execute("""
        SELECT COALESCE(SUM(participant_count), 0) as total
        FROM reservations WHERE event_id=%s AND status != 'iptal'
    """, (res.event_id,))
    total = cursor.fetchone()['total']
    if total + res.participant_count > event['capacity']:
        conn.close()
        raise HTTPException(status_code=400, detail="Kontenjan dolu")
    cursor.execute("""
        INSERT INTO reservations (user_id, event_id, participant_count, reservation_date, status)
        VALUES (%s, %s, %s, %s, 'onaylandı')
    """, (user_id, res.event_id, res.participant_count, res.reservation_date))
    conn.commit()
    rid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Rezervasyon oluşturuldu", "reservation_id": rid}

@app.put("/rezervasyon-guncelle")
def rezervasyon_guncelle(upd: ReservationUpdate, current_user=Depends(token_coz)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    # ✅ Rezervasyonun bu kullanıcıya ait olduğunu doğrula
    cursor.execute("SELECT user_id FROM reservations WHERE id=%s", (upd.reservation_id,))
    row = cursor.fetchone()
    if not row:
        conn.close()
        raise HTTPException(status_code=404, detail="Rezervasyon bulunamadı")
    if row["user_id"] != current_user["user_id"] and current_user["role"] != "admin":
        conn.close()
        raise HTTPException(status_code=403, detail="Bu rezervasyon size ait değil")
    fields = []
    vals = []
    if upd.participant_count is not None:
        fields.append("participant_count=%s"); vals.append(upd.participant_count)
    if upd.reservation_date is not None:
        fields.append("reservation_date=%s"); vals.append(upd.reservation_date)
    if not fields:
        conn.close()
        return {"mesaj": "Güncellenecek alan yok"}
    vals.append(upd.reservation_id)
    cursor.execute(f"UPDATE reservations SET {', '.join(fields)} WHERE id=%s", vals)
    conn.commit()
    conn.close()
    return {"mesaj": "Rezervasyon güncellendi"}

@app.delete("/rezervasyon-iptal/{reservation_id}")
def rezervasyon_iptal(reservation_id: int, current_user=Depends(token_coz)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    # ✅ Rezervasyonun bu kullanıcıya ait olduğunu doğrula
    cursor.execute("SELECT user_id FROM reservations WHERE id=%s", (reservation_id,))
    row = cursor.fetchone()
    if not row:
        conn.close()
        raise HTTPException(status_code=404, detail="Rezervasyon bulunamadı")
    if row["user_id"] != current_user["user_id"] and current_user["role"] != "admin":
        conn.close()
        raise HTTPException(status_code=403, detail="Bu rezervasyon size ait değil")
    cursor.execute("UPDATE reservations SET status='iptal' WHERE id=%s", (reservation_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Rezervasyon iptal edildi"}

# ─── MADDE 6: SATIN ALMA VE ÖDEME ──────────────────────────
@app.post("/satin-al")
def satin_al(p: Purchase, current_user=Depends(token_coz)):
    user_id = current_user["user_id"]  # ✅ JWT'den al
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    discount = 0
    if p.coupon_code:
        cursor.execute(
            "SELECT discount_percent FROM coupons WHERE code=%s AND is_active=1 AND (expires_at IS NULL OR expires_at > NOW())",
            (p.coupon_code,)
        )
        coupon = cursor.fetchone()
        if coupon:
            discount = coupon['discount_percent']

    if p.artwork_id:
        cursor.execute("SELECT price, stock FROM artworks WHERE id=%s", (p.artwork_id,))
        item = cursor.fetchone()
        if not item:
            conn.close()
            raise HTTPException(status_code=404, detail="Eser bulunamadı")
        
        # ✅ STOK KONTROLÜ
        if item['stock'] <= 0:
            conn.close()
            raise HTTPException(status_code=400, detail="Bu eser stokta yok")
        
        price = float(item['price']) * (1 - discount / 100)
        
        cursor.execute("""
            INSERT INTO orders (user_id, artwork_id, amount, payment_method, status)
            VALUES (%s, %s, %s, %s, 'onaylandı')
        """, (user_id, p.artwork_id, price, p.payment_method))
        
        # ✅ STOĞU AZALT
        cursor.execute(
            "UPDATE artworks SET stock = stock - 1 WHERE id=%s AND stock > 0",
            (p.artwork_id,)
        )

    elif p.event_id:
        cursor.execute("SELECT price FROM events WHERE id=%s", (p.event_id,))
        item = cursor.fetchone()
        if not item:
            conn.close()
            raise HTTPException(status_code=404, detail="Etkinlik bulunamadı")
        participant_count = max(1, p.participant_count or 1)
        price = float(item['price']) * participant_count * (1 - discount / 100)
        cursor.execute("""
            INSERT INTO orders (user_id, event_id, amount, payment_method, status)
            VALUES (%s, %s, %s, %s, 'onaylandı')
        """, (user_id, p.event_id, price, p.payment_method))

    conn.commit()
    oid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Satın alma başarılı", "order_id": oid, "indirim": discount}

# ─── MADDE 7: HESAP YÖNETİMİ ───────────────────────────────
@app.post("/kayit")
def kayit(user: User):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id FROM users WHERE email=%s", (user.email,))
    if cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=400, detail="Bu e-posta zaten kayıtlı")
    hashed = bcrypt.hashpw(user.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
    cursor.execute("INSERT INTO users (full_name, email, password) VALUES (%s, %s, %s)",
                   (user.full_name, user.email, hashed))
    conn.commit()
    uid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Kayıt başarılı", "user_id": uid}

@app.post("/giris")
def giris(creds: UserLogin):
    email = creds.email
    now = time.time()
    attempt = login_attempts.get(email, {"count": 0, "locked_until": 0})

    # ✅ Kilitli mi kontrol et
    if attempt["locked_until"] > now:
        kalan = int(attempt["locked_until"] - now)
        raise HTTPException(status_code=429, detail=f"Çok fazla hatalı deneme. {kalan} saniye bekleyin.")

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, full_name, email, role, password FROM users WHERE email=%s", (email,))
    user = cursor.fetchone()
    conn.close()

    if not user or not bcrypt.checkpw(creds.password.encode("utf-8"), user["password"].encode("utf-8")):
        # ✅ Başarısız denemeyi kaydet
        attempt["count"] += 1
        if attempt["count"] >= MAX_ATTEMPTS:
            attempt["locked_until"] = now + LOCKOUT_SECONDS
            attempt["count"] = 0
            login_attempts[email] = attempt
            raise HTTPException(status_code=429, detail=f"5 hatalı deneme. {LOCKOUT_SECONDS} saniye hesabınız kilitlendi.")
        login_attempts[email] = attempt
        kalan_hak = MAX_ATTEMPTS - attempt["count"]
        raise HTTPException(status_code=401, detail=f"Hatalı e-posta veya şifre. {kalan_hak} deneme hakkınız kaldı.")

    # ✅ Başarılı girişte sayacı sıfırla
    login_attempts.pop(email, None)
    token = token_olustur(user["id"], user["role"])
    user.pop("password", None)
    return {"mesaj": "Giriş başarılı", "token": token, "user": user}

@app.put("/profil-guncelle")
def profil_guncelle(upd: UserUpdate, current_user=Depends(token_coz)):
    user_id = current_user["user_id"]  # ✅ JWT'den al
    conn = get_db_connection()
    cursor = conn.cursor()
    fields, vals = [], []
    if upd.full_name: fields.append("full_name=%s"); vals.append(upd.full_name)
    if upd.email:     fields.append("email=%s");     vals.append(upd.email)
    if not fields:
        conn.close()
        return {"mesaj": "Güncellenecek alan yok"}
    vals.append(user_id)
    cursor.execute(f"UPDATE users SET {', '.join(fields)} WHERE id=%s", vals)
    conn.commit()
    conn.close()
    return {"mesaj": "Profil güncellendi"}

@app.put("/sifre-degistir")
def sifre_degistir(req: PasswordChange, current_user=Depends(token_coz)):
    user_id = current_user["user_id"]  # ✅ JWT'den al
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, password FROM users WHERE id=%s", (user_id,))
    user = cursor.fetchone()
    if not user or not bcrypt.checkpw(req.old_password.encode("utf-8"), user["password"].encode("utf-8")):
        conn.close()
        raise HTTPException(status_code=400, detail="Mevcut şifre hatalı")
    new_hashed = bcrypt.hashpw(req.new_password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
    cursor.execute("UPDATE users SET password=%s WHERE id=%s", (new_hashed, user_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Şifre değiştirildi"}

# ─── MADDE 8: SİPARİŞ VE REZERVASYON TAKİBİ ───────────────
@app.get("/siparislerim/{user_id}")
def siparislerim(user_id: int, current_user=Depends(token_coz)):
    if current_user["user_id"] != user_id and current_user["role"] != "admin":  # ✅ Yetki kontrolü
        raise HTTPException(status_code=403, detail="Bu işlem için yetkiniz yok")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT o.*, 
               a.title as artwork_title, a.image_url,
               e.title as event_title, e.event_date
        FROM orders o
        LEFT JOIN artworks a ON o.artwork_id = a.id
        LEFT JOIN events e ON o.event_id = e.id
        WHERE o.user_id = %s
        ORDER BY o.created_at DESC
    """, (user_id,))
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/rezervasyonlarim/{user_id}")
def rezervasyonlarim(user_id: int, current_user=Depends(token_coz)):
    if current_user["user_id"] != user_id and current_user["role"] != "admin":  # ✅ Yetki kontrolü
        raise HTTPException(status_code=403, detail="Bu işlem için yetkiniz yok")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT r.*, e.title as event_title, e.event_date, e.location
        FROM reservations r
        JOIN events e ON r.event_id = e.id
        WHERE r.user_id = %s
        ORDER BY r.created_at DESC
    """, (user_id,))
    res = cursor.fetchall()
    conn.close()
    return res

# ─── MADDE 9: İNDİRİM VE KAMPANYALAR ───────────────────────
@app.get("/kampanyalar")
def kampanyalar():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM coupons WHERE is_active=1 AND is_public=1")
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/kampanyali-eserler")
def kampanyali_eserler():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT a.*, ar.name as artist_name, a.discount_percent
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        WHERE a.discount_percent > 0
    """)
    res = cursor.fetchall()
    conn.close()
    return res

@app.post("/kupon-kontrol")
def kupon_kontrol(body: dict):
    code = body.get("code", "")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM coupons WHERE code=%s AND is_active=1 AND (expires_at IS NULL OR expires_at > NOW())", (code,))
    coupon = cursor.fetchone()
    conn.close()
    if not coupon:
        raise HTTPException(status_code=404, detail="Geçersiz veya süresi dolmuş kupon")
    return coupon

# ─── MADDE 10: MÜŞTERİ DESTEK ──────────────────────────────
@app.post("/destek-mesaji")
def destek_mesaji(msg: SupportMessage, current_user=Depends(token_coz)):
    user_id = current_user["user_id"]  # ✅ JWT'den al
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO support_tickets (user_id, name, email, message, status)
        VALUES (%s, %s, %s, %s, 'açık')
    """, (user_id, msg.name, msg.email, msg.message))
    conn.commit()
    tid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Mesajınız alındı", "ticket_id": tid}

@app.get("/destek-taleplerim/{user_id}")
def destek_taleplerim(user_id: int, current_user=Depends(token_coz)):
    if current_user["user_id"] != user_id and current_user["role"] != "admin":  # ✅ Yetki kontrolü
        raise HTTPException(status_code=403, detail="Bu işlem için yetkiniz yok")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM support_tickets WHERE user_id=%s ORDER BY created_at DESC", (user_id,))
    res = cursor.fetchall()
    conn.close()
    return res

# ─── MADDE 11: KARŞILAŞTIRMA ───────────────────────────────
@app.post("/karsilastir-eserler")
def karsilastir_eserler(body: dict):
    ids = body.get("ids", [])
    if len(ids) < 2:
        raise HTTPException(status_code=400, detail="En az 2 eser seçin")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    placeholders = ','.join(['%s'] * len(ids))
    cursor.execute(f"""
        SELECT a.*, ar.name as artist_name, c.name as category_name,
               COALESCE(AVG(r.rating), 0) as avg_rating,
               COUNT(r.id) as review_count
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        LEFT JOIN categories c ON a.category_id = c.id
        LEFT JOIN reviews r ON r.artwork_id = a.id
        WHERE a.id IN ({placeholders})
        GROUP BY a.id
    """, ids)
    res = cursor.fetchall()
    conn.close()
    return res

@app.post("/karsilastir-etkinlikler")
def karsilastir_etkinlikler(body: dict):
    ids = body.get("ids", [])
    if len(ids) < 2:
        raise HTTPException(status_code=400, detail="En az 2 etkinlik seçin")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    placeholders = ','.join(['%s'] * len(ids))
    cursor.execute(f"""
        SELECT e.*,
               COUNT(r.id) as reserved_count,
               COALESCE(AVG(rv.rating), 0) as avg_rating
        FROM events e
        LEFT JOIN reservations r ON r.event_id = e.id AND r.status != 'iptal'
        LEFT JOIN reviews rv ON rv.event_id = e.id
        WHERE e.id IN ({placeholders})
        GROUP BY e.id
    """, ids)
    res = cursor.fetchall()
    conn.close()
    return res

@app.post("/karsilastirma-kaydet")
def karsilastirma_kaydet(body: dict, current_user=Depends(token_coz)):
    import json
    user_id = body.get("user_id")
    type_ = body.get("type")
    ids = body.get("ids", [])
    if not user_id or not ids or len(ids) < 2:
        raise HTTPException(status_code=400, detail="Geçersiz veri")
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO comparison_history (user_id, comparison_type, item_ids)
        VALUES (%s, %s, %s)
    """, (user_id, type_, json.dumps(ids)))
    conn.commit()
    conn.close()
    return {"mesaj": "Karşılaştırma kaydedildi"}

@app.get("/karsilastirma-gecmisi/{user_id}")
def karsilastirma_gecmisi(user_id: int, current_user=Depends(token_coz)):
    import json
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT * FROM comparison_history WHERE user_id=%s ORDER BY created_at DESC LIMIT 20
    """, (user_id,))
    rows = cursor.fetchall()
    conn.close()
    for row in rows:
        row['item_ids'] = json.loads(row['item_ids'])
    return rows

# ─── MADDE 12: YORUM EKLEME ─────────────────────────────────
@app.post("/yorum-yap")
def yorum_yap(rev: Review, current_user=Depends(token_coz)):
    if not rev.artwork_id and not rev.event_id:
        raise HTTPException(status_code=400, detail="artwork_id veya event_id zorunludur")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    is_verified = False
    if rev.artwork_id:
        # ✅ TEKRAR YORUM KONTROLÜ
        cursor.execute(
            "SELECT id FROM reviews WHERE user_id=%s AND artwork_id=%s",
            (rev.user_id, rev.artwork_id)
        )
        if cursor.fetchone():
            conn.close()
            raise HTTPException(status_code=400, detail="Bu esere zaten yorum yaptınız")

        # Doğrulama: kullanıcı eseri satın almış mı? (zorunlu)
        cursor.execute("""
            SELECT id FROM orders WHERE user_id=%s AND artwork_id=%s AND status='onaylandı'
        """, (rev.user_id, rev.artwork_id))
        purchase = cursor.fetchone()
        if not purchase:
            conn.close()
            raise HTTPException(status_code=403, detail="Bu esere yorum yapabilmek için önce satın almış olmanız gerekiyor")
        is_verified = True
        cursor.execute("""
            INSERT INTO reviews (user_id, artwork_id, rating, comment, is_verified)
            VALUES (%s, %s, %s, %s, %s)
        """, (rev.user_id, rev.artwork_id, rev.rating, rev.comment, is_verified))
    else:
        # ✅ TEKRAR YORUM KONTROLÜ (etkinlik)
        cursor.execute(
            "SELECT id FROM reviews WHERE user_id=%s AND event_id=%s",
            (rev.user_id, rev.event_id)
        )
        if cursor.fetchone():
            conn.close()
            raise HTTPException(status_code=400, detail="Bu etkinliğe zaten yorum yaptınız")

        # Doğrulama: kullanıcı etkinliğe rezervasyon yapmış mı? (zorunlu)
        cursor.execute("""
            SELECT id FROM reservations WHERE user_id=%s AND event_id=%s AND status='onaylandı'
        """, (rev.user_id, rev.event_id))
        reservation = cursor.fetchone()
        if not reservation:
            conn.close()
            raise HTTPException(status_code=403, detail="Bu etkinliğe yorum yapabilmek için önce rezervasyon yapmış olmanız gerekiyor")
        is_verified = True
        cursor.execute("""
            INSERT INTO reviews (user_id, event_id, rating, comment, is_verified)
            VALUES (%s, %s, %s, %s, %s)
        """, (rev.user_id, rev.event_id, rev.rating, rev.comment, is_verified))

    conn.commit()
    conn.close()
    return {"mesaj": "Yorum eklendi", "dogrulanmis": is_verified}

@app.get("/yorumlar/{artwork_id}")
def yorumlar(artwork_id: int, siralama: str = "yeni"):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    order_map = {
        "yeni": "r.created_at DESC",
        "puan": "r.rating DESC",
        "faydali": "helpful_count DESC"
    }
    order = order_map.get(siralama, "r.created_at DESC")
    cursor.execute(f"""
        SELECT r.*, u.full_name as user_name,
               COUNT(rv.id) as helpful_count,
               ra.reply as admin_reply, ra.created_at as reply_date
        FROM reviews r
        LEFT JOIN users u ON r.user_id = u.id
        LEFT JOIN review_votes rv ON rv.review_id = r.id AND rv.is_helpful = 1
        LEFT JOIN review_replies ra ON ra.review_id = r.id
        WHERE r.artwork_id = %s
        GROUP BY r.id
        ORDER BY {order}
    """, (artwork_id,))
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/etkinlik-yorumlari/{event_id}")
def etkinlik_yorumlari(event_id: int, siralama: str = "yeni"):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    order_map = {
        "yeni": "r.created_at DESC",
        "puan": "r.rating DESC",
        "faydali": "helpful_count DESC"
    }
    order = order_map.get(siralama, "r.created_at DESC")
    cursor.execute(f"""
        SELECT r.*, u.full_name as user_name,
               COUNT(rv.id) as helpful_count,
               ra.reply as admin_reply, ra.created_at as reply_date
        FROM reviews r
        LEFT JOIN users u ON r.user_id = u.id
        LEFT JOIN review_votes rv ON rv.review_id = r.id AND rv.is_helpful = 1
        LEFT JOIN review_replies ra ON ra.review_id = r.id
        WHERE r.event_id = %s
        GROUP BY r.id
        ORDER BY {order}
    """, (event_id,))
    res = cursor.fetchall()
    conn.close()
    return res

# ─── MADDE 13: YORUMLARI DEĞERLENDİRME ─────────────────────
@app.post("/yorum-oy")
def yorum_oy(vote: ReviewVote, current_user=Depends(token_coz)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id FROM review_votes WHERE review_id=%s AND user_id=%s", (vote.review_id, vote.user_id))
    if cursor.fetchone():
        cursor.execute("UPDATE review_votes SET is_helpful=%s WHERE review_id=%s AND user_id=%s",
                       (vote.is_helpful, vote.review_id, vote.user_id))
    else:
        cursor.execute("INSERT INTO review_votes (review_id, user_id, is_helpful) VALUES (%s, %s, %s)",
                       (vote.review_id, vote.user_id, vote.is_helpful))
    conn.commit()
    conn.close()
    return {"mesaj": "Oy kaydedildi"}

@app.get("/ortalama-puan/{artwork_id}")
def ortalama_puan(artwork_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT COALESCE(AVG(rating), 0) as avg, COUNT(*) as total,
               SUM(CASE WHEN rating=5 THEN 1 ELSE 0 END) as r5,
               SUM(CASE WHEN rating=4 THEN 1 ELSE 0 END) as r4,
               SUM(CASE WHEN rating=3 THEN 1 ELSE 0 END) as r3,
               SUM(CASE WHEN rating=2 THEN 1 ELSE 0 END) as r2,
               SUM(CASE WHEN rating=1 THEN 1 ELSE 0 END) as r1
        FROM reviews WHERE artwork_id=%s
    """, (artwork_id,))
    res = cursor.fetchone()
    conn.close()
    return res

# ─── MADDE 14: YORUMLARA YANIT VERME ───────────────────────
@app.post("/yorum-yanit")
def yorum_yanit(rep: ReviewReply, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO review_replies (review_id, admin_id, reply)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE reply=%s, updated_at=NOW()
    """, (rep.review_id, rep.admin_id, rep.reply, rep.reply))
    conn.commit()
    conn.close()
    return {"mesaj": "Yanıt eklendi"}

# ─── MADDE 15: DOĞRULAMA VE GÜVENİLİRLİK ──────────────────
@app.get("/katilim-kontrol/{user_id}/{event_id}")
def katilim_kontrol(user_id: int, event_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT id FROM reservations
        WHERE user_id=%s AND event_id=%s AND status='onaylandı'
    """, (user_id, event_id))
    res = cursor.fetchone()
    conn.close()
    return {"katildi": res is not None}

@app.get("/satin-alim-kontrol/{user_id}/{artwork_id}")
def satin_alim_kontrol(user_id: int, artwork_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT id FROM orders
        WHERE user_id=%s AND artwork_id=%s AND status='onaylandı'
    """, (user_id, artwork_id))
    res = cursor.fetchone()
    conn.close()
    return {"satin_aldi": res is not None}

# ─── MADDE 16: İSTATİSTİK VE RAPORLAMA ─────────────────────
@app.get("/istatistik")
def istatistik():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT a.id, a.title, a.price,
               ar.name as artist_name, c.name as category_name,
               COUNT(DISTINCT r.id) as review_count,
               COALESCE(AVG(r.rating), 0) as avg_rating,
               COUNT(DISTINCT f.id) as favorite_count,
               COUNT(DISTINCT v.id) as view_count,
               COUNT(DISTINCT o.id) as sale_count
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        LEFT JOIN categories c ON a.category_id = c.id
        LEFT JOIN reviews r ON r.artwork_id = a.id
        LEFT JOIN favorites f ON f.artwork_id = a.id
        LEFT JOIN artwork_views v ON v.artwork_id = a.id
        LEFT JOIN orders o ON o.artwork_id = a.id AND o.status='onaylandı'
        GROUP BY a.id
        ORDER BY a.price DESC
    """)
    eserler = cursor.fetchall()

    cursor.execute("""
        SELECT e.id, e.title, e.capacity, e.price, e.event_date,
               (SELECT COUNT(id) FROM reservations r WHERE r.event_id = e.id AND r.status != 'iptal') as reserved_count,
               (SELECT COALESCE(SUM(participant_count), 0) FROM reservations r WHERE r.event_id = e.id AND r.status != 'iptal') as total_participants,
               (SELECT COALESCE(AVG(rating), 0) FROM reviews rv WHERE rv.event_id = e.id) as avg_rating,
               (SELECT COUNT(id) FROM reviews rv WHERE rv.event_id = e.id) as review_count
        FROM events e
    """)
    etkinlikler = cursor.fetchall()

    cursor.execute("SELECT COUNT(*) as total FROM users")
    toplam_kullanici = cursor.fetchone()['total']

    cursor.execute("SELECT COALESCE(SUM(amount), 0) as toplam FROM orders WHERE status='onaylandı'")
    toplam_ciro = cursor.fetchone()['toplam']

    conn.close()
    return {
        "eserler": eserler,
        "etkinlikler": etkinlikler,
        "toplam_kullanici": toplam_kullanici,
        "toplam_ciro": float(toplam_ciro)
    }

# ─── ADMIN ENDPOINTLERİ ─────────────────────────────────────

class ArtworkCreate(BaseModel):
    title: str
    price: float
    artist_id: Optional[int] = None
    category_id: Optional[int] = None
    description: Optional[str] = None
    year_created: Optional[int] = None
    medium: Optional[str] = None
    dimensions: Optional[str] = None
    discount_percent: int = 0
    stock: int = 1
    image_url: Optional[str] = None

@app.get("/sanatcilar")
def sanatcilar():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name FROM artists ORDER BY name ASC")
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/kategoriler")
def kategoriler():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name FROM categories ORDER BY name ASC")
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/images-listesi")
def images_listesi():
    """images/ klasöründeki tüm resim dosyalarını döndürür"""
    allowed_ext = {".jpg", ".jpeg", ".png", ".gif", ".webp"}
    try:
        files = [
            f for f in os.listdir(IMAGES_DIR)
            if os.path.splitext(f.lower())[1] in allowed_ext
        ]
        files.sort()
        return {"images": files}
    except FileNotFoundError:
        return {"images": []}

@app.post("/admin/resim-yukle")
async def resim_yukle(file: UploadFile = File(...), current_user=Depends(admin_mi)):
    """Admin panelinden resim yükler, images/ klasörüne kaydeder"""
    allowed_ext = {".jpg", ".jpeg", ".png", ".gif", ".webp"}
    ext = os.path.splitext(file.filename.lower())[1]
    if ext not in allowed_ext:
        raise HTTPException(status_code=400, detail="Sadece jpg, png, gif, webp yüklenebilir")
    filename = f"{uuid.uuid4().hex}{ext}"
    dest = os.path.join(IMAGES_DIR, filename)
    with open(dest, "wb") as f:
        shutil.copyfileobj(file.file, f)
    return {"filename": filename}

class ArtistCreate(BaseModel):
    name: str
    bio: Optional[str] = None
    birth_year: Optional[int] = None
    nationality: Optional[str] = None

@app.post("/admin/sanatci-ekle")
def admin_sanatci_ekle(a: ArtistCreate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id FROM artists WHERE name=%s", (a.name,))
    existing = cursor.fetchone()
    if existing:
        conn.close()
        return {"mesaj": "Sanatçı zaten mevcut", "artist_id": existing["id"]}
    cursor.execute(
        "INSERT INTO artists (name, bio, birth_year, nationality) VALUES (%s, %s, %s, %s)",
        (a.name, a.bio, a.birth_year, a.nationality)
    )
    conn.commit()
    aid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Sanatçı eklendi", "artist_id": aid}

class EventCreate(BaseModel):
    title: str
    event_type: str = "atolye"
    event_date: str
    capacity: int
    price: float = 0
    location: Optional[str] = None
    description: Optional[str] = None
    image_url: Optional[str] = None

class CategoryCreate(BaseModel):
    name: str

@app.post("/admin/kategori-ekle")
def admin_kategori_ekle(c: CategoryCreate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id FROM categories WHERE name=%s", (c.name,))
    existing = cursor.fetchone()
    if existing:
        conn.close()
        return {"mesaj": "Kategori zaten mevcut", "category_id": existing["id"]}
    cursor.execute("INSERT INTO categories (name) VALUES (%s)", (c.name,))
    conn.commit()
    cid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Kategori eklendi", "category_id": cid}

@app.get("/admin/kullanicilar")
def admin_kullanicilar(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, full_name, email, role, created_at FROM users ORDER BY id DESC")
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/admin/siparisler")
def admin_siparisler(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT o.*, u.full_name as user_name,
               a.title as artwork_title, e.title as event_title
        FROM orders o
        LEFT JOIN users u ON o.user_id = u.id
        LEFT JOIN artworks a ON o.artwork_id = a.id
        LEFT JOIN events e ON o.event_id = e.id
        ORDER BY o.created_at DESC
    """)
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/admin/yorumlar")
def admin_yorumlar(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT r.*, u.full_name as user_name,
               a.title as artwork_title, ev.title as event_title,
               rr.reply as admin_reply
        FROM reviews r
        LEFT JOIN users u ON r.user_id = u.id
        LEFT JOIN artworks a ON r.artwork_id = a.id
        LEFT JOIN events ev ON r.event_id = ev.id
        LEFT JOIN review_replies rr ON rr.review_id = r.id
        ORDER BY r.created_at DESC
    """)
    res = cursor.fetchall()
    conn.close()
    return res

@app.get("/admin/destek-talepleri")
def admin_destek_talepleri(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM support_tickets ORDER BY created_at DESC")
    res = cursor.fetchall()
    conn.close()
    return res

@app.post("/admin/eser-ekle")
def admin_eser_ekle(aw: ArtworkCreate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO artworks (title, price, artist_id, category_id, description, year_created, medium, dimensions, discount_percent, stock, image_url)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (aw.title, aw.price, aw.artist_id, aw.category_id, aw.description, aw.year_created, aw.medium, aw.dimensions, aw.discount_percent, aw.stock, aw.image_url))
    conn.commit()
    aid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Eser eklendi", "artwork_id": aid}

@app.post("/admin/etkinlik-ekle")
def admin_etkinlik_ekle(ev: EventCreate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO events (title, event_type, event_date, capacity, price, location, description, image_url)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """, (ev.title, ev.event_type, ev.event_date, ev.capacity, ev.price, ev.location, ev.description, ev.image_url))
    conn.commit()
    eid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Etkinlik eklendi", "event_id": eid}

# ─── ADMIN: SİLME & GÜNCELLEME ENDPOINTLERİ ──────────────────────────

class ArtworkUpdate(BaseModel):
    title: Optional[str] = None
    price: Optional[float] = None
    artist_id: Optional[int] = None
    category_id: Optional[int] = None
    description: Optional[str] = None
    discount_percent: Optional[int] = None
    stock: Optional[int] = None
    image_url: Optional[str] = None

class EventUpdate(BaseModel):
    title: Optional[str] = None
    event_type: Optional[str] = None
    event_date: Optional[str] = None
    capacity: Optional[int] = None
    price: Optional[float] = None
    location: Optional[str] = None
    description: Optional[str] = None
    discount_percent: Optional[int] = None

class UserRoleUpdate(BaseModel):
    role: str

class OrderStatusUpdate(BaseModel):
    status: str

class TicketStatusUpdate(BaseModel):
    status: str

class CouponCreate(BaseModel):
    code: str
    discount_percent: int
    is_public: int = 1
    expires_at: Optional[str] = None
    description: Optional[str] = None

# Eser güncelle
@app.put("/admin/eser-guncelle/{artwork_id}")
def admin_eser_guncelle(artwork_id: int, aw: ArtworkUpdate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    fields, vals = [], []
    if aw.title is not None:            fields.append("title=%s");            vals.append(aw.title)
    if aw.price is not None:            fields.append("price=%s");            vals.append(aw.price)
    if aw.artist_id is not None:        fields.append("artist_id=%s");        vals.append(aw.artist_id)
    if aw.category_id is not None:      fields.append("category_id=%s");      vals.append(aw.category_id)
    if aw.description is not None:      fields.append("description=%s");      vals.append(aw.description)
    if aw.discount_percent is not None: fields.append("discount_percent=%s"); vals.append(aw.discount_percent)
    if aw.stock is not None:            fields.append("stock=%s");            vals.append(aw.stock)
    if aw.image_url is not None:        fields.append("image_url=%s");        vals.append(aw.image_url)
    if not fields:
        conn.close()
        return {"mesaj": "Güncellenecek alan yok"}
    vals.append(artwork_id)
    cursor.execute(f"UPDATE artworks SET {', '.join(fields)} WHERE id=%s", vals)
    conn.commit()
    conn.close()
    return {"mesaj": "Eser güncellendi"}

# Eser sil
@app.delete("/admin/eser-sil/{artwork_id}")
def admin_eser_sil(artwork_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    # Bağımlı kayıtları temizle
    cursor.execute("DELETE FROM favorites WHERE artwork_id=%s", (artwork_id,))
    cursor.execute("DELETE FROM review_votes WHERE review_id IN (SELECT id FROM reviews WHERE artwork_id=%s)", (artwork_id,))
    cursor.execute("DELETE FROM review_replies WHERE review_id IN (SELECT id FROM reviews WHERE artwork_id=%s)", (artwork_id,))
    cursor.execute("DELETE FROM reviews WHERE artwork_id=%s", (artwork_id,))
    cursor.execute("DELETE FROM artwork_views WHERE artwork_id=%s", (artwork_id,))
    cursor.execute("UPDATE orders SET artwork_id=NULL WHERE artwork_id=%s", (artwork_id,))
    cursor.execute("DELETE FROM artworks WHERE id=%s", (artwork_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Eser silindi"}

# Etkinlik güncelle
@app.put("/admin/etkinlik-guncelle/{event_id}")
def admin_etkinlik_guncelle(event_id: int, ev: EventUpdate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    fields, vals = [], []
    if ev.title is not None:            fields.append("title=%s");            vals.append(ev.title)
    if ev.event_type is not None:       fields.append("event_type=%s");       vals.append(ev.event_type)
    if ev.event_date is not None:       fields.append("event_date=%s");       vals.append(ev.event_date)
    if ev.capacity is not None:         fields.append("capacity=%s");         vals.append(ev.capacity)
    if ev.price is not None:            fields.append("price=%s");            vals.append(ev.price)
    if ev.location is not None:         fields.append("location=%s");         vals.append(ev.location)
    if ev.description is not None:      fields.append("description=%s");      vals.append(ev.description)
    if ev.discount_percent is not None: fields.append("discount_percent=%s"); vals.append(ev.discount_percent)
    if not fields:
        conn.close()
        return {"mesaj": "Güncellenecek alan yok"}
    vals.append(event_id)
    cursor.execute(f"UPDATE events SET {', '.join(fields)} WHERE id=%s", vals)
    conn.commit()
    conn.close()
    return {"mesaj": "Etkinlik güncellendi"}

# Etkinlik sil
@app.delete("/admin/etkinlik-sil/{event_id}")
def admin_etkinlik_sil(event_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM review_votes WHERE review_id IN (SELECT id FROM reviews WHERE event_id=%s)", (event_id,))
    cursor.execute("DELETE FROM review_replies WHERE review_id IN (SELECT id FROM reviews WHERE event_id=%s)", (event_id,))
    cursor.execute("DELETE FROM reviews WHERE event_id=%s", (event_id,))
    cursor.execute("DELETE FROM reservations WHERE event_id=%s", (event_id,))
    cursor.execute("UPDATE orders SET event_id=NULL WHERE event_id=%s", (event_id,))
    cursor.execute("DELETE FROM events WHERE id=%s", (event_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Etkinlik silindi"}

# Kullanıcı sil
@app.delete("/admin/kullanici-sil/{user_id}")
def admin_kullanici_sil(user_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM review_votes WHERE user_id=%s", (user_id,))
    cursor.execute("DELETE FROM review_replies WHERE admin_id=%s", (user_id,))
    cursor.execute("DELETE FROM review_votes WHERE review_id IN (SELECT id FROM reviews WHERE user_id=%s)", (user_id,))
    cursor.execute("DELETE FROM review_replies WHERE review_id IN (SELECT id FROM reviews WHERE user_id=%s)", (user_id,))
    cursor.execute("DELETE FROM reviews WHERE user_id=%s", (user_id,))
    cursor.execute("DELETE FROM favorites WHERE user_id=%s", (user_id,))
    cursor.execute("DELETE FROM reservations WHERE user_id=%s", (user_id,))
    cursor.execute("DELETE FROM orders WHERE user_id=%s", (user_id,))
    cursor.execute("DELETE FROM support_tickets WHERE user_id=%s", (user_id,))
    cursor.execute("DELETE FROM users WHERE id=%s", (user_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Kullanıcı silindi"}

# Kullanıcı rolü değiştir
@app.put("/admin/kullanici-rol/{user_id}")
def admin_kullanici_rol(user_id: int, upd: UserRoleUpdate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE users SET role=%s WHERE id=%s", (upd.role, user_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Rol güncellendi"}

# Sipariş durumu güncelle
@app.put("/admin/siparis-durum/{order_id}")
def admin_siparis_durum(order_id: int, upd: OrderStatusUpdate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE orders SET status=%s WHERE id=%s", (upd.status, order_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Sipariş durumu güncellendi"}

# Sipariş sil
@app.delete("/admin/siparis-sil/{order_id}")
def admin_siparis_sil(order_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM orders WHERE id=%s", (order_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Sipariş silindi"}

# Yorum sil
@app.delete("/admin/yorum-sil/{review_id}")
def admin_yorum_sil(review_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM review_votes WHERE review_id=%s", (review_id,))
    cursor.execute("DELETE FROM review_replies WHERE review_id=%s", (review_id,))
    cursor.execute("DELETE FROM reviews WHERE id=%s", (review_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Yorum silindi"}

# Destek talebi durum güncelle
@app.put("/admin/ticket-durum/{ticket_id}")
def admin_ticket_durum(ticket_id: int, upd: TicketStatusUpdate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE support_tickets SET status=%s WHERE id=%s", (upd.status, ticket_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Talep durumu güncellendi"}

# Destek talebi cevapla
class TicketReply(BaseModel):
    reply: str

@app.put("/admin/ticket-cevapla/{ticket_id}")
def admin_ticket_cevapla(ticket_id: int, rep: TicketReply, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE support_tickets SET admin_reply=%s, replied_at=NOW(), status='kapatıldı' WHERE id=%s",
        (rep.reply, ticket_id)
    )
    conn.commit()
    conn.close()
    return {"mesaj": "Cevap gönderildi"}

# Destek talebi sil
@app.delete("/admin/ticket-sil/{ticket_id}")
def admin_ticket_sil(ticket_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM support_tickets WHERE id=%s", (ticket_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Destek talebi silindi"}

# Kupon ekle
@app.post("/admin/kupon-ekle")
def admin_kupon_ekle(c: CouponCreate, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO coupons (code, discount_percent, is_active, is_public, expires_at, description)
        VALUES (%s, %s, 1, %s, %s, %s)
    """, (c.code, c.discount_percent, c.is_public, c.expires_at, c.description))
    conn.commit()
    cid = cursor.lastrowid
    conn.close()
    return {"mesaj": "Kupon eklendi", "coupon_id": cid}

# Kupon sil
@app.delete("/admin/kupon-sil/{coupon_id}")
def admin_kupon_sil(coupon_id: int, current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM coupons WHERE id=%s", (coupon_id,))
    conn.commit()
    conn.close()
    return {"mesaj": "Kupon silindi"}

# Tüm kuponları listele (admin için)
@app.get("/admin/kuponlar")
def admin_kuponlar(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM coupons ORDER BY id DESC")
    res = cursor.fetchall()
    conn.close()
    return res

# Tüm rezervasyonları listele (admin)
@app.get("/admin/rezervasyonlar")
def admin_rezervasyonlar(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT r.*, u.full_name as user_name, e.title as event_title, e.event_date
        FROM reservations r
        LEFT JOIN users u ON r.user_id = u.id
        LEFT JOIN events e ON r.event_id = e.id
        ORDER BY r.created_at DESC
    """)
    res = cursor.fetchall()
    conn.close()
    return res

# Rezervasyon durum güncelle (admin)
@app.put("/admin/rezervasyon-durum/{reservation_id}")
def admin_rezervasyon_durum(reservation_id: int, upd: dict, current_user=Depends(admin_mi)):
    status = upd.get("status")
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE reservations SET status=%s WHERE id=%s", (status, reservation_id))
    conn.commit()
    conn.close()
    return {"mesaj": "Rezervasyon durumu güncellendi"}

# ─── ADMIN: ÖZET RAPOR ──────────────────────────────────────
# Bu kodu main.py'nin EN SONUNA ekle (son satırdan önce)

@app.get("/admin/rapor")
def admin_rapor(current_user=Depends(admin_mi)):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Genel özet
    cursor.execute("SELECT COUNT(*) as toplam FROM users WHERE role='kullanici'")
    toplam_kullanici = cursor.fetchone()['toplam']

    cursor.execute("SELECT COUNT(*) as toplam FROM artworks")
    toplam_eser = cursor.fetchone()['toplam']

    cursor.execute("SELECT COUNT(*) as toplam FROM events")
    toplam_etkinlik = cursor.fetchone()['toplam']

    cursor.execute("SELECT COALESCE(SUM(amount), 0) as toplam FROM orders WHERE status='onaylandı'")
    toplam_ciro = float(cursor.fetchone()['toplam'])

    cursor.execute("SELECT COUNT(*) as toplam FROM orders WHERE status='onaylandı'")
    toplam_siparis = cursor.fetchone()['toplam']

    cursor.execute("SELECT COALESCE(SUM(participant_count), 0) as toplam FROM reservations WHERE status='onaylandı'")
    toplam_rezervasyon = cursor.fetchone()['toplam']

    cursor.execute("SELECT COUNT(*) as toplam FROM support_tickets WHERE status='açık'")
    acik_talepler = cursor.fetchone()['toplam']

    cursor.execute("SELECT COUNT(*) as toplam FROM reviews")
    toplam_yorum = cursor.fetchone()['toplam']

    # En çok satan 5 eser
    cursor.execute("""
        SELECT a.title, ar.name as artist_name, COUNT(o.id) as satis_adedi,
               COALESCE(SUM(o.amount), 0) as toplam_gelir
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        LEFT JOIN orders o ON o.artwork_id = a.id AND o.status='onaylandı'
        GROUP BY a.id
        ORDER BY satis_adedi DESC
        LIMIT 5
    """)
    en_cok_satan = cursor.fetchall()

    # En popüler 5 etkinlik
    cursor.execute("""
        SELECT e.title, e.event_type, e.event_date,
               COUNT(r.id) as rezervasyon_sayisi,
               COALESCE(SUM(r.participant_count), 0) as toplam_katilimci
        FROM events e
        LEFT JOIN reservations r ON r.event_id = e.id AND r.status != 'iptal'
        GROUP BY e.id
        ORDER BY rezervasyon_sayisi DESC
        LIMIT 5
    """)
    en_populer_etkinlik = cursor.fetchall()

    # Aylık ciro (son 6 ay)
    cursor.execute("""
        SELECT DATE_FORMAT(created_at, '%Y-%m') as ay,
               COALESCE(SUM(amount), 0) as ciro,
               COUNT(*) as siparis_sayisi
        FROM orders
        WHERE status='onaylandı'
          AND created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
        GROUP BY ay
        ORDER BY ay ASC
    """)
    aylik_ciro = cursor.fetchall()

    # Kategori bazlı satış
    cursor.execute("""
        SELECT c.name as kategori,
               COUNT(o.id) as satis_adedi,
               COALESCE(SUM(o.amount), 0) as toplam_gelir
        FROM categories c
        LEFT JOIN artworks a ON a.category_id = c.id
        LEFT JOIN orders o ON o.artwork_id = a.id AND o.status='onaylandı'
        GROUP BY c.id
        ORDER BY toplam_gelir DESC
    """)
    kategori_satis = cursor.fetchall()

    # Son 5 sipariş
    cursor.execute("""
        SELECT o.id, o.amount, o.status, o.created_at,
               u.full_name as musteri,
               COALESCE(a.title, e.title) as urun
        FROM orders o
        LEFT JOIN users u ON o.user_id = u.id
        LEFT JOIN artworks a ON o.artwork_id = a.id
        LEFT JOIN events e ON o.event_id = e.id
        ORDER BY o.created_at DESC
        LIMIT 5
    """)
    son_siparisler = cursor.fetchall()

    # En çok görüntülenen eserler
    cursor.execute("""
        SELECT a.title, ar.name as artist_name,
               COUNT(v.id) as goruntuleme
        FROM artworks a
        LEFT JOIN artists ar ON a.artist_id = ar.id
        LEFT JOIN artwork_views v ON v.artwork_id = a.id
        GROUP BY a.id
        ORDER BY goruntuleme DESC
        LIMIT 5
    """)
    en_cok_gorutulen = cursor.fetchall()

    conn.close()

    return {
        "ozet": {
            "toplam_kullanici": toplam_kullanici,
            "toplam_eser": toplam_eser,
            "toplam_etkinlik": toplam_etkinlik,
            "toplam_ciro": toplam_ciro,
            "toplam_siparis": toplam_siparis,
            "toplam_rezervasyon": toplam_rezervasyon,
            "acik_talepler": acik_talepler,
            "toplam_yorum": toplam_yorum,
        },
        "en_cok_satan": [
            {**r, "toplam_gelir": float(r["toplam_gelir"])} for r in en_cok_satan
        ],
        "en_populer_etkinlik": en_populer_etkinlik,
        "aylik_ciro": [
            {**r, "ciro": float(r["ciro"])} for r in aylik_ciro
        ],
        "kategori_satis": [
            {**r, "toplam_gelir": float(r["toplam_gelir"])} for r in kategori_satis
        ],
        "son_siparisler": [
            {**r, "amount": float(r["amount"])} for r in son_siparisler
        ],
        "en_cok_gorutulen": en_cok_gorutulen,
    }
