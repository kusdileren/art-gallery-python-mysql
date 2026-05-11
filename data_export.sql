-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sanat_galerisi
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci,
  `birth_year` int DEFAULT NULL,
  `nationality` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'Leonardo da Vinci','Italyan Ronesans ustasi. Ressam, bilim insani ve mucit.',1452,'İtalyan'),(2,'Vincent van Gogh','Post-empresyonizmin öncüsü. Canli renkleri ve yogun firca darbeleriyle taninir.',1853,'Hollandalı'),(3,'Edvard Munch','Ekspresyonizmin öncüsü, varoluşsal kaygılariyla taninan Norvecli ressam.',1863,'Norveçli'),(4,'Raphael','Ronesansin uc büyük ustasindan biri; denge ve armoni sembolü.',1483,'İtalyan'),(5,'Michelangelo','Ronesansin dehasi; Sistine Sapeli tavani ve heykeltrasligiyla ünlü.',1475,'İtalyan'),(6,'Salvador Dali','Sürrealizmin en taninan ismi; bilincdisi ve rüya imgelerini tuvallestirdi.',1904,'İspanyol'),(7,'Gustav Klimt','Viyana Sezesyon hareketinin önderi; altin yaprak kullanimiyla ünlü.',1862,'Avusturyalı'),(8,'Sandro Botticelli','Italyan Erken Ronesans ustasi; mitolojik sahneleriyle taninir.',1445,'İtalyan'),(9,'Osman Hamdi Bey','Osmanli döneminin önemli ressami ve müzeci.',1842,'Türk'),(10,'Zerhaki','Pixelart sanatçısı',2004,'Türk'),(11,'İbrahim Çallı','Türk resminde Çallı Kuşağı olarak bilinen akımın öncüsü, bağımsızlık ruhunu yansıtan usta.',1882,'Türk'),(12,'Claude Monet','Empresyonizm (İzlenimcilik) akımının isim babası ve kurucusu.',1840,'Fransız'),(13,'Pablo Picasso','Kübizm akımının yaratıcısı, 20. yüzyılın en üretken dehası.',1881,'İspanyol'),(14,'Johannes Vermeer','Işığı ustalıkla kullanan Hollandalı Barok ressamı.',1632,'Hollandalı'),(15,'Frida Kahlo','Kendi acılarını ve kültürünü yansıtan sürrealist ikon.',1907,'Meksikalı'),(16,'Rembrandt','Işığın ve gölgelerin efendisi, Hollanda Altın Çağı ressamı.',1606,'Hollandalı');
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artwork_views`
--

DROP TABLE IF EXISTS `artwork_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artwork_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artwork_id` int NOT NULL,
  `viewed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `artwork_views_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artwork_views`
--

