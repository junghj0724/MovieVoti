CREATE DATABASE  IF NOT EXISTS `movievotidb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `movievotidb`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: movievotidb
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `movie_diary`
--

DROP TABLE IF EXISTS `movie_diary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_diary` (
  `diary_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `movie_title` varchar(200) NOT NULL,
  `watched_date` date NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `companion` varchar(100) DEFAULT NULL,
  `mood` varchar(50) DEFAULT NULL,
  `content` text,
  `poster_path` varchar(200) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`diary_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `movie_diary_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_diary`
--

LOCK TABLES `movie_diary` WRITE;
/*!40000 ALTER TABLE `movie_diary` DISABLE KEYS */;
INSERT INTO `movie_diary` VALUES (1,'test1','어벤져스: 엔드게임','2025-12-08','CGV','친구와','?','재미있었다','/z7ilT5rNN9kDo8JZmgyhM6ej2xv.jpg','2025-12-08 13:30:49'),(2,'test1','주토피아 2','2025-12-10','CGV','가족','?','감동적이었다','/ib6v6qUXzez1x2qIOLN7C0yJNPQ.jpg','2025-12-08 14:12:10');
/*!40000 ALTER TABLE `movie_diary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `open_dt` varchar(20) DEFAULT NULL,
  `audi_acc` varchar(50) DEFAULT NULL,
  `poster_path` varchar(500) DEFAULT NULL,
  `vote_average` decimal(3,1) DEFAULT NULL,
  `daily_rank` int DEFAULT '0',
  `is_upcoming` tinyint DEFAULT '0',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `overview` text,
  `genre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`movie_id`),
  KEY `IDX_MOVIES_TITLE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'위키드: 포 굿','2025-11-19','871,094명','https://image.tmdb.org/t/p/w500/2QQHvIysfrRhOE5fpaKNlxIwUW4.jpg',6.8,5,0,'2025-12-08 22:29:19','전혀 다르지만 서로에게 가장 소중한 친구가 된 ‘엘파바’와 ‘글린다’. 쉬즈에서의 마법같았던 둘의 우정은 오즈의 마법사와 그를 둘러싼 비밀들을 알게 되면서 다른 길을 선택할 수밖에 없게 내몰린다. 사람들의 시선을 더 이상 두려워하지 않게 된 사악한 마녀 ‘엘파바’와 사람들의 사랑을 받으면서도 모든 걸 잃을까 두려운 착한 마녀 ‘글린다’. 서로 대척점에 서게 된 두 사람은 거대한 여정의 끝에서 운명을 영원히 바꿀 선택을 마주하게 된다.',NULL),(2,'나우 유 씨 미 3','2025-11-12','1,326,700명','https://image.tmdb.org/t/p/w500/dECA069mRikkghzgSBsM0cvic4F.jpg',6.3,7,0,'2025-12-08 22:29:19','한때 더러운 방식으로 돈을 모으는 재벌들을 시원하게 혼내주던 마술사기단 ‘포 호스맨’. 은퇴 후 평범한 삶을 살고 있던 그들에게 새로운 임무를 알리는 의미심장한 카드가 배달된다. 그렇게 다시 모이게 된 오리지널 ‘포 호스맨’은 자신들을 흉내 내던 신예 마술사들까지 영입하며 미션을 준비한다. 그들의 목표는 무기 밀매, 자금 세탁 등 더러운 돈에 물든 ‘하트 다이아몬드’를 훔치는 것. 하지만 다이아몬드를 훔치고, 통쾌한 쇼를 선보이려는 이들 앞에는 수많은 함정이 펼쳐지는데…',NULL),(3,'극장판 체인소 맨: 레제편','2025-09-24','3,393,426명','https://image.tmdb.org/t/p/w500/yb87INOllFB52NS9CchWyljTaIx.jpg',7.9,8,0,'2025-12-08 22:29:19','데블 헌터로 일하는 소년 ‘덴지’는 조직의 배신으로 죽음에 내몰린 순간 전기톱 악마견 ‘포치타’와의 계약으로 하나로 합쳐져 누구도 막을 수 없는 존재 ‘체인소 맨’으로 다시 태어난다. 악마와 사냥꾼, 그리고 정체불명의 적들이 얽힌 잔혹한 전쟁 속에서 ‘레제’라는 이름의 미스터리한 소녀가 ‘덴지’ 앞에 나타나는데… ‘덴지’는 사랑이라는 감정에 이끌려 지금껏 가장 위험한 배틀에 몸을 던진다!',NULL),(4,'국보','2025-11-19','143,954명','https://image.tmdb.org/t/p/w500/gwQcvBdoMWolyBcKn6VbdqJdUZx.jpg',8.6,9,0,'2025-12-08 22:29:19','눈앞에서 아버지를 잃고 가부키 명문가 하나이 한지로에게 맡겨진 소년 키쿠오. 운명이 결정짓는 세계에 이방인으로 뛰어든 키쿠오는 명문가의 아들 슌스케와 부딪히며 라이벌로 성장하게 된다. 서로의 길을 시험하는 치열한 경쟁에 놓인 두 사람. 세상에 단 하나뿐인 이름 국보를 향해 달리기 시작하는데…',NULL),(5,'프레데터: 죽음의 땅','2025-11-05','401,062명','https://image.tmdb.org/t/p/w500/8lpCbwbYh9SSzCFsHDndZHKrcD4.jpg',7.4,0,0,'2025-11-23 19:22:43',NULL,NULL),(6,'나혼자 프린스','2025-11-19','28,147명','https://image.tmdb.org/t/p/w500/Anuwb1noodgi2sIyxGrQ2NiAo1p.jpg',0.0,0,0,'2025-11-23 19:22:43',NULL,NULL),(7,'퍼스트 라이드','2025-10-29','724,518명','https://image.tmdb.org/t/p/w500/3KyiJ6yvw4thfSoBxntSb3ZNrg1.jpg',8.0,0,0,'2025-11-23 19:22:43',NULL,NULL),(8,'세계의 주인','2025-10-22','156,949명','https://image.tmdb.org/t/p/w500/1UrMMAChGXORYrbCef7GNId98Vk.jpg',9.0,0,0,'2025-12-03 17:02:54','반장, 모범생, 학교 인싸인 동시에 연애가 가장 큰 관심사인 열여덟 이주인. 어느 날, 반 친구 수호가 제안한 서명운동에 전교생이 동참하던 중 오직 주인만이 내용에 동의할 수 없다며 나 홀로 서명을 거부한다. 어떻게든 설득하려는 수호와 단호한 주인의 실랑이가 결국 말싸움으로 번지고, 화가 난 주인이 아무렇게나 질러버린 한마디가 주변을 혼란에 빠뜨린다. 설상가상, 주인을 추궁하는 익명의 쪽지가 배달되기 시작하는데…….',NULL),(9,'극장판 귀멸의 칼날: 무한성편','2025-08-22','5,664,521명','https://image.tmdb.org/t/p/w500/m6Dho6hDCcL5KI8mOQNemZAedFI.jpg',7.6,0,0,'2025-12-03 17:02:54','혈귀로 변해버린 여동생 네즈코를 인간으로 되돌리기 위해 혈귀를 사냥하는 조직인 《귀살대》에 입대한 카마도 탄지로. 입대 후 동료인 아가츠마 젠이츠, 하시비라 이노스케와 함께 많은 혈귀와 싸우고, 성장하면서 세 사람의 우정과 유대는 깊어진다. 탄지로는 《귀살대》 최고위 검사인 《주》와도 함께 싸웠다. 「무한열차」에서는 염주・렌고쿠 쿄쥬로, 「유곽」에서는 음주・우즈이 텐겐, 「도공 마을」에서는 하주・토키토 무이치로, 연주・칸로지 미츠리와 함께 혈귀를 상대로 격렬한 전투를 벌였다. 그 후 다가올 혈귀와의 결전에 대비해 귀살대원들과 함께 《주》가 주도하는 합동 강화 훈련에 참가해 훈련을 받던 도중 《귀살대》의 본부인 우부야시키 저택에 나타난 키부츠지 무잔. 어르신의 위기에 달려온 《주》들과 탄지로였지만, 무잔의 술수로 의문의 공간으로 떨어지고 말았는데. 탄지로 일행이 떨어진 곳, 그곳은 혈귀의 본거지 《무한성》─ “귀살대”와 “혈귀”의 최종 결전의 포문이 열린다.',NULL),(10,'극장판 똘똘이: 아기공룡의 비밀','2025-11-07','33,313명','https://image.tmdb.org/t/p/w500/3eKzeVE8JN04iQaGWDw6adu7Ook.jpg',0.0,0,0,'2025-11-23 19:22:43',NULL,NULL),(11,'극장판 주술회전: 시부야사변 X 사멸회유','2025-12-03','199,483명','https://image.tmdb.org/t/p/w500/ifK2v7oQQrgqrmDu7sr1TgoAPT9.jpg',5.2,3,0,'2025-12-08 22:29:19','2018년 10월 31일 시부야 역 주변에 갑자기 ‘장막’이 내려지고, 다수의 일반인이 갇히게 된다. 그곳에 홀로 뛰어든 현대 최강의 주술사, 고죠 사토루. 그러나 그곳에는 고죠의 봉인을 꾀하는 주저사·주령들이 기다리고 있었다. 시부야에 집결하는 이타도리 유지를 비롯한 수많은 주술사들. 전례 없는 대규모 주술전 「시부야사변」이 시작된다—. 그리고 싸움은, 최악의 주술사 카모 노리토시가 꾸민 데스 게임 「사멸회유」로 이어진다. 「시부야사변」을 거쳐, 마굴로 변한 전국 10개의 결계(콜로니). 대혼란의 한가운데, 이타도리의 사형 집행인으로 특급 주술사 옷코츠 유타가 나타난다. 절망 속에서도 싸움을 계속하는 이타도리. 무정하게도 칼날을 겨누는 옷코츠. 가속해가는 저주의 혼돈. 같은 스승을 둔 이타도리와 옷코츠, 두 사람의 사투가 시작된다——.',NULL),(12,'주토피아 2','2025-11-26','','https://image.tmdb.org/t/p/w500/ib6v6qUXzez1x2qIOLN7C0yJNPQ.jpg',7.7,1,0,'2025-12-08 23:11:37','미스터리한 뱀 게리가 나타난 순간, 주토피아가 다시 흔들리기 시작했다! 혼란에 빠진 도시를 구하기 위해 환상의 콤비 주디와 닉이 잠입 수사에 나서고 상상 그 이상의 진실과 위협을 마주하게 되는데...!',NULL),(13,'더 러닝 맨','2025-12-10','','https://image.tmdb.org/t/p/w500/klfSEbFOquMFjBQJ5uKAfp0rrsK.jpg',6.8,0,1,'2025-12-08 22:29:19','실직한 가장 ‘벤 리처즈’가 거액의 상금을 위해 30일간 잔인한 추격자들로부터 살아남아야 하는 글로벌 서바이벌 프로그램에 참가하며 펼쳐지는 추격 액션 블록버스터',NULL),(14,'아바타: 불과 재','2025-12-17','','https://image.tmdb.org/t/p/w500/4M6dPb0UP3qwSnGn4OF5QKSYB56.jpg',0.0,0,1,'2025-12-08 22:29:19','인간들과의 전쟁으로 첫째 아들 ‘네테이얌’을 잃은 후, ‘제이크’와 ‘네이티리’는 깊은 슬픔에 빠진다. 상실에 빠진 이들 앞에 \'바랑\'이 이끄는 재의 부족이 등장하면서, 판도라는 더욱 큰 위험에 빠지게 되고, ‘설리’ 가족은 선택의 기로에 서게 되는데…',NULL),(15,'프레디의 피자가게 2','2025-12-03','86,134명','https://image.tmdb.org/t/p/w500/kEmPnUUXaF9hPgDMlc0eJht5JYO.jpg',6.4,4,0,'2025-12-08 22:29:19','소문과 괴담에 휘말려 폐업한 ‘프레디의 피자가게’ 본점이 수십년 만에 다시 열리고, 그곳에 오랫동안 잠들어 있던 신형 프레디와 친구들이 눈을 뜨게 된다. 안면 인식 시스템을 가진 한층 더 기괴하고 오싹해진 신형 애니메트로닉스들은 이제 피자가게 밖으로 나와 세상을 공포에 몰아넣기 시작하는데…',NULL),(16,'한란','2025-11-26','18,305명','https://image.tmdb.org/t/p/w500/mSnjSyBA1JLakusxZ2Hryzpw1ee.jpg',0.0,0,0,'2025-12-03 17:02:54','1948년 제주, 토벌대를 피해 한라산으로 피신하게 된 아진은 딸 해생과 생이별을 한다. 아진은 마을에 두고 온 딸 해생을 걱정하며 산에 오르던 중 군인들이 마을을 전부 불태웠다는 이야기를 듣게 되고, 딸을 찾아 하산을 결심한다. 딸을 구하러 가는 엄마 아진과 엄마를 찾아 산을 오르는 딸 해생의 살아남기 위한 생존 여정이 시작되는데…',NULL),(17,'석류의 빛깔 ','2025-11-26','11,982명','https://image.tmdb.org/t/p/w500/k1qAufYqTp4RZ92OEMrAShuupY.jpg',7.3,0,0,'2025-12-03 17:02:54','“창문으로 세상을 봅니다. 창문 너머에 세상이 있습니다.” 18세기 아르메니아 시인 ‘사야트 노바’ 그의 일생을 은유와 상징으로 담은 이미지를 색, 빛, 소리, 향기로 빚어낸 영화사에 다시 없을 경이로운 걸작.',NULL),(18,'샤이닝','2023-06-28','','https://image.tmdb.org/t/p/w500/aaItbIXZlC2C7Arg3PI0IglKi0.jpg',8.2,0,0,'2025-12-03 17:02:54','소설가인 잭 토랜스는 콜로라도 산맥에 있는 오버룩 호텔의 관리인으로 취직한다. 다음 시즌 준비를 하는 이곳은 겨울 동안 폐쇄되기 때문에 토랜스의 가족들만 호텔에 머물게 된다. 갑자기 몰아친 폭설로 잭과 아내 웬디와 아들과 함께 호텔에 고립되고, 투시와 텔레파시 능력이 있는 잭의 아들 대니는 호텔에 유령이 있으며 유령들이 천천히 아버지를 미치게 하고 있음을 알게 된다. 잭은 과거에 스스로 자신의 아내와 두 딸을 죽인 이곳의 예전 관리인 그레이디의 유령을 만난다. 과거에 있었던 살인사건의 악령에 휘말린 잭은 호텔을 공포의 도가니로 몰아가는데...',NULL),(19,'척의 일생','2025-12-24','','https://image.tmdb.org/t/p/w500/vWYRZBqgkZVYN016v1lUOTUGBy0.jpg',7.4,0,1,'2025-12-08 22:29:19','인터넷은 끊기고, 도로 곳곳은 구멍이 뚫려 마비된 세상. 마치 지구의 마지막 날이 다가오는 것만 같은 나날들의 연속이다. 교사 \'마티\'는 온 세상이 언제 어둠에 갇혀도 이상할리 없는 지금, 이혼했지만 사랑이 남은 ‘펠리샤’를 만나기 위해 길을 나선다. 그런데 이 절박한 시간에도 거리에서, TV에서, 라디오에서 끊임없이 나오는 누군가를 위한 광고. \"39년 동안의 근사했던 시간, 고마웠어요 척!\" 하지만 주변의 그 누구도 알거나 본 적이 없다는 이 \'척\'이라는 남자는 마티에게 커다란 궁금증을 남긴다. 그는 누구일까? 세상은 정말 사라져만 가는 것일까?',NULL),(20,'화양연화','2000-10-20','','https://image.tmdb.org/t/p/w500/mjkr1IamzDiL5mLIbnuhiYOXLqg.jpg',8.1,0,0,'2025-12-03 17:02:54','홍콩의 지역 매일 신문 편집장인 초 모완, 수출회사의 비서로 근무하는 수 리첸. 둘은 상하이 지역의 한 건물로 같은 날 이사하게 된다. 이사 날부터 의도치 않게 오가며 자주 부딪히게 되는 두 사람. 둘 다 가정이 있지만 어쩐지 배우자들은 자리를 비우는 날이 더 많고 두 사람의 외로움은 서로에게 낯설지 않게 다가와 둘을 가깝게 한다. 두 사람은 점점 감정이 깊어질수록 겉으로는 더욱 조심스러워지고 예견되어 있는 이별 앞에 마음이 혼란스럽고, 서로의 자리에서 마음으로 바라는 그들의 사랑은 애절하기만 하다.',NULL),(21,'어벤져스','2012-04-25','','https://image.tmdb.org/t/p/w500/krgjV3rJtBcEpQehODKXNCt6uFL.jpg',7.9,0,0,'2025-12-03 17:19:25','에너지원 큐브를 이용한 적의 등장으로 인류가 위험에 처하자 국제평화유지기구인 쉴드의 국장 닉 퓨리는 어벤져스 작전을 위해 전 세계에 흩어져 있던 슈퍼히어로들을 찾아나선다. 아이언맨부터 토르, 헐크, 캡틴 아메리카는 물론, 쉴드의 요원인 블랙 위도우, 호크 아이까지, 최고의 슈퍼히어로들이 어벤져스의 멤버로 모이게 되지만, 각기 개성이 강한 이들의 만남은 예상치 못한 방향으로 흘러가는데...',NULL),(22,'어벤져스: 인피니티 워','2018-04-25','','https://image.tmdb.org/t/p/w500/kmP6viwzcEkZeoi1LaVcQemcvZh.jpg',8.2,0,0,'2025-12-08 22:32:00','타노스는 6개의 인피니티 스톤을 획득해 신으로 군림하려 한다. 그것은 곧 인류의 절반을 학살해 우주의 균형을 맞추겠다는 뜻. 타노스는 닥터 스트레인지가 소유한 타임 스톤, 비전의 이마에 박혀 있는 마인드 스톤을 차지하기 위해 지구를 침략한다. 아이언맨과 스파이더맨은 가디언즈 오브 갤럭시의 멤버들과 타노스를 상대한다. 지구에선 캡틴 아메리카, 완다, 블랙 위도우, 블랙 팬서 등이 비전을 지키기 위해 뭉친다.',NULL),(23,'어벤져스: 엔드게임','2019-04-24','','https://image.tmdb.org/t/p/w500/z7ilT5rNN9kDo8JZmgyhM6ej2xv.jpg',8.2,0,0,'2025-12-08 22:30:10','어벤져스의 패배 이후 지구는 초토화됐고 남은 절반의 사람들은 정신적 고통을 호소하며 하루하루를 근근이 버텨나간다. 와칸다에서 싸우다 생존한 히어로들과 우주의 타이탄 행성에서 싸우다 생존한 히어로들이 뿔뿔이 흩어졌는데, 아이언맨과 네뷸라는 우주를 떠돌고 있고 지구에 남아 있는 어벤져스 멤버들은 닉 퓨리가 마지막에 신호를 보내다 만 송신기만 들여다보며 혹시 모를 우주의 응답을 기다리는 중이다. 애초 히어로의 삶을 잠시 내려놓고 가족과 시간을 보내던 호크아이 역시 헤아릴 수 없는 마음의 상처를 입은 채 사라지고 마는데...',NULL),(24,'어벤져스: 둠스데이','2026-12-17','','https://image.tmdb.org/t/p/w500/6eB2oh1SplddsZYCdayrIdrIGLd.jpg',0.0,0,0,'2025-12-03 17:19:25','',NULL),(25,'어벤져스: 에이지 오브 울트론','2015-04-22','','https://image.tmdb.org/t/p/w500/y8pY5MIzpPAnF5vYUNm1tw1AzL3.jpg',7.3,0,0,'2025-12-03 17:19:25','토니 스타크는 뉴욕전쟁 때와 같은 사태가 벌어지지 않도록 한때 가동하려다 중단된 휴면 상태의 평화 유지 프로그램을 작동 시키려 한다. 배너 박사와 함께 지구를 지킬 최강의 인공지능 울트론을 탄생시키게 되지만, 울트론은 예상과 다르게 지배를 벗어나 폭주하기 시작하고 어벤져스는 지구의 운명이 걸린 거대한 시험대에 오르게 된다. 울트론이 자신을 복제해 위협을 가하자 이를 저지하기 위해 아이언맨, 캡틴 아메리카, 토르, 헐크, 블랙위도우, 호크아이 등으로 구성된 어벤져스와 새로 합류하게 되는 퀵 실버, 스칼렛 위치 남매와 불안한 동맹을 맺는다.',NULL),(26,'어벤져스: 시크릿 워즈','2027-12-17','','https://image.tmdb.org/t/p/w500/f0YBuh4hyiAheXhh4JnJWoKi9g5.jpg',0.0,0,0,'2025-12-03 17:19:25','',NULL),(27,'어벤져스 그림: 시간 전쟁','2018-05-01','','https://image.tmdb.org/t/p/w500/4ARjDBmYpOocL8kVTyWWSSzx5Df.jpg',5.1,0,0,'2025-12-03 17:19:25','시공간의 균열로 인해 마법 세계와의 통로가 열렸다! 아틀란티스의 여왕 막다는 마법의 힘으로 온 세상을 손에 넣고자 한다. 이를 막기 위해 나타난 어벤져스들은 막다의 계략으로 차원의 틈에 휘말려 과거에 갇히고 만다. 여왕의 손에서 미래와 세상을 구하기 위한 최후의 전쟁이 시작된다!',NULL),(28,'레고 마블 어벤져스: 코드 레드','2023-10-26','','https://image.tmdb.org/t/p/w500/cCIKixVHGIynoZR2xMg9uygey5f.jpg',6.5,0,0,'2025-12-03 17:19:26','뉴욕을 지키기 위해 모인 어벤져스. 그러나 블랙 위도우는 아버지 레드 가디언이 자신을 따라다니며 어린애 취급하자 화를 내고 만다. 그 후 레드 가디언이 갑자기 사라지고, 어벤져스는 \'콜렉터\'가 이름에 \'레드\'라는 단어가 들어간 영웅과 악당을 납치하고 다닌다는 사실을 알게 된다. 어벤져스는 힘을 합쳐 콜렉터의 은신처를 찾고 그의 수집품이 되어버린 영웅과 악당을 모두 구할 수 있을까?',NULL),(29,'레고 마블 어벤져스: 미션 데몰리션','2024-10-17','','https://image.tmdb.org/t/p/w500/2gLpCJNao2AgHhCuuhwwlvL5hb1.jpg',6.5,0,0,'2025-12-03 17:19:26','완전히 새로운 애니메이션 스페셜 ‘레고 마블: 미션 데몰리션’은 독창적인 매력이 확실한 유명 시리즈의 10번째 작품이다. 마블과 레고 그룹이 선보이는 이 최신 스페셜의 주인공은 히어로가 되고자 하는 젊은 슈퍼히어로 팬으로, 어벤져스의 세상을 파괴할 기회를 노리고 있는 강력한 새 악당을 우연한 계기로 해방시키고 만다.',NULL),(30,'넥스트 어벤져스: 히어로즈 오브 투모로우','2008-09-02','','https://image.tmdb.org/t/p/w500/1y4J9HZJoTIMdt77wCq80uXaQJ.jpg',7.0,0,0,'2025-12-03 17:19:26','울트론의 세력 확장을 피해 숨어 지내던 어벤져의 아이들은 우연히 자신들의 운명을 깨닫고 울트론에게 맞서 싸우기로 결심한다.',NULL),(31,'얼티밋 어벤져스 2','2006-08-08','','https://image.tmdb.org/t/p/w500/2bfVNvLKWaxFh1LiOKlvxgiHOXn.jpg',6.8,0,0,'2025-12-03 17:19:26','신비한 와칸다는 세계 대부분이 알지 못하는 아프리카의 가장 어두운 심장부에 있습니다. 폐쇄된 국경 뒤에 숨겨진 고립된 땅, 젊은 왕 블랙 팬서에 의해 강력하게 보호됩니다. 하지만 잔인한 외계 침략자들이 공격할 때, 그 위협은 흑표범에게 그의 백성들의 신성한 법령을 거스르고 외부인들에게 도움을 요청하는 것 외에는 선택의 여지가 없게 합니다.',NULL),(32,'레고 마블 어벤져스: 훈련생 로키, 뒤틀린 시간','2021-11-01','','https://image.tmdb.org/t/p/w500/eyBifMbovoQbyuNXHOFYo7tsInp.jpg',7.1,0,0,'2025-12-03 17:19:26','',NULL),(33,'어벤져스 오브 저스티스','2018-07-20','','https://image.tmdb.org/t/p/w500/yymsCwKPbJIF1xcl2ih8fl7OxAa.jpg',5.1,0,0,'2025-12-03 17:19:26','은하계 최강의 빌런 조크스터는 태양을 없애 지구에 새로운 빙하기를 불러일으키고자 한다. 슈퍼히어로 슈퍼배트는 히어로 동료들과 함께 조크스터에 맞서 지구를 지켜내야만 한다. 이제 전 인류의 운명이 걸린 최후의 대결이 시작된다.',NULL),(34,'어벤져스 컨피덴셜: 블랙 위도우 앤 퍼니셔','2014-04-19','','https://image.tmdb.org/t/p/w500/bsXC1PaRg8eEvVXCTVtNwLLvcyl.jpg',6.4,0,0,'2025-12-03 17:19:26','지구의 안보가 위협당하는 위기의 상황에서 슈퍼히어로들을 불러모아 세상을 구하는, 일명 [어벤져스] 작전.  지구의 평화를 위협하는 적의 등장으로 인류가 위험에 처하자 국제평화유지기구인 쉴드 (S.H.I.E.L.D)의 국장 닉 퓨이는 [어벤져스] 작전을 위해 전 세계에 흩어져 있던 슈퍼히어로들을 찾아나선다. 아이언맨부터 토르, 헐크, 캡틴 아메리카는 물론, 쉴드의 요원인 블랙 위도우, 호크 아이까지, 최고의 슈퍼히어로들이 [어벤져스]의 멤버로 모이게 되지만, 각기 개성이 강한 이들의 만남은 예상치 못한 방향으로 흘러가는데…',NULL),(35,'스파이디, 그리고 아이언맨: 어벤져스 출동!','2025-10-16','','https://image.tmdb.org/t/p/w500/rhyKyeO9oedqXH6JRkCTu0W0gg0.jpg',3.7,0,0,'2025-12-03 17:19:26','스파이디, 아이언맨, 어벤져스가 힘을 모은다.',NULL),(36,'썬더볼츠*','2025-04-30','','https://image.tmdb.org/t/p/w500/iTX4O9gb8Jn0F5N5WgYnbIopdnP.jpg',7.3,0,0,'2025-12-03 17:19:26','어벤져스가 사라진 후, 세계 최대의 위협과 마주한 세상을 구하기 위해 전직 스파이, 암살자, 살인 청부 업자 등 마블의 별난 놈들이 펼치는 예측불허 팀플레이를 담은 액션 블록버스터',NULL),(37,'얼티메이트 어벤저스','2006-02-21','','https://image.tmdb.org/t/p/w500/zyMZ2boSccbaUjOkl6AdzLb6KKd.jpg',6.9,0,0,'2025-12-03 17:19:26','수퍼 군인 혈청으로 탄생한 캡틴 아메리카는 2차 세계대전이 한창이던 1945년, 나치와 전투를 벌이던 중 북극의 빙하에 갇혀 냉동된다. 21세기가 되어 그의 혈액으로부터 수퍼 군인 혈청을 추출하려는 미군에 의해 다시 깨어난 그는 또 다시 거대한 악의 세력에 위협받는 세계를 구하기 위해 나서야할 상황을 맞이하는데...',NULL),(38,'윗집 사람들','2025-12-03','185,843명','https://image.tmdb.org/t/p/w500/mgajoux4Aol4i042vWiy24gyTyc.jpg',0.0,2,0,'2025-12-08 22:29:19','불같던 결혼 생활은 사라지고 무미건조한 일상만 남은 정아와 현수. 요즘 두 사람을 가장 괴롭히는 건, 매일 밤 지나치게 활기찬 소리를 내는 윗집 부부 김 선생과 수경이다. 정아는 이사 공사 소음을 참아준 윗집 부부를 위해 예의상 저녁 식사 자리를 마련하고 그날 저녁, 식탁에 마주 앉은 윗집 부부는 정아와 현수에게 전혀 예상하지 못한 제안을 하게 되는데…',NULL),(39,'정보원','2025-12-03','101,456명','https://image.tmdb.org/t/p/w500/vY1eAlMBfng26chmN5PvHV6Wn8z.jpg',0.0,6,0,'2025-12-08 22:29:19','공들인 작전 실패로 강등당한 후 열정도, 의지도, 수사 감각도 모두 잃은 형사 오남혁. 이제 그가 바라는 것은 오로지 한탕과 은퇴뿐. 밀수 조직에 심어둔 정보원 조태봉을 이용해 인생 역전을 꿈꾸지만 의리도, 믿음도 없는 조태봉은 숨겨뒀던 돈을 챙겨 빠르게 손절을 하고, 뒤늦게 밀수 조직 사무실에 도착한 오남혁은 낯선 무리에게 납치를 당한다. 이 일로 얼떨결에 목숨이 걸린 범죄 사건에 휘말리게 된 오남혁과 조태봉은 각자의 목적을 위해 동상이몽 공조 수사를 시작하는데…',NULL),(40,'콘크리트 마켓','2025-12-03','19,039명','https://image.tmdb.org/t/p/w500/zptqwi1iObqjq9vbiozbu9iMUQp.jpg',0.0,10,0,'2025-12-08 22:29:19','대지진 이후 유일하게 남은 아파트. 그곳에서 현금 대신 통조림이 화폐가 되고, 식량과 연료, 약품 등 무엇이든 사고파는 황궁마켓이 열린다. 통조림을 훔치기 위해 황궁마켓에 숨어든 희로는 우연히 마켓 상인 회장인 박상용에 대한 비밀을 알게 되고, 상용의 왼팔인 태진에게 마켓의 새로운 주인이 될 수 있는 방법을 제안한다. 그러나 서로 다른 목적을 품은 두 사람의 거래가 시작되는 순간, 견고하던 황궁마켓의 질서가 흔들리기 시작하는데…',NULL),(41,'누벨바그','2025-12-31','','https://image.tmdb.org/t/p/w500/8oWmrXajfr2AtSLlWb91S98vjjt.jpg',7.4,0,1,'2025-12-08 22:29:19','1959년 파리, 젊은 비평가 ‘고다르’가 올해 최악의 영화이자 세기의 데뷔작이 될 <네 멋대로 해라>를 찍는 미친 모험의 시간으로 점프하는 리처드 링클레이터의 시네마 매직',NULL),(42,'극장판 짱구는 못말려: 초화려! 작열하는 떡잎마을 댄서즈','2025-12-24','','https://image.tmdb.org/t/p/w500/hh2eWvm91RMIVQb0esjQab8sWgh.jpg',7.0,0,1,'2025-12-08 22:29:19','떡잎마을 어린이 엔터 페스티벌에서 우승한 떡잎마을 방범대 짱구, 맹구, 철수, 유리, 훈이는 우승 상품으로 인도 엔터 페스티벌 무대에 초청받아, 여행을 만끽한다. 짱구와 맹구는 수상한 잡화점에서 코 모양처럼 생긴 배낭을 발견하고, 맹구는 배낭의 콧구멍에 꽂혀 있는 휴지(?)를 홀린 듯이 자신의 코에 꽂아버린다. 그 순간, 알 수 없는 힘이 맹구에게서 뿜어져 나오는데…! 겉보기에는 평범한 휴지 같은 이 종이의 비밀은 바로, 종이를 코에 꽂는 사람에게 욕망을 불러일으켜 무자비하고 제멋대로인 폭군으로 만들어 버리는 것. “나에 대해 다 아는 척하지 마” 순둥이 맹구, 흑화해서 폭군으로 대변신! 폭주를 시작한다!',NULL),(43,'주토피아','2016-02-11','','https://image.tmdb.org/t/p/w500/fZcab1yiKXsjx3S8D4KRHZsnMGC.jpg',7.8,0,0,'2025-12-08 23:11:37','어릴 적부터 경찰이 꿈이었던 토끼 주디 홉스는 주변의 만류에도 불구하고 경찰학교에 들어가 당당히 수석으로 졸업한다. 온갖 동물들이 모여 살며 교양 있고 세련된 라이프 스타일을 주도하는 대도시 주토피아에 자원한 주디는 의욕을 안고 출근하지만, 상사는 작은 토끼라는 이유로 주차관리 같은 소일거리만 시킨다. 따분하게 업무를 보던 주디는 아이스크림 불법 판매를 일삼는 사기꾼 여우 닉 와일드를 알게 되고, 그와 함께  48시간 안에 주토피아에서 벌어지고 있는 연쇄 실종사건을 추적해야만 하는데...',NULL);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `movie_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `uq_user_movie` (`user_id`,`movie_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'test1',12,5,'재밌다','2025-12-03 17:13:00');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `join_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(10) DEFAULT 'USER',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','1234','관리자','admin@movievoti.com','2025-11-23 18:02:43','ADMIN'),('test1','password','test1','test1@naver.com','2025-11-23 18:45:30','USER');
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

-- Dump completed on 2025-12-08 23:14:36
