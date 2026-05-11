-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: sanat_galerisi
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
INSERT INTO `artworks` VALUES (1,'Mona Lisa',1,1,'Dünyanın en tanınan tablosu. Gizemli gülüşüyle yüzyıllardır büyülüyor.',150000.00,'Mona_Lisa.jpg',1503,'Yağlıboya','77x53 cm',0,4,'2026-05-09 19:27:38'),(2,'Yıldızlı Gece',2,2,'Sarmal bulutlar ve parlak yıldızlarla dolu mistik bir gece manzarası.',120000.00,'Yildizli_Gece.jpg',1889,'Yağlıboya','73x92 cm',10,5,'2026-05-09 19:27:38'),(3,'Çığlık',3,3,'Modern insanın varoluşsal kaygısını simgeleyen ikonik ekspresyonist şaheser.',180000.00,'ciglik.jpg',1893,'Yağlıboya ve pastel','91x73 cm',0,1,'2026-05-09 19:27:38'),(4,'Atina Okulu',4,1,'Antik Yunan filozoflarini bir arada gösteren Ronesansin en büyük fresklerinden biri.',250000.00,'atina_okulu.jpg',1511,'Fresk','500x770 cm',5,1,'2026-05-09 19:27:38'),(5,'Ademin Yaratilisi',5,1,'Sistine Sapeli tavanindaki ikonik sahne; Tanri ile Ademin parmak uclarinin bulusmasi.',300000.00,'adem_yaratilis.jpg',1512,'Fresk','280x570 cm',0,1,'2026-05-09 19:27:38'),(6,'Bellegin Azmi',6,4,'Eriyen saatlerle zamanın göreceliğini sorgulayan sürrealizmin simge tablosu.',220000.00,'bellegin_azmi.jpg',1931,'Yağlıboya','24x33 cm',15,1,'2026-05-09 19:27:38'),(7,'Öpücük',7,5,'Altin yapraklara sarılmış, birbirine kavuşmuş iki figürü yansıtan romantik şaheser.',195000.00,'opucuk.jpg',1908,'Yağlıboya ve altin yaprak','180x180 cm',0,0,'2026-05-09 19:27:38'),(8,'Venüsün Dogusu',8,1,'Denizden cikan güzellik tanrıçasını betimleyen Botticellinin basyapiti.',175000.00,'venusun_dogusu.jpg',1485,'Tempera','172x278 cm',10,1,'2026-05-09 19:27:38'),(9,'Kaplumbağa Terbiyecisi',9,6,'Osmanlı kültüründen bir sahne. Milli Saraylar koleksiyonunun gözbebeği.',95000.00,'Kaplumbaga_terbiyecisi.jpg',1906,'Yağlıboya','221x320 cm',15,1,'2026-05-09 19:27:38'),(10,'Son Aksam Yemegi',1,1,'Isa ve havarileri son yemekte gösteren anitsal Ronesans eseri.',280000.00,'son_aksam_yemegi.jpg',1498,'Tempera ve yağlıboya','460x880 cm',0,1,'2026-05-09 19:27:38'),(11,'Galeri No. 13',NULL,7,'Cagdas Türk sanatından soyut bir kompozisyon; renk ve form dengesiyle dikkat cekiyor.',45000.00,'galeri_13.jpg',2020,'Akrilik','100x100 cm',20,3,'2026-05-09 19:27:38'),(12,'Karanlığın Çağrısı',10,8,'Sanatçının acemilik dönemi eseri',100.00,'karanlıgın_cagrisi.png',2020,'Pixel','100x100',0,999,'2026-05-09 19:46:08'),(13,'Mustafa Kemal Atatürk Portresi',11,6,'Cumhuriyet tarihinin en önemli siyasi ve askeri lideri olan Gazi Mustafa Kemal Atatürk\'ün bu eşsiz portresi, dönemin vizyonunu ve kararlılığını tuvale yansıtıyor.',150000.00,'ataturk_portre.jpg',1930,'Yağlıboya','100x80 cm',0,888,'2026-05-11 00:30:29'),(14,'Zeybekler Kurtuluş Savaşı\'nda',11,6,'Milli Mücadele yıllarının fedakarlıklarını ve Anadolu insanının direnişini resmeden destansı bir çalışma.',180000.00,'zeybekler.jpg',1923,'Yağlıboya','150x200 cm',5,1,'2026-05-11 00:30:29'),(15,'Celile Hanım Portresi',9,6,'Osman Hamdi Bey\'in fırçasından, dönemin zarafetini yansıtan çok özel bir portre çalışması.',85000.00,'celile_hanim.jpg',1885,'Yağlıboya','60x45 cm',0,0,'2026-05-11 00:30:29'),(16,'İnci Küpeli Kız',14,11,'Kuzeyin Mona Lisası olarak bilinen, ışığın ve masumiyetin muazzam bir tasviri.',450000.00,'inci_kupeli.jpg',1665,'Yağlıboya','44x39 cm',0,1,'2026-05-11 00:30:29'),(17,'Süt Döken Kadın',14,11,'Gündelik bir anın Barok ışığı altında nasıl şahesere dönüştüğünün kanıtı.',320000.00,'sut_doken.jpg',1658,'Yağlıboya','45x41 cm',10,1,'2026-05-11 00:30:29'),(18,'Gece Devriyesi',16,11,'Hareket ve ışık kullanımında çığır açan devasa boyutlu bir askeri birlik tablosu.',850000.00,'gece_devriyesi.jpg',1642,'Yağlıboya','363x437 cm',0,1,'2026-05-11 00:30:29'),(19,'İzlenim: Gün Doğumu',12,9,'Tüm bir sanat akımına adını veren, sise gömülmüş bir liman manzarası.',280000.00,'gun_dogumu.jpg',1872,'Yağlıboya','48x63 cm',15,1,'2026-05-11 00:30:29'),(20,'Nilüferler',12,9,'Monet\'nin kendi bahçesindeki su zambaklarını resmettiği huzur dolu kompozisyon.',350000.00,'niluferler.jpg',1919,'Yağlıboya','100x200 cm',0,1,'2026-05-11 00:30:29'),(21,'Guernica',13,10,'Savaşın yıkıcılığını ve hüznünü geometrik formlarla anlatan anıtsal bir çığlık.',950000.00,'guernica.jpg',1937,'Yağlıboya','349x776 cm',0,0,'2026-05-11 00:30:29'),(22,'Avignonlu Kızlar',13,10,'Modern sanatın doğuşunu müjdeleyen, perspektifin parçalandığı devrim niteliğinde bir eser.',650000.00,'avignon.jpg',1907,'Yağlıboya','243x233 cm',10,1,'2026-05-11 00:30:29'),(23,'Ağlayan Kadın',13,10,'Dora Maar\'ın yüzündeki hüznün kübist bir parçalanmayla tuvale aktarımı.',420000.00,'aglayan_kadin.jpg',1937,'Yağlıboya','60x49 cm',0,1,'2026-05-11 00:30:29'),(24,'İki Frida',15,4,'Sanatçının içsel bölünmüşlüğünü ve kimlik çatışmasını anlatan çifte otoportre.',380000.00,'iki_frida.jpg',1939,'Yağlıboya','173x173 cm',0,1,'2026-05-11 00:30:29'),(25,'Dikenli Kolye ile Otoportre',15,4,'Meksika ormanının gizemini ve sanatçının fiziksel acılarını simgeleyen ikonik eser.',290000.00,'frida_dikenli.jpg',1940,'Yağlıboya','61x47 cm',20,1,'2026-05-11 00:30:29'),(26,'Uyku',6,4,'Bilinçaltının derinliklerindeki rüyaların gerçeküstü bir dille yorumlanması.',310000.00,'uyku_dali.jpg',1937,'Yağlıboya','51x78 cm',0,1,'2026-05-11 00:30:29'),(27,'Ayçiçekleri',2,2,'Sarının en canlı tonlarıyla umudu ve yaşam enerjisini simgeleyen natürmort.',480000.00,'aycicekleri.jpg',1888,'Yağlıboya','92x73 cm',5,1,'2026-05-11 00:30:29'),(28,'Gece Kafesi',2,2,'Arles şehrindeki bir kafenin sarı sıcak ışığıyla gecenin lacivertinin eşsiz zıtlığı.',520000.00,'gece_kafesi.jpg',1888,'Yağlıboya','81x65 cm',0,1,'2026-05-11 00:30:29'),(29,'İlkbahar (Primavera)',8,1,'Mitolojik figürlerin bir ormanda baharın gelişini kutladığı zarif Rönesans eseri.',600000.00,'primavera.jpg',1482,'Tempera','202x314 cm',0,1,'2026-05-11 00:30:29'),(30,'Vitruvius Adamı',1,1,'İnsan vücudunun altın oranını gösteren, sanat ve bilimin kusursuz birleşimi.',120000.00,'vitruvius.jpg',1490,'Mürekkep','34x24 cm',15,1,'2026-05-11 00:30:29'),(31,'Hayatın Dansı',3,3,'Aşk, gençlik ve ölüm döngüsünün dışavurumcu bir yaklaşımla işlendiği kompozisyon.',250000.00,'hayatin_dansi.jpg',1899,'Yağlıboya','125x191 cm',0,1,'2026-05-11 00:30:29'),(32,'Adele Bloch-Bauer I',7,5,'Altın yaprakların yoğun olarak kullanıldığı, Viyana Sezesyonunun parlayan yıldızı.',750000.00,'adele.jpg',1907,'Yağlıboya ve Altın','138x138 cm',0,1,'2026-05-11 00:30:29');
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
INSERT INTO `coupons` VALUES (1,'SANAT10',10,1,1,'2020-01-01','Tüm eserlerde %10 indirim'),(2,'KTU2025',20,1,1,'2026-09-30','KTÜ öğrencilerine özel %20 indirim'),(3,'YENI15',15,1,1,'2026-06-30','Yeni üyelere özel %15 indirim');
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
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,5,7,'2026-05-11 16:37:03'),(2,5,2,'2026-05-11 16:37:06'),(3,5,12,'2026-05-11 16:37:09'),(4,2,8,'2026-05-11 16:46:57'),(5,2,10,'2026-05-11 16:46:59'),(6,2,13,'2026-05-11 16:47:00'),(7,9,8,'2026-05-11 10:00:00'),(8,9,1,'2026-05-11 10:00:00'),(9,9,24,'2026-05-11 10:00:00'),(10,9,9,'2026-05-11 10:00:00'),(11,9,32,'2026-05-11 10:00:00'),(12,9,28,'2026-05-11 10:00:00'),(13,9,5,'2026-05-11 10:00:00'),(14,9,30,'2026-05-11 10:00:00'),(15,9,4,'2026-05-11 10:00:00'),(16,9,22,'2026-05-11 10:00:00'),(17,10,6,'2026-05-11 10:00:00'),(18,10,19,'2026-05-11 10:00:00'),(19,10,14,'2026-05-11 10:00:00'),(20,10,2,'2026-05-11 10:00:00'),(21,10,1,'2026-05-11 10:00:00'),(22,10,3,'2026-05-11 10:00:00'),(23,10,7,'2026-05-11 10:00:00'),(24,10,8,'2026-05-11 10:00:00'),(25,10,17,'2026-05-11 10:00:00'),(26,10,20,'2026-05-11 10:00:00'),(27,11,13,'2026-05-11 10:00:00'),(28,11,27,'2026-05-11 10:00:00'),(29,11,15,'2026-05-11 10:00:00'),(30,11,29,'2026-05-11 10:00:00'),(31,11,18,'2026-05-11 10:00:00'),(32,12,11,'2026-05-11 10:00:00'),(33,12,28,'2026-05-11 10:00:00'),(34,12,22,'2026-05-11 10:00:00'),(35,12,18,'2026-05-11 10:00:00'),(36,12,10,'2026-05-11 10:00:00'),(37,13,22,'2026-05-11 10:00:00'),(38,13,4,'2026-05-11 10:00:00'),(39,13,3,'2026-05-11 10:00:00'),(40,13,13,'2026-05-11 10:00:00'),(41,13,31,'2026-05-11 10:00:00'),(42,13,12,'2026-05-11 10:00:00'),(43,14,17,'2026-05-11 10:00:00'),(44,14,26,'2026-05-11 10:00:00'),(45,14,2,'2026-05-11 10:00:00'),(46,14,24,'2026-05-11 10:00:00'),(47,14,15,'2026-05-11 10:00:00'),(48,14,18,'2026-05-11 10:00:00'),(49,14,4,'2026-05-11 10:00:00'),(50,15,6,'2026-05-11 10:00:00'),(51,15,18,'2026-05-11 10:00:00'),(52,15,10,'2026-05-11 10:00:00'),(53,15,27,'2026-05-11 10:00:00'),(54,15,21,'2026-05-11 10:00:00'),(55,15,20,'2026-05-11 10:00:00'),(56,15,12,'2026-05-11 10:00:00'),(57,15,19,'2026-05-11 10:00:00'),(58,16,5,'2026-05-11 10:00:00'),(59,16,2,'2026-05-11 10:00:00'),(60,16,22,'2026-05-11 10:00:00'),(61,16,8,'2026-05-11 10:00:00'),(62,16,25,'2026-05-11 10:00:00'),(63,16,10,'2026-05-11 10:00:00'),(64,17,15,'2026-05-11 10:00:00'),(65,17,7,'2026-05-11 10:00:00'),(66,17,25,'2026-05-11 10:00:00'),(67,17,18,'2026-05-11 10:00:00'),(68,17,30,'2026-05-11 10:00:00'),(69,18,24,'2026-05-11 10:00:00'),(70,18,6,'2026-05-11 10:00:00'),(71,18,12,'2026-05-11 10:00:00'),(72,18,30,'2026-05-11 10:00:00'),(73,18,7,'2026-05-11 10:00:00'),(74,18,22,'2026-05-11 10:00:00'),(75,18,9,'2026-05-11 10:00:00'),(76,18,23,'2026-05-11 10:00:00'),(77,18,27,'2026-05-11 10:00:00'),(78,18,21,'2026-05-11 10:00:00'),(79,19,11,'2026-05-11 10:00:00'),(80,19,16,'2026-05-11 10:00:00'),(81,19,30,'2026-05-11 10:00:00'),(82,19,25,'2026-05-11 10:00:00'),(83,19,18,'2026-05-11 10:00:00'),(84,20,15,'2026-05-11 10:00:00'),(85,20,22,'2026-05-11 10:00:00'),(86,20,11,'2026-05-11 10:00:00'),(87,20,27,'2026-05-11 10:00:00'),(88,20,25,'2026-05-11 10:00:00'),(89,20,28,'2026-05-11 10:00:00'),(90,20,2,'2026-05-11 10:00:00'),(91,20,8,'2026-05-11 10:00:00'),(92,20,26,'2026-05-11 10:00:00'),(93,20,30,'2026-05-11 10:00:00'),(94,21,18,'2026-05-11 10:00:00'),(95,21,3,'2026-05-11 10:00:00'),(96,21,7,'2026-05-11 10:00:00'),(97,21,19,'2026-05-11 10:00:00'),(98,21,23,'2026-05-11 10:00:00'),(99,21,11,'2026-05-11 10:00:00'),(100,21,30,'2026-05-11 10:00:00'),(101,21,21,'2026-05-11 10:00:00'),(102,22,26,'2026-05-11 10:00:00'),(103,22,29,'2026-05-11 10:00:00'),(104,22,30,'2026-05-11 10:00:00'),(105,22,21,'2026-05-11 10:00:00'),(106,22,15,'2026-05-11 10:00:00'),(107,22,5,'2026-05-11 10:00:00'),(108,22,9,'2026-05-11 10:00:00'),(109,22,27,'2026-05-11 10:00:00'),(110,23,17,'2026-05-11 10:00:00'),(111,23,24,'2026-05-11 10:00:00'),(112,23,19,'2026-05-11 10:00:00'),(113,23,14,'2026-05-11 10:00:00'),(114,23,30,'2026-05-11 10:00:00'),(115,23,13,'2026-05-11 10:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,1,NULL,150000.00,'kredi_karti','onaylandı','2026-05-09 19:27:38'),(2,2,NULL,1,450.00,'kredi_karti','onaylandı','2026-05-09 19:27:38'),(3,3,2,NULL,108000.00,'banka_havalesi','kargoda','2026-05-09 19:27:38'),(4,3,NULL,6,0.00,'kredi_karti','onaylandı','2026-05-09 19:27:38'),(5,1,1,NULL,150000.00,'kredi_karti','onaylandı','2026-05-10 21:40:50'),(6,1,2,NULL,120000.00,'kredi_karti','onaylandı','2026-05-10 21:40:50'),(7,1,3,NULL,180000.00,'kredi_karti','onaylandı','2026-05-10 21:40:50'),(8,5,12,NULL,85.00,'kapida_odeme','onaylandı','2026-05-11 16:28:03'),(9,5,15,NULL,68000.00,'banka_havalesi','onaylandı','2026-05-11 16:29:31'),(10,5,21,NULL,950000.00,'banka_havalesi','onaylandı','2026-05-11 16:31:42'),(11,5,7,NULL,195000.00,'banka_havalesi','onaylandı','2026-05-11 16:31:42'),(12,5,13,NULL,150000.00,'banka_havalesi','onaylandı','2026-05-11 16:32:21'),(13,9,27,NULL,456000.00,'kredi_karti','teslim_edildi','2026-05-11 10:05:00'),(14,10,30,NULL,102000.00,'banka_havalesi','teslim_edildi','2026-05-11 10:06:00'),(15,11,19,NULL,238000.00,'kredi_karti','teslim_edildi','2026-05-11 10:07:00'),(16,12,31,NULL,250000.00,'banka_havalesi','onaylandı','2026-05-11 10:08:00'),(17,13,20,NULL,350000.00,'banka_havalesi','teslim_edildi','2026-05-11 10:09:00'),(18,14,32,NULL,750000.00,'banka_havalesi','teslim_edildi','2026-05-11 10:10:00'),(19,15,16,NULL,450000.00,'kredi_karti','teslim_edildi','2026-05-11 10:11:00'),(20,16,26,NULL,310000.00,'banka_havalesi','onaylandı','2026-05-11 10:12:00'),(21,17,8,NULL,157500.00,'kredi_karti','teslim_edildi','2026-05-11 10:13:00'),(22,18,6,NULL,187000.00,'kredi_karti','teslim_edildi','2026-05-11 10:14:00'),(23,19,4,NULL,237500.00,'banka_havalesi','teslim_edildi','2026-05-11 10:15:00'),(24,20,5,NULL,300000.00,'banka_havalesi','teslim_edildi','2026-05-11 10:16:00'),(25,21,10,NULL,280000.00,'banka_havalesi','teslim_edildi','2026-05-11 10:17:00'),(26,22,2,NULL,108000.00,'kredi_karti','teslim_edildi','2026-05-11 10:18:00'),(27,23,9,NULL,80750.00,'kredi_karti','teslim_edildi','2026-05-11 10:19:00'),(28,9,11,NULL,36000.00,'banka_havalesi','kargoda','2026-05-11 10:20:00'),(29,10,25,NULL,232000.00,'kredi_karti','kargoda','2026-05-11 10:21:00'),(30,11,22,NULL,585000.00,'banka_havalesi','kargoda','2026-05-11 10:22:00'),(31,12,24,NULL,380000.00,'kredi_karti','beklemede','2026-05-11 10:23:00'),(32,13,29,NULL,600000.00,'banka_havalesi','kargoda','2026-05-11 10:24:00'),(33,14,17,NULL,288000.00,'kredi_karti','kargoda','2026-05-11 10:25:00'),(34,15,28,NULL,520000.00,'banka_havalesi','kargoda','2026-05-11 10:26:00'),(35,16,18,NULL,850000.00,'banka_havalesi','iptal','2026-05-11 10:27:00'),(36,17,14,NULL,171000.00,'banka_havalesi','kargoda','2026-05-11 10:28:00'),(37,18,15,NULL,85000.00,'banka_havalesi','onaylandı','2026-05-11 10:29:00'),(38,19,12,NULL,100.00,'kapida_odeme','kargoda','2026-05-11 10:30:00'),(39,20,27,NULL,456000.00,'banka_havalesi','onaylandı','2026-05-11 10:31:00'),(40,21,13,NULL,150000.00,'banka_havalesi','kargoda','2026-05-11 10:32:00'),(41,22,23,NULL,420000.00,'kredi_karti','iptal','2026-05-11 10:33:00'),(42,23,30,NULL,102000.00,'banka_havalesi','kargoda','2026-05-11 10:34:00'),(43,9,3,NULL,180000.00,'kredi_karti','beklemede','2026-05-11 10:35:00'),(44,9,NULL,1,450.00,'kredi_karti','teslim_edildi','2026-05-11 10:36:00'),(45,10,NULL,1,450.00,'kredi_karti','teslim_edildi','2026-05-11 10:37:00'),(46,11,NULL,1,450.00,'banka_havalesi','teslim_edildi','2026-05-11 10:38:00'),(47,12,NULL,2,315.00,'kredi_karti','teslim_edildi','2026-05-11 10:39:00'),(48,13,NULL,2,315.00,'kredi_karti','teslim_edildi','2026-05-11 10:40:00'),(49,14,NULL,2,315.00,'banka_havalesi','teslim_edildi','2026-05-11 10:41:00'),(50,15,NULL,3,400.00,'kredi_karti','teslim_edildi','2026-05-11 10:42:00'),(51,16,NULL,3,400.00,'kredi_karti','teslim_edildi','2026-05-11 10:43:00'),(52,17,NULL,3,400.00,'banka_havalesi','teslim_edildi','2026-05-11 10:44:00'),(53,18,NULL,4,425.00,'kapida_odeme','teslim_edildi','2026-05-11 10:45:00'),(54,19,NULL,4,425.00,'kredi_karti','teslim_edildi','2026-05-11 10:46:00'),(55,20,NULL,4,425.00,'banka_havalesi','teslim_edildi','2026-05-11 10:47:00'),(56,21,NULL,5,600.00,'kredi_karti','teslim_edildi','2026-05-11 10:48:00'),(57,22,NULL,5,600.00,'kredi_karti','teslim_edildi','2026-05-11 10:49:00'),(58,23,NULL,5,600.00,'banka_havalesi','teslim_edildi','2026-05-11 10:50:00'),(59,9,NULL,6,0.00,'kredi_karti','teslim_edildi','2026-05-11 10:51:00'),(60,11,NULL,6,0.00,'kredi_karti','teslim_edildi','2026-05-11 10:52:00'),(61,13,NULL,6,0.00,'kredi_karti','teslim_edildi','2026-05-11 10:53:00'),(62,15,NULL,6,0.00,'kredi_karti','teslim_edildi','2026-05-11 10:54:00'),(63,17,NULL,6,0.00,'kredi_karti','teslim_edildi','2026-05-11 10:55:00'),(64,10,NULL,7,50.00,'kredi_karti','teslim_edildi','2026-05-11 10:56:00'),(65,12,NULL,7,50.00,'kredi_karti','teslim_edildi','2026-05-11 10:57:00'),(66,14,NULL,7,50.00,'banka_havalesi','teslim_edildi','2026-05-11 10:58:00'),(67,16,NULL,7,50.00,'kredi_karti','teslim_edildi','2026-05-11 10:59:00'),(68,18,NULL,8,0.00,'kredi_karti','teslim_edildi','2026-05-11 11:00:00'),(69,20,NULL,8,0.00,'kredi_karti','teslim_edildi','2026-05-11 11:01:00'),(70,22,NULL,8,0.00,'kredi_karti','teslim_edildi','2026-05-11 11:02:00'),(71,19,NULL,9,60.00,'kredi_karti','teslim_edildi','2026-05-11 11:03:00'),(72,21,NULL,9,60.00,'kredi_karti','teslim_edildi','2026-05-11 11:04:00'),(73,23,NULL,9,60.00,'banka_havalesi','teslim_edildi','2026-05-11 11:05:00'),(74,9,NULL,10,200.00,'kredi_karti','teslim_edildi','2026-05-11 11:06:00'),(75,12,NULL,10,200.00,'banka_havalesi','teslim_edildi','2026-05-11 11:07:00'),(76,15,NULL,10,200.00,'kredi_karti','teslim_edildi','2026-05-11 11:08:00'),(77,18,NULL,10,200.00,'kredi_karti','teslim_edildi','2026-05-11 11:09:00'),(78,10,NULL,11,100.00,'kredi_karti','teslim_edildi','2026-05-11 11:10:00'),(79,13,NULL,11,100.00,'kredi_karti','teslim_edildi','2026-05-11 11:11:00'),(80,16,NULL,11,100.00,'banka_havalesi','teslim_edildi','2026-05-11 11:12:00'),(81,19,NULL,11,100.00,'kredi_karti','teslim_edildi','2026-05-11 11:13:00'),(82,11,NULL,12,135.00,'kredi_karti','teslim_edildi','2026-05-11 11:14:00'),(83,14,NULL,12,135.00,'banka_havalesi','teslim_edildi','2026-05-11 11:15:00'),(84,17,NULL,12,135.00,'kredi_karti','teslim_edildi','2026-05-11 11:16:00'),(85,20,NULL,12,135.00,'kredi_karti','teslim_edildi','2026-05-11 11:17:00'),(86,21,NULL,13,350.00,'kredi_karti','teslim_edildi','2026-05-11 11:18:00'),(87,22,NULL,13,350.00,'kredi_karti','teslim_edildi','2026-05-11 11:19:00'),(88,23,NULL,13,350.00,'banka_havalesi','teslim_edildi','2026-05-11 11:20:00'),(89,9,NULL,14,750.00,'kredi_karti','teslim_edildi','2026-05-11 11:21:00'),(90,13,NULL,14,750.00,'banka_havalesi','teslim_edildi','2026-05-11 11:22:00'),(91,17,NULL,14,750.00,'kredi_karti','teslim_edildi','2026-05-11 11:23:00'),(92,10,NULL,15,722.50,'banka_havalesi','teslim_edildi','2026-05-11 11:24:00'),(93,14,NULL,15,722.50,'kredi_karti','teslim_edildi','2026-05-11 11:25:00'),(94,18,NULL,15,722.50,'banka_havalesi','teslim_edildi','2026-05-11 11:26:00'),(95,20,NULL,15,722.50,'kredi_karti','teslim_edildi','2026-05-11 11:27:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,2,1,NULL,5,'Mona Lisa reprodüksiyonu mükemmeldi, firca darbeleri inanilmaz detaylı.',1,'2026-05-09 19:27:38'),(2,3,1,NULL,4,'Cok etkileyici bir eser. Kargo biraz geç geldi ama kalite harika.',1,'2026-05-09 19:27:38'),(3,2,2,NULL,5,'Yıldızlı Gece her zaman favorim. Baskı kalitesi cok yüksek.',1,'2026-05-09 19:27:38'),(4,3,4,NULL,5,'Kaplumbaga Terbiyecisi gercekten esşiz. Osmanli sanatının zirvesi.',1,'2026-05-09 19:27:38'),(5,2,NULL,1,4,'Atolye cok verimli getti. Egitmen cok yetkiliydi.',1,'2026-05-09 19:27:38'),(6,3,NULL,6,5,'Türk Resim Sanatı Sergisi harikaydı. Kesinlikle tavsiye ederim.',1,'2026-05-09 19:27:38'),(7,7,3,NULL,5,'Çığlık atıyor, çok iyi.',0,'2026-05-10 18:45:59'),(8,7,1,NULL,4,'Garip bir kadın',0,'2026-05-10 18:46:19'),(9,7,9,NULL,5,'YERLİ VE MİLLİ',0,'2026-05-10 18:50:11'),(10,7,NULL,1,5,'Buna kesin gideceğim.',0,'2026-05-10 18:55:43'),(11,9,1,NULL,4,'Reprodüksiyon kalitesi beklentimin üzerindeydi, çok memnun kaldım.',0,'2026-05-11 12:00:00'),(12,10,1,NULL,5,'Duvar boyutu için mükemmel seçim, oturma odama çok yakıştı.',0,'2026-05-11 12:05:00'),(13,11,1,NULL,3,'Fotoğrafta daha canlı görünüyordu ama yine de güzel.',0,'2026-05-11 12:10:00'),(14,12,1,NULL,4,'Kargolama hızlıydı, eser hasarsız geldi.',0,'2026-05-11 12:15:00'),(15,22,2,NULL,5,'Favori tablom, baskı detayları gerçekten etkileyici.',1,'2026-05-11 12:20:00'),(16,13,2,NULL,5,'Çok uzun süre inceledim, her bakışta yeni bir şey keşfediyorum.',0,'2026-05-11 12:25:00'),(17,14,2,NULL,4,'Renkleri biraz soluk geldi, hayal kırıklığı yaşadım.',0,'2026-05-11 12:30:00'),(18,15,2,NULL,4,'Güzel ama çerçeve kalitesi biraz daha iyi olabilirdi.',0,'2026-05-11 12:35:00'),(19,16,3,NULL,5,'Ekspresyonizmi bu kadar güzel yansıtan başka eser yok.',0,'2026-05-11 12:40:00'),(20,17,3,NULL,4,'Gerçek eserle neredeyse aynı kalitede, çok beğendim.',0,'2026-05-11 12:45:00'),(21,18,3,NULL,3,'Beklentimi tam karşılamadı ama fiyat/kalite dengesi iyi.',0,'2026-05-11 12:50:00'),(22,19,4,NULL,5,'Rönesans\'ın entelektüel ruhunu mükemmel yansıtıyor.',1,'2026-05-11 12:55:00'),(23,20,4,NULL,4,'Detay işçiliği inanılmaz, yakından bakınca daha da güzel.',0,'2026-05-11 13:00:00'),(24,21,4,NULL,5,'Çalışma odama astım, ilham kaynağım oldu.',0,'2026-05-11 13:05:00'),(25,20,5,NULL,5,'İnsanlık tarihinin en önemli görüntüsü; baskı kalitesi mükemmel.',1,'2026-05-11 13:10:00'),(26,22,5,NULL,4,'Boyutları çok etkileyici, evin en güzel köşesine koydum.',0,'2026-05-11 13:15:00'),(27,23,5,NULL,5,'Michelangelo\'nun dehası her detayda hissediliyor.',0,'2026-05-11 13:20:00'),(28,18,6,NULL,5,'Sürrealizmin bu kadar gerçek hissettirdiği bir eser daha yok.',1,'2026-05-11 13:25:00'),(29,9,6,NULL,4,'Eriyen saatler her bakışta farklı bir şey çağrıştırıyor.',0,'2026-05-11 13:30:00'),(30,10,6,NULL,4,'Baskı kalitesi çok yüksek, renk geçişleri çarpıcı.',0,'2026-05-11 13:35:00'),(31,17,8,NULL,5,'Botticelli\'nin en zarif eseri, baskı kalitesi harika.',1,'2026-05-11 13:40:00'),(32,11,8,NULL,4,'Mitolojik atmosferi çok güzel yansıtıyor.',0,'2026-05-11 13:45:00'),(33,12,8,NULL,4,'Renk tonları göz alıcı, çok beğendim.',0,'2026-05-11 13:50:00'),(34,23,9,NULL,5,'Osmanlı kültüründen bu kadar güçlü bir eser başka yok.',1,'2026-05-11 13:55:00'),(35,13,9,NULL,5,'Milli sanatımızın gururunu taşıyan nadide bir eser.',0,'2026-05-11 14:00:00'),(36,14,9,NULL,4,'Tarihi dokuyu çok iyi hissettiriyor, tavsiye ederim.',0,'2026-05-11 14:05:00'),(37,15,9,NULL,2,'Boyutlar sitedeki bilgiden farklı çıktı, biraz yanıltıcı.',0,'2026-05-11 14:10:00'),(38,21,10,NULL,5,'Dini ve sanatsal açıdan en etkili eserlerden biri.',1,'2026-05-11 14:15:00'),(39,16,10,NULL,4,'Da Vinci\'nin anlatıcılığı bu eserde zirveye ulaşmış.',0,'2026-05-11 14:20:00'),(40,17,10,NULL,5,'Kompozisyon mükemmel, her figür ayrı bir hikaye anlatıyor.',0,'2026-05-11 14:25:00'),(41,18,16,NULL,5,'Kuzey\'in Mona Lisası gerçekten hak ettiği üne kavuşmuş.',0,'2026-05-11 14:30:00'),(42,19,16,NULL,5,'Işık oyunları baskıda çok başarılı aktarılmış.',0,'2026-05-11 14:35:00'),(43,20,16,NULL,4,'Biraz daha büyük boy seçeneği olsaydı daha iyi olurdu.',0,'2026-05-11 14:40:00'),(44,21,17,NULL,4,'Gündelik bir anı sanat eserine dönüştüren Vermeer şaşırtıcı.',0,'2026-05-11 14:45:00'),(45,22,17,NULL,5,'Barok ışık kullanımının en güzel örneği.',0,'2026-05-11 14:50:00'),(46,23,17,NULL,4,'Sakin ve huzurlu bir enerji yayıyor, çok sevdim.',0,'2026-05-11 14:55:00'),(47,9,18,NULL,5,'Bu tablo gerçekten heykel gibi, derinlik hissi mükemmel.',0,'2026-05-11 15:00:00'),(48,10,18,NULL,4,'Renk geçişleri çok doğal, Rembrandt\'ın ustalığı yansıyor.',0,'2026-05-11 15:05:00'),(49,11,18,NULL,3,'Fiyatına göre biraz daha kaliteli kağıt bekliyordum.',0,'2026-05-11 15:10:00'),(50,11,19,NULL,5,'Empresyonizme adını veren eser, baskısı da aynı büyü ile dolu.',1,'2026-05-11 15:15:00'),(51,12,19,NULL,4,'Sis ve ışık dengesi baskıda da korunmuş, harika.',0,'2026-05-11 15:20:00'),(52,13,19,NULL,5,'Monet\'nin en ikonik eserlerinden biri, çok beğendim.',0,'2026-05-11 15:25:00'),(53,13,20,NULL,5,'Huzur ve sakinliği en güzel yansıtan eser bu olabilir.',1,'2026-05-11 15:30:00'),(54,14,20,NULL,4,'Renk uyumu göz kamaştırıcı, oturma odama harika yakıştı.',0,'2026-05-11 15:35:00'),(55,15,20,NULL,5,'Doğa ile sanatın bu denli iç içe olduğu başka eser yok.',0,'2026-05-11 15:40:00'),(56,16,21,NULL,5,'Savaşın yıkıcılığını bu kadar güçlü anlatan başka tablo bilmiyorum.',0,'2026-05-11 15:45:00'),(57,17,21,NULL,5,'Kübist parçalanma savaşın kaosunu mükemmel anlatıyor.',0,'2026-05-11 15:50:00'),(58,18,21,NULL,4,'Siyah-beyaz renk tercihi mesajı daha da güçlendiriyor.',0,'2026-05-11 15:55:00'),(59,14,32,NULL,5,'Klimt\'in altın çağının zirvesi, baskı detayları muhteşem.',1,'2026-05-11 16:00:00'),(60,19,32,NULL,4,'Altın yaprak detayları baskıda çok başarılı.',0,'2026-05-11 16:05:00'),(61,20,32,NULL,5,'Viyana Sezesyonunun en parlak yıldızı, harika eser.',0,'2026-05-11 16:10:00'),(62,16,26,NULL,5,'Dalí\'nin bilinçaltı yolculuğu; her bakışta yeni bir şey keşfediyorum.',1,'2026-05-11 16:15:00'),(63,21,26,NULL,4,'Sürrealizm bu eserde doruk noktasına ulaşmış.',0,'2026-05-11 16:20:00'),(64,22,26,NULL,5,'Baskı kalitesi renk doygunluğunu mükemmel korumuş.',0,'2026-05-11 16:25:00'),(65,9,NULL,1,5,'Hayatımda katıldığım en verimli atölye, herkese tavsiye ederim.',1,'2026-05-11 16:30:00'),(66,10,NULL,1,4,'Eğitmen sabırlıydı ve her soruyu yanıtladı, çok memnun kaldım.',1,'2026-05-11 16:35:00'),(67,11,NULL,1,5,'Sıfırdan başlayan biri olarak çok şey öğrendim.',1,'2026-05-11 16:40:00'),(68,12,NULL,1,3,'Katılmadım ama arkadaşlardan çok iyi şeyler duydum.',0,'2026-05-11 16:45:00'),(69,12,NULL,2,5,'Karakalem tekniğini bu atölyede öğrenmek çok değerliydi.',1,'2026-05-11 16:50:00'),(70,13,NULL,2,4,'Orta seviye için çok uygun, teknikler çok iyi anlatıldı.',1,'2026-05-11 16:55:00'),(71,14,NULL,2,5,'Portre çizimine yeni başlayanlar için harika bir başlangıç.',1,'2026-05-11 17:00:00'),(72,15,NULL,3,5,'Doğadan ilham alarak öğrenmek çok güzeldi, harika deneyim.',1,'2026-05-11 17:05:00'),(73,16,NULL,3,4,'Suluboya teknikleri çok net anlatıldı, evde de uyguluyorum.',1,'2026-05-11 17:10:00'),(74,17,NULL,3,4,'Başlangıç seviyesi için çok uygun, kesinlikle tavsiye ederim.',1,'2026-05-11 17:15:00'),(75,18,NULL,4,5,'Kil ile çalışmak bu kadar keyifli olabilir bilmiyordum.',1,'2026-05-11 17:20:00'),(76,19,NULL,4,4,'Form ve doku çalışmaları çok öğreticiydi.',1,'2026-05-11 17:25:00'),(77,20,NULL,4,5,'Tüm seviyeler için gerçekten uygun, çok şey öğrendim.',1,'2026-05-11 17:30:00'),(78,21,NULL,5,5,'Procreate ile bu kadar çok şey yapılabileceğini bilmiyordum.',1,'2026-05-11 17:35:00'),(79,22,NULL,5,4,'Dijital sanata geçiş için mükemmel bir atölye.',1,'2026-05-11 17:40:00'),(80,23,NULL,5,5,'Eğitmen konusuna gerçekten hakim, çok değerliydi.',1,'2026-05-11 17:45:00'),(81,9,NULL,6,5,'Osmanlı\'dan Cumhuriyet\'e geçişi bu kadar iyi anlatan sergi görmedim.',1,'2026-05-11 17:50:00'),(82,11,NULL,6,5,'Her eser ayrı bir hikaye anlatıyordu, çok etkileyiciydi.',1,'2026-05-11 17:55:00'),(83,13,NULL,6,4,'Rehberli tur seçeneği eklenirse daha güzel olur.',1,'2026-05-11 18:00:00'),(84,20,NULL,6,3,'Sergi alanı biraz kalabalıktı, daha ferah ortam tercih ederdim.',0,'2026-05-11 18:05:00'),(85,10,NULL,7,5,'Rönesans\'ı bu denli canlı hissettiren bir sergi ilk kez gördüm.',1,'2026-05-11 18:10:00'),(86,12,NULL,7,4,'Sanat tarihi seminerleri sergiye çok değer kattı.',1,'2026-05-11 18:15:00'),(87,14,NULL,7,5,'Reprodüksiyonların kalitesi gerçeği aratmıyor.',1,'2026-05-11 18:20:00'),(88,23,NULL,7,2,'Bazı eserlerin reprodüksiyon olduğunu bilmiyordum, hayal kırıklığı.',0,'2026-05-11 18:25:00'),(89,18,NULL,8,5,'Genç Türk sanatçıların bu denli özgün işler üretmesi çok sevindirici.',1,'2026-05-11 18:30:00'),(90,20,NULL,8,4,'Karma sergi çok iyi düzenlenmiş, akış çok rahattı.',1,'2026-05-11 18:35:00'),(91,22,NULL,8,4,'Yerli sanatçılara bu platformun sağlanması çok değerli.',1,'2026-05-11 18:40:00'),(92,19,NULL,9,5,'Duygunun bu kadar güçlü ifade edildiği bir sergi görmemiştim.',1,'2026-05-11 18:45:00'),(93,21,NULL,9,4,'Van Gogh ve Munch bir arada, inanılmaz bir atmosfer.',1,'2026-05-11 18:50:00'),(94,23,NULL,9,5,'Tematik kurgu çok başarılı, her oda farklı bir duygu hissettirdi.',1,'2026-05-11 18:55:00'),(95,9,NULL,10,5,'NFT ve dijital sanat paneli gerçekten aydınlatıcıydı.',1,'2026-05-11 19:00:00'),(96,12,NULL,10,4,'Konuşmacılar çok bilgiliydi, sektörden güncel bilgiler aldım.',1,'2026-05-11 19:05:00'),(97,15,NULL,10,5,'Blockchain ve sanat ilişkisi bu konferansta netleşti.',1,'2026-05-11 19:10:00'),(98,21,NULL,10,3,'Konu ilginçti fakat soru-cevap süresi çok kısaydı.',0,'2026-05-11 19:15:00'),(99,10,NULL,11,5,'Dr. Yıldız konuyu çok akıcı anlattı, çok şey öğrendim.',1,'2026-05-11 19:20:00'),(100,13,NULL,11,5,'Rönesans\'ın toplumsal bağlamını bu kadar iyi anlatan seminer görmedim.',1,'2026-05-11 19:25:00'),(101,16,NULL,11,4,'İkonografi bölümü özellikle çok faydalıydı.',1,'2026-05-11 19:30:00'),(102,22,NULL,11,3,'Konu ilginçti ama biraz akademik kaldı, daha interaktif olabilirdi.',0,'2026-05-11 19:35:00'),(103,11,NULL,12,5,'Müze yönetimi üzerine bu kadar kapsamlı bir panel ilk kez gördüm.',1,'2026-05-11 19:40:00'),(104,14,NULL,12,4,'Küratörlük bölümü çok bilgilendirici ve ilham verici.',1,'2026-05-11 19:45:00'),(105,17,NULL,12,5,'Sergi tasarımı konuşması özellikle çok değerliydi.',1,'2026-05-11 19:50:00'),(106,23,NULL,12,3,'İyi organize edilmiş fakat giriş ücreti biraz yüksek.',0,'2026-05-11 19:55:00'),(107,21,NULL,13,5,'Trabzon\'un tarihi zenginliğini bu turla keşfetmek harikaydı.',1,'2026-05-11 20:00:00'),(108,22,NULL,13,4,'Rehber çok bilgiliydi, zaman nasıl geçti anlamadım.',1,'2026-05-11 20:05:00'),(109,23,NULL,13,5,'Yerel sanat geleneğini tanımak çok kıymetliydi.',1,'2026-05-11 20:10:00'),(110,9,NULL,14,5,'İstanbul Modern hayatımın en güzel müze deneyimiydi.',1,'2026-05-11 20:15:00'),(111,13,NULL,14,5,'Pera Müzesi ile birlikte çift müze deneyimi inanılmazdı.',1,'2026-05-11 20:20:00'),(112,17,NULL,14,4,'Rehber çok bilgiliydi, ulaşım organizasyonu da çok iyiydi.',1,'2026-05-11 20:25:00'),(113,19,NULL,14,3,'Tur güzeldi fakat otobüs konforu biraz daha iyi olabilirdi.',0,'2026-05-11 20:30:00'),(114,10,NULL,15,5,'Türkiye\'nin ilk devlet müzesini bu tur sayesinde gerçek anlamda keşfettim.',1,'2026-05-11 20:35:00'),(115,14,NULL,15,4,'Ankara\'nın sanat mirasını ortaya koyan harika bir tur.',1,'2026-05-11 20:40:00'),(116,18,NULL,15,5,'Öğle yemeği dahil olması organizasyonu çok kolaylaştırdı.',1,'2026-05-11 20:45:00'),(117,21,NULL,15,3,'Gidip gelmek biraz yorucuydu ama müze buna değdi.',0,'2026-05-11 20:50:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets`
--

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;
INSERT INTO `support_tickets` VALUES (1,2,'Ali Yılmaz','ali@mail.com','Siparisim 3 gündür kargoda görünüyor, ne zaman gelir?','kapatıldı','hemen gönderiyoruz efendim','2026-05-11 16:39:21','2026-05-09 19:27:38'),(2,3,'Ayşe Kara','ayse@mail.com','Atolye rezervasyonumu iptal etmek istiyorum, ücret iadesi nasil yapılır?','açık',NULL,NULL,'2026-05-09 19:27:38'),(3,8,'eren kuşdil','kusdileren@gmail.com','bilgi alabilir miyim','kapatıldı','tabiiki','2026-05-10 21:50:37','2026-05-10 21:49:25'),(4,5,'Berat Kayar','kayar@ktu.edu.tr','sa','kapatıldı','as','2026-05-11 16:37:58','2026-05-11 16:37:45');
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin@ktu.edu.tr','$2b$12$UpOhmOnrbWInDGbw6yjs.uLHDIF/HhDyr/mkPDpLdfM2QQXKorluy','admin','2026-05-09 19:27:38'),(2,'Ali Yılmaz','ali@mail.com','$2b$12$k4RUUNn6sB82PtzXafNUvuN.iRop2ssNfbfewprhJpsWpM5DLrZnu','kullanici','2026-05-09 19:27:38'),(3,'Ayşe Kara','ayse@mail.com','$2b$12$R/OnVkl6vaA6VeYXI.u/n.LyFliRI3pJWt1DNKK4ylxCQlcTYUm.W','kullanici','2026-05-09 19:27:38'),(4,'Berat Kaymaz','berat@ktu.edu.tr','$2b$12$pcYiEcOnTh5N411D4UKH9.EZMVTZqbMUdriu/3FEAYFZur5vieoKa','kullanici','2026-05-09 19:41:56'),(5,'Berat Kayar','kayar@ktu.edu.tr','$2b$12$jOM6Iy/wFzay1vLmRWCz5uwoFMmziHC24oR2Sqp8cgA/TAzah8Ky6','admin','2026-05-09 19:50:35'),(7,'Arda Gülmez','arda@mail.com','$2b$12$KmXRHXJHiE0RSS8zw79zueartYoztEr1pGtvRvx8YPWD4hJjjwuRe','kullanici','2026-05-10 18:07:25'),(8,'eren kuşdil','kusdileren@gmail.com','$2b$12$9paarJEZ2Vb1K6Drg3A1LuN1Yy4HahmOf4D8z7T94gUEsnPotk/q6','kullanici','2026-05-10 21:49:07'),(9,'Zeynep Arslan','zeynep@mail.com','$2b$12$gckzNGi/7471EdhYRBAwWOq3cwANFVVJxSDTkhQ.PmaDUaHPF0Ja.','kullanici','2026-05-11 10:00:00'),(10,'Mehmet Demir','mehmet@mail.com','$2b$12$nVTTZD4Q9VP7zXRpNDbFg.GVEWtfitA0wDGMW78anUeC8y5UxcEU6','kullanici','2026-05-11 10:00:00'),(11,'Fatma Şahin','fatma@mail.com','$2b$12$MOosD2VtqAzlh8O6FbD7oOlXPwg3YHfKgTJQurCkDhGqJpwUNiSi2','kullanici','2026-05-11 10:00:00'),(12,'Can Öztürk','can@mail.com','$2b$12$6f7yYUPziLLMiZ2nx61QX..XpmlPSviloJnYMPOstdmhcXbA5TkY.','kullanici','2026-05-11 10:00:00'),(13,'Selin Yıldız','selin@mail.com','$2b$12$FVu9CAjEKAKijGKsGpClAuG0MNl9IND82H8KmAJPiQ7Dvw2nraWJu','kullanici','2026-05-11 10:00:00'),(14,'Emre Çelik','emre@mail.com','$2b$12$LIKl39/TX0O74nUZcRHgd.1GaYMVkohxZwnpwzlTVffHV05Faie9O','kullanici','2026-05-11 10:00:00'),(15,'Büşra Koç','busra@mail.com','$2b$12$Q796W7komR0yTu5kioHEzOljBrlc.jwt8nTlcC4u5lwgmKRGNeouu','kullanici','2026-05-11 10:00:00'),(16,'Oğuz Aydın','oguz@mail.com','$2b$12$4jvCTGoo2AtxFoKQL9OMd.zgsQc5X6xRWMPbHh0ovaDgd3bPE0ijC','kullanici','2026-05-11 10:00:00'),(17,'Derya Kaya','derya@mail.com','$2b$12$VwvGgZzlfYvZA3PR2bHgq.V1p7.oVypSzL/f6ZXOPElcYWjMwsLvW','kullanici','2026-05-11 10:00:00'),(18,'Tolga Polat','tolga@mail.com','$2b$12$E1.WwCk8a0qWXzbr0zski.TI.tXDtRJ4/MPo1aMcQsOGElpBaFRXm','kullanici','2026-05-11 10:00:00'),(19,'İrem Doğan','irem@mail.com','$2b$12$/kXKtz13iTvw9UwUvD.eT.zSFoBMVrTl8U7ug.NNH6d3tB62iskhe','kullanici','2026-05-11 10:00:00'),(20,'Serkan Güneş','serkan@mail.com','$2b$12$eQOTLzYJeeiT0InSIR.vr.ztAx43yGQRaVFx5FnGAg/MoC71gqWg.','kullanici','2026-05-11 10:00:00'),(21,'Merve Aktaş','merve@mail.com','$2b$12$v3uBUYBsEV0zlGETf7C2veopDI5/WbvvmnctoIEK6bc.uhu/doy3G','kullanici','2026-05-11 10:00:00'),(22,'Burak Erdoğan','burak@mail.com','$2b$12$Yq4ux6zIMaGx/u2Pb6KrEeDeBqV3T/X1N7QIsT65Xgaz/4QyaAwEq','kullanici','2026-05-11 10:00:00'),(23,'Nisan Toprak','nisan@mail.com','$2b$12$nIjsYCxdqTKqLcUm3KuaFeGx6Amm25kM2Nh0mbXgktDAha5JCe6je','kullanici','2026-05-11 10:00:00');
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

-- Dump completed on 2026-05-11 22:04:58