LOCK TABLES `artwork_views` WRITE;
/*!40000 ALTER TABLE `artwork_views` DISABLE KEYS */;
INSERT INTO `artwork_views` VALUES (1,1,'2026-05-09 19:27:38'),(2,1,'2026-05-09 19:27:38'),(3,1,'2026-05-09 19:27:38'),(4,1,'2026-05-09 19:27:38'),(5,1,'2026-05-09 19:27:38'),(6,2,'2026-05-09 19:27:38'),(7,2,'2026-05-09 19:27:38'),(8,2,'2026-05-09 19:27:38'),(9,3,'2026-05-09 19:27:38'),(10,3,'2026-05-09 19:27:38'),(11,4,'2026-05-09 19:27:38'),(12,4,'2026-05-09 19:27:38'),(13,4,'2026-05-09 19:27:38'),(14,5,'2026-05-09 19:27:38'),(15,5,'2026-05-09 19:27:38'),(16,6,'2026-05-09 19:27:38'),(17,7,'2026-05-09 19:27:38'),(18,7,'2026-05-09 19:27:38'),(19,8,'2026-05-09 19:27:38'),(20,9,'2026-05-09 19:27:38'),(21,10,'2026-05-09 19:27:38'),(22,11,'2026-05-09 19:27:38');
/*!40000 ALTER TABLE `artwork_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artworks`
--

DROP TABLE IF EXISTS `artworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artworks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `artist_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci,
  `price` decimal(12,2) NOT NULL,
  `image_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `year_created` int DEFAULT NULL,
  `medium` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `dimensions` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `discount_percent` int DEFAULT '0',
  `stock` int DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `artworks_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  CONSTRAINT `artworks_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artworks`
--

LOCK TABLES `artworks` WRITE;
/*!40000 ALTER TABLE `artworks` DISABLE KEYS */;
INSERT INTO `artworks` VALUES (1,'Mona Lisa',1,1,'Dünyanın en tanınan tablosu. Gizemli gülüşüyle yüzyıllardır büyülüyor.',150000.00,'Mona_Lisa.jpg',1503,'Yağlıboya','77x53 cm',0,3,'2026-05-09 19:27:38'),(2,'Yıldızlı Gece',2,2,'Sarmal bulutlar ve parlak yıldızlarla dolu mistik bir gece manzarası.',120000.00,'Yildizli_Gece.jpg',1889,'Yağlıboya','73x92 cm',10,1,'2026-05-09 19:27:38'),(3,'Çığlık',3,3,'Modern insanın varoluşsal kaygısını simgeleyen ikonik ekspresyonist şaheser.',180000.00,'ciglik.jpg',1893,'Yağlıboya ve pastel','91x73 cm',0,1,'2026-05-09 19:27:38'),(4,'Atina Okulu',4,1,'Antik Yunan filozoflarini bir arada gösteren Ronesansin en büyük fresklerinden biri.',250000.00,'atina_okulu.jpg',1511,'Fresk','500x770 cm',5,1,'2026-05-09 19:27:38'),(5,'Ademin Yaratilisi',5,1,'Sistine Sapeli tavanindaki ikonik sahne; Tanri ile Ademin parmak uclarinin bulusmasi.',300000.00,'adem_yaratilis.jpg',1512,'Fresk','280x570 cm',0,1,'2026-05-09 19:27:38'),(6,'Bellegin Azmi',6,4,'Eriyen saatlerle zamanın göreceliğini sorgulayan sürrealizmin simge tablosu.',220000.00,'bellegin_azmi.jpg',1931,'Yağlıboya','24x33 cm',15,1,'2026-05-09 19:27:38'),(7,'Öpücük',7,5,'Altin yapraklara sarılmış, birbirine kavuşmuş iki figürü yansıtan romantik şaheser.',195000.00,'opucuk.jpg',1908,'Yağlıboya ve altin yaprak','180x180 cm',0,1,'2026-05-09 19:27:38'),(8,'Venüsün Dogusu',8,1,'Denizden cikan güzellik tanrıçasını betimleyen Botticellinin basyapiti.',175000.00,'venusun_dogusu.jpg',1485,'Tempera','172x278 cm',10,1,'2026-05-09 19:27:38'),(9,'Kaplumbağa Terbiyecisi',9,6,'Osmanlı kültüründen bir sahne. Milli Saraylar koleksiyonunun gözbebeği.',95000.00,'Kaplumbaga_terbiyecisi.jpg',1906,'Yağlıboya','221x320 cm',15,1,'2026-05-09 19:27:38'),(10,'Son Aksam Yemegi',1,1,'Isa ve havarileri son yemekte gösteren anitsal Ronesans eseri.',280000.00,'son_aksam_yemegi.jpg',1498,'Tempera ve yağlıboya','460x880 cm',0,1,'2026-05-09 19:27:38'),(11,'Galeri No. 13',NULL,7,'Cagdas Türk sanatından soyut bir kompozisyon; renk ve form dengesiyle dikkat cekiyor.',45000.00,'galeri_13.jpg',2020,'Akrilik','100x100 cm',20,3,'2026-05-09 19:27:38'),(12,'Karanlığın Çağrısı',10,8,'Sanatçının acemilik dönemi eseri',100.00,'karanlıgın_cagrisi.png',2020,'Pixel','100x100',0,1000,'2026-05-09 19:46:08'),(13,'Mustafa Kemal Atatürk Portresi',11,6,'Cumhuriyet tarihinin en önemli siyasi ve askeri lideri olan Gazi Mustafa Kemal Atatürk\'ün bu eşsiz portresi, dönemin vizyonunu ve kararlılığını tuvale yansıtıyor.',150000.00,'ataturk_portre.jpg',1930,'Yağlıboya','100x80 cm',0,1,'2026-05-11 00:30:29'),(14,'Zeybekler Kurtuluş Savaşı\'nda',11,6,'Milli Mücadele yıllarının fedakarlıklarını ve Anadolu insanının direnişini resmeden destansı bir çalışma.',180000.00,'zeybekler.jpg',1923,'Yağlıboya','150x200 cm',5,1,'2026-05-11 00:30:29'),(15,'Celile Hanım Portresi',9,6,'Osman Hamdi Bey\'in fırçasından, dönemin zarafetini yansıtan çok özel bir portre çalışması.',85000.00,'celile_hanim.jpg',1885,'Yağlıboya','60x45 cm',0,1,'2026-05-11 00:30:29'),(16,'İnci Küpeli Kız',14,11,'Kuzeyin Mona Lisası olarak bilinen, ışığın ve masumiyetin muazzam bir tasviri.',450000.00,'inci_kupeli.jpg',1665,'Yağlıboya','44x39 cm',0,1,'2026-05-11 00:30:29'),(17,'Süt Döken Kadın',14,11,'Gündelik bir anın Barok ışığı altında nasıl şahesere dönüştüğünün kanıtı.',320000.00,'sut_doken.jpg',1658,'Yağlıboya','45x41 cm',10,1,'2026-05-11 00:30:29'),(18,'Gece Devriyesi',16,11,'Hareket ve ışık kullanımında çığır açan devasa boyutlu bir askeri birlik tablosu.',850000.00,'gece_devriyesi.jpg',1642,'Yağlıboya','363x437 cm',0,1,'2026-05-11 00:30:29'),(19,'İzlenim: Gün Doğumu',12,9,'Tüm bir sanat akımına adını veren, sise gömülmüş bir liman manzarası.',280000.00,'gun_dogumu.jpg',1872,'Yağlıboya','48x63 cm',15,1,'2026-05-11 00:30:29'),(20,'Nilüferler',12,9,'Monet\'nin kendi bahçesindeki su zambaklarını resmettiği huzur dolu kompozisyon.',350000.00,'niluferler.jpg',1919,'Yağlıboya','100x200 cm',0,1,'2026-05-11 00:30:29'),(21,'Guernica',13,10,'Savaşın yıkıcılığını ve hüznünü geometrik formlarla anlatan anıtsal bir çığlık.',950000.00,'guernica.jpg',1937,'Yağlıboya','349x776 cm',0,1,'2026-05-11 00:30:29'),(22,'Avignonlu Kızlar',13,10,'Modern sanatın doğuşunu müjdeleyen, perspektifin parçalandığı devrim niteliğinde bir eser.',650000.00,'avignon.jpg',1907,'Yağlıboya','243x233 cm',10,1,'2026-05-11 00:30:29'),(23,'Ağlayan Kadın',13,10,'Dora Maar\'ın yüzündeki hüznün kübist bir parçalanmayla tuvale aktarımı.',420000.00,'aglayan_kadin.jpg',1937,'Yağlıboya','60x49 cm',0,1,'2026-05-11 00:30:29'),(24,'İki Frida',15,4,'Sanatçının içsel bölünmüşlüğünü ve kimlik çatışmasını anlatan çifte otoportre.',380000.00,'iki_frida.jpg',1939,'Yağlıboya','173x173 cm',0,1,'2026-05-11 00:30:29'),(25,'Dikenli Kolye ile Otoportre',15,4,'Meksika ormanının gizemini ve sanatçının fiziksel acılarını simgeleyen ikonik eser.',290000.00,'frida_dikenli.jpg',1940,'Yağlıboya','61x47 cm',20,1,'2026-05-11 00:30:29'),(26,'Uyku',6,4,'Bilinçaltının derinliklerindeki rüyaların gerçeküstü bir dille yorumlanması.',310000.00,'uyku_dali.jpg',1937,'Yağlıboya','51x78 cm',0,1,'2026-05-11 00:30:29'),(27,'Ayçiçekleri',2,2,'Sarının en canlı tonlarıyla umudu ve yaşam enerjisini simgeleyen natürmort.',480000.00,'aycicekleri.jpg',1888,'Yağlıboya','92x73 cm',5,1,'2026-05-11 00:30:29'),(28,'Gece Kafesi',2,2,'Arles şehrindeki bir kafenin sarı sıcak ışığıyla gecenin lacivertinin eşsiz zıtlığı.',520000.00,'gece_kafesi.jpg',1888,'Yağlıboya','81x65 cm',0,1,'2026-05-11 00:30:29'),(29,'İlkbahar (Primavera)',8,1,'Mitolojik figürlerin bir ormanda baharın gelişini kutladığı zarif Rönesans eseri.',600000.00,'primavera.jpg',1482,'Tempera','202x314 cm',0,1,'2026-05-11 00:30:29'),(30,'Vitruvius Adamı',1,1,'İnsan vücudunun altın oranını gösteren, sanat ve bilimin kusursuz birleşimi.',120000.00,'vitruvius.jpg',1490,'Mürekkep','34x24 cm',15,1,'2026-05-11 00:30:29'),(31,'Hayatın Dansı',3,3,'Aşk, gençlik ve ölüm döngüsünün dışavurumcu bir yaklaşımla işlendiği kompozisyon.',250000.00,'hayatin_dansi.jpg',1899,'Yağlıboya','125x191 cm',0,1,'2026-05-11 00:30:29'),(32,'Adele Bloch-Bauer I',7,5,'Altın yaprakların yoğun olarak kullanıldığı, Viyana Sezesyonunun parlayan yıldızı.',750000.00,'adele.jpg',1907,'Yağlıboya ve Altın','138x138 cm',0,1,'2026-05-11 00:30:29');
/*!40000 ALTER TABLE `artworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Rönesans'),(2,'Post-Empresyonizm'),(3,'Ekspresyonizm'),(4,'Sürrealizm'),(5,'Sembolizm'),(6,'Türk Resim Sanatı'),(7,'Modern Sanat'),(8,'Pixelart'),(9,'Empresyonizm'),(10,'Kübizm'),(11,'Barok');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comparison_history`
--

DROP TABLE IF EXISTS `comparison_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comparison_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `comparison_type` enum('artworks','events') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `item_ids` json NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comparison_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comparison_history`
--

LOCK TABLES `comparison_history` WRITE;
/*!40000 ALTER TABLE `comparison_history` DISABLE KEYS */;
INSERT INTO `comparison_history` VALUES (1,5,'artworks','[3, 1]','2026-05-10 17:55:51'),(3,7,'events','[7, 11]','2026-05-10 18:19:50'),(4,7,'artworks','[7, 4]','2026-05-10 18:20:35'),(5,7,'events','[8, 5]','2026-05-10 18:20:39');
/*!40000 ALTER TABLE `comparison_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `discount_percent` int NOT NULL,
  `is_active` tinyint DEFAULT '1',
  `is_public` tinyint DEFAULT '1',
  `expires_at` date DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'SANAT10',10,1,1,'2020-01-01','Tüm eserlerde %10 indirim'),(2,'KTU2025',20,1,1,'2025-09-30','KTÜ öğrencilerine özel %20 indirim'),(3,'YENI15',15,1,1,'2025-06-30','Yeni üyelere özel %15 indirim');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci,
  `event_type` enum('atolye','sergi','konferans','tur') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT 'atolye',
  `event_date` datetime NOT NULL,
  `duration_minutes` int DEFAULT '120',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `capacity` int NOT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `image_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `discount_percent` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Yağlıboya Başlangıç Atölyesi','Sıfırdan yağlıboya öğrenmek isteyenler için 3 saatlik yoğun atölye. Tüm malzemeler dahildir.','atolye','2025-06-15 10:00:00',180,'KTÜ Sanat Merkezi - Salon A',20,450.00,'Yildizli_Gece.jpg',0,'2026-05-09 19:27:38'),(2,'Portre Çizimi Atölyesi','Karakalem ve kömür tekniğiyle profesyonel portre çizimi. Orta seviye için uygundur.','atolye','2025-06-22 14:00:00',150,'KTÜ Sanat Merkezi - Salon B',15,350.00,'Mona_Lisa.jpg',10,'2026-05-09 19:27:38'),(3,'Suluboya ile Manzara','Doğadan ilham alarak suluboya tekniğini öğrenin. Beginner ve orta seviye için.','atolye','2025-07-10 10:00:00',180,'KTÜ Sanat Merkezi - Salon A',18,400.00,'venusun_dogusu.jpg',0,'2026-05-09 19:27:38'),(4,'Heykel ve Seramik Atölyesi','Kil ile şekillendirme, form ve doku çalışmaları. Tüm seviyeler için uygundur.','atolye','2025-07-20 13:00:00',240,'KTÜ Seramik Atölyesi',12,500.00,'galeri_13.jpg',15,'2026-05-09 19:27:38'),(5,'Dijital İllüstrasyon Atölyesi','Tablet ve Procreate ile dijital sanat. Grafik tablet ile profesyonel illüstrasyon teknikleri.','atolye','2025-08-05 10:00:00',180,'KTÜ Bilgisayar Lab - 204',25,600.00,'bellegin_azmi.jpg',0,'2026-05-09 19:27:38'),(6,'Türk Resim Sanatı Sergisi','Osmanlidan Cumhuriyete Türk resim sanatının yolculuğu. 50 özgün eser sergilenmektedir.','sergi','2025-06-20 09:00:00',480,'KTÜ Ana Sergi Salonu',200,0.00,'Kaplumbaga_terbiyecisi.jpg',0,'2026-05-09 19:27:38'),(7,'Rönesans Ustaları Sergisi','Avrupa Rönesans sanatından reprodüksiyonlar ve dijital baskılar. Sanat tarihi seminerleri eşliğinde.','sergi','2025-07-01 09:00:00',480,'KTÜ Kültür Merkezi Galerisi',150,50.00,'atina_okulu.jpg',0,'2026-05-09 19:27:38'),(8,'Çağdaş Türk Sanatçılar','Genç ve yerleşik Türk sanatçıların güncel çalışmalarını buluşturan karma sergi.','sergi','2025-07-15 10:00:00',480,'KTÜ Sanat Galerisi',100,0.00,'galeri_13.jpg',0,'2026-05-09 19:27:38'),(9,'Ekspresyonizm: Duygunun Dili','Van Gogh, Munch ve cagdaslarinin ekspresyonist eserleri üzerine kurulu tematik sergi.','sergi','2025-08-01 09:00:00',480,'KTÜ Ana Sergi Salonu',180,75.00,'ciglik.jpg',20,'2026-05-09 19:27:38'),(10,'Dijital Sanat ve NFT Konferansı','NFT ve dijital sanatın geleceği üzerine uzman paneli. Blockchain sanat piyasaları tartışılacak.','konferans','2025-07-05 14:00:00',240,'KTÜ Konferans Salonu',150,200.00,'bellegin_azmi.jpg',0,'2026-05-09 19:27:38'),(11,'Sanat Tarihi Semineri: Rönesans','Dr. Ahmet Yıldız ile Rönesans dönemi sanatı, ikonografisi ve toplumsal bağlamı üzerine seminer.','konferans','2025-06-28 15:00:00',180,'KTÜ Amfitiyatro - 101',120,100.00,'adem_yaratilis.jpg',0,'2026-05-09 19:27:38'),(12,'Müze Yönetimi ve Küratörlük','Cagdas müze yönetimi, koleksiyon geliştirme ve sergi tasarımı üzerine profesyonel panel.','konferans','2025-07-18 10:00:00',300,'KTÜ Rektörlük Toplantı Salonu',80,150.00,'son_aksam_yemegi.jpg',10,'2026-05-09 19:27:38'),(13,'Trabzon Müzesi Sanat Turu','Trabzon müzelerinde rehberli sanat turu. Tarihi eserler ve yerel sanat geleneği keşfedilecek.','tur','2025-07-12 09:00:00',360,'Trabzon Müzesi',30,350.00,'opucuk.jpg',0,'2026-05-09 19:27:38'),(14,'İstanbul Modern Müze Gezisi','Istanbul Modern Sanat Müzesi ve Pera Müzesi gezisi. Ulasim ve rehberlik dahildir.','tur','2025-07-26 07:00:00',600,'İstanbul - Karaköy',25,750.00,'venusun_dogusu.jpg',0,'2026-05-09 19:27:38'),(15,'Ankara Devlet Resim Heykel Müzesi','Türkiyenin ilk devlet müzesinde kapsamlı bir kültür turu. Öğle yemeği dahildir.','tur','2025-08-10 07:30:00',720,'Ankara - Ulus',20,850.00,'atina_okulu.jpg',15,'2026-05-09 19:27:38');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `artwork_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`artwork_id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `artwork_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` enum('kredi_karti','banka_havalesi','kapida_odeme') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT 'kredi_karti',
  `status` enum('beklemede','onaylandı','kargoda','teslim_edildi','iptal') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT 'beklemede',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `artwork_id` (`artwork_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,1,NULL,150000.00,'kredi_karti','onaylandı','2026-05-09 19:27:38'),(2,2,NULL,1,450.00,'kredi_karti','onaylandı','2026-05-09 19:27:38'),(3,3,2,NULL,108000.00,'banka_havalesi','kargoda','2026-05-09 19:27:38'),(4,3,NULL,6,0.00,'kredi_karti','onaylandı','2026-05-09 19:27:38'),(5,1,1,NULL,150000.00,'kredi_karti','onaylandı','2026-05-10 21:40:50'),(6,1,2,NULL,120000.00,'kredi_karti','onaylandı','2026-05-10 21:40:50'),(7,1,3,NULL,180000.00,'kredi_karti','onaylandı','2026-05-10 21:40:50'),(8,1,1,NULL,150000.00,'kredi_karti','onaylandı','2026-05-11 11:43:57'),(9,8,1,NULL,150000.00,'kredi_karti','onaylandı','2026-05-11 12:02:13');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `participant_count` int DEFAULT '1',
  `reservation_date` date NOT NULL,
  `status` enum('beklemede','onaylandı','iptal') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT 'beklemede',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,2,1,2,'2025-06-15','onaylandı','2026-05-09 19:27:38'),(2,3,1,1,'2025-06-15','onaylandı','2026-05-09 19:27:38'),(3,2,6,3,'2025-06-20','beklemede','2026-05-09 19:27:38'),(4,3,10,1,'2025-07-05','onaylandı','2026-05-09 19:27:38');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_replies`
--

DROP TABLE IF EXISTS `review_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_replies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `review_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_id` (`review_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `review_replies_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`),
  CONSTRAINT `review_replies_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_replies`
--

LOCK TABLES `review_replies` WRITE;
/*!40000 ALTER TABLE `review_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_votes`
--

DROP TABLE IF EXISTS `review_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_votes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `review_id` int NOT NULL,
  `user_id` int NOT NULL,
  `is_helpful` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_id` (`review_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_votes_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`),
  CONSTRAINT `review_votes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_votes`
--

LOCK TABLES `review_votes` WRITE;
/*!40000 ALTER TABLE `review_votes` DISABLE KEYS */;
INSERT INTO `review_votes` VALUES (1,1,3,1),(2,2,2,1),(3,3,3,1),(4,5,3,1);
/*!40000 ALTER TABLE `review_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `artwork_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `rating` tinyint NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `is_verified` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `artwork_id` (`artwork_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`),
  CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,2,1,NULL,5,'Mona Lisa reprodüksiyonu mükemmeldi, firca darbeleri inanilmaz detaylı.',1,'2026-05-09 19:27:38'),(2,3,1,NULL,4,'Cok etkileyici bir eser. Kargo biraz geç geldi ama kalite harika.',1,'2026-05-09 19:27:38'),(3,2,2,NULL,5,'Yıldızlı Gece her zaman favorim. Baskı kalitesi cok yüksek.',1,'2026-05-09 19:27:38'),(4,3,4,NULL,5,'Kaplumbaga Terbiyecisi gercekten esşiz. Osmanli sanatının zirvesi.',1,'2026-05-09 19:27:38'),(5,2,NULL,1,4,'Atolye cok verimli getti. Egitmen cok yetkiliydi.',1,'2026-05-09 19:27:38'),(6,3,NULL,6,5,'Türk Resim Sanatı Sergisi harikaydı. Kesinlikle tavsiye ederim.',1,'2026-05-09 19:27:38'),(7,7,3,NULL,5,'Çığlık atıyor, çok iyi.',0,'2026-05-10 18:45:59'),(8,7,1,NULL,4,'Garip bir kadın',0,'2026-05-10 18:46:19'),(9,7,9,NULL,5,'YERLİ VE MİLLİ',0,'2026-05-10 18:50:11'),(10,7,NULL,1,5,'Buna kesin gideceğim.',0,'2026-05-10 18:55:43'),(11,1,2,NULL,4,'çok güzel',1,'2026-05-11 11:50:14'),(12,8,2,NULL,3,'erer',0,'2026-05-11 12:02:28');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_tickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `status` enum('açık','işlemde','kapatıldı') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT 'açık',
  `admin_reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci,
  `replied_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `support_tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets`
--

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;
INSERT INTO `support_tickets` VALUES (1,2,'Ali Yılmaz','ali@mail.com','Siparisim 3 gündür kargoda görünüyor, ne zaman gelir?','işlemde',NULL,NULL,'2026-05-09 19:27:38'),(2,3,'Ayşe Kara','ayse@mail.com','Atolye rezervasyonumu iptal etmek istiyorum, ücret iadesi nasil yapılır?','açık',NULL,NULL,'2026-05-09 19:27:38'),(3,8,'eren kuşdil','kusdileren@gmail.com','bilgi alabilir miyim','kapatıldı','tabiiki','2026-05-10 21:50:37','2026-05-10 21:49:25');
/*!40000 ALTER TABLE `support_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `role` enum('kullanici','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci DEFAULT 'kullanici',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin@ktu.edu.tr','$2b$12$UpOhmOnrbWInDGbw6yjs.uLHDIF/HhDyr/mkPDpLdfM2QQXKorluy','admin','2026-05-09 19:27:38'),(2,'Ali Yılmaz','ali@mail.com','$2b$12$k4RUUNn6sB82PtzXafNUvuN.iRop2ssNfbfewprhJpsWpM5DLrZnu','kullanici','2026-05-09 19:27:38'),(3,'Ayşe Kara','ayse@mail.com','$2b$12$R/OnVkl6vaA6VeYXI.u/n.LyFliRI3pJWt1DNKK4ylxCQlcTYUm.W','kullanici','2026-05-09 19:27:38'),(4,'Berat Kaymaz','berat@ktu.edu.tr','$2b$12$pcYiEcOnTh5N411D4UKH9.EZMVTZqbMUdriu/3FEAYFZur5vieoKa','kullanici','2026-05-09 19:41:56'),(5,'Berat Kayar','kayar@ktu.edu.tr','$2b$12$jOM6Iy/wFzay1vLmRWCz5uwoFMmziHC24oR2Sqp8cgA/TAzah8Ky6','admin','2026-05-09 19:50:35'),(7,'Arda Gülmez','arda@mail.com','$2b$12$KmXRHXJHiE0RSS8zw79zueartYoztEr1pGtvRvx8YPWD4hJjjwuRe','kullanici','2026-05-10 18:07:25'),(8,'eren kuşdil','kusdileren@gmail.com','$2b$12$9paarJEZ2Vb1K6Drg3A1LuN1Yy4HahmOf4D8z7T94gUEsnPotk/q6','kullanici','2026-05-10 21:49:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-11 12:58:46
