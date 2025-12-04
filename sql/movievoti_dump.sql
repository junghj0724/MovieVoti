CREATE DATABASE  IF NOT EXISTS `movievotidb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `movievotidb`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: movievotidb
-- ------------------------------------------------------
-- Server version	8.0.41

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'주토피아 2','2025-11-26','2,550,143명','https://image.tmdb.org/t/p/w500/ib6v6qUXzez1x2qIOLN7C0yJNPQ.jpg',7.7,1,0,'2025-12-04 12:55:51','미스터리한 뱀 게리가 나타난 순간, 주토피아가 다시 흔들리기 시작했다! 혼란에 빠진 도시를 구하기 위해 환상의 콤비 주디와 닉이 잠입 수사에 나서고 상상 그 이상의 진실과 위협을 마주하게 되는데...!',NULL),(2,'극장판 주술회전: 시부야사변 X 사멸회유','2025-12-03','55,313명','https://image.tmdb.org/t/p/w500/ifK2v7oQQrgqrmDu7sr1TgoAPT9.jpg',5.1,2,0,'2025-12-04 12:55:51','2018년 10월 31일 시부야 역 주변에 갑자기 ‘장막’이 내려지고, 다수의 일반인이 갇히게 된다. 그곳에 홀로 뛰어든 현대 최강의 주술사, 고죠 사토루. 그러나 그곳에는 고죠의 봉인을 꾀하는 주저사·주령들이 기다리고 있었다. 시부야에 집결하는 이타도리 유지를 비롯한 수많은 주술사들. 전례 없는 대규모 주술전 「시부야사변」이 시작된다—. 그리고 싸움은, 최악의 주술사 카모 노리토시가 꾸민 데스 게임 「사멸회유」로 이어진다. 「시부야사변」을 거쳐, 마굴로 변한 전국 10개의 결계(콜로니). 대혼란의 한가운데, 이타도리의 사형 집행인으로 특급 주술사 옷코츠 유타가 나타난다. 절망 속에서도 싸움을 계속하는 이타도리. 무정하게도 칼날을 겨누는 옷코츠. 가속해가는 저주의 혼돈. 같은 스승을 둔 이타도리와 옷코츠, 두 사람의 사투가 시작된다——.',NULL),(3,'윗집 사람들','2025-12-03','34,660명','https://image.tmdb.org/t/p/w500/mgajoux4Aol4i042vWiy24gyTyc.jpg',0.0,3,0,'2025-12-04 12:55:51','불같던 결혼 생활은 사라지고 무미건조한 일상만 남은 정아와 현수. 요즘 두 사람을 가장 괴롭히는 건, 매일 밤 지나치게 활기찬 소리를 내는 윗집 부부 김 선생과 수경이다. 정아는 이사 공사 소음을 참아준 윗집 부부를 위해 예의상 저녁 식사 자리를 마련하고 그날 저녁, 식탁에 마주 앉은 윗집 부부는 정아와 현수에게 전혀 예상하지 못한 제안을 하게 되는데…',NULL),(4,'정보원','2025-12-03','29,967명','https://image.tmdb.org/t/p/w500/vY1eAlMBfng26chmN5PvHV6Wn8z.jpg',0.0,4,0,'2025-12-04 12:55:51','공들인 작전 실패로 강등당한 후 열정도, 의지도, 수사 감각도 모두 잃은 형사 오남혁. 이제 그가 바라는 것은 오로지 한탕과 은퇴뿐. 밀수 조직에 심어둔 정보원 조태봉을 이용해 인생 역전을 꿈꾸지만 의리도, 믿음도 없는 조태봉은 숨겨뒀던 돈을 챙겨 빠르게 손절을 하고, 뒤늦게 밀수 조직 사무실에 도착한 오남혁은 낯선 무리에게 납치를 당한다. 이 일로 얼떨결에 목숨이 걸린 범죄 사건에 휘말리게 된 오남혁과 조태봉은 각자의 목적을 위해 동상이몽 공조 수사를 시작하는데…',NULL),(5,'프레디의 피자가게 2','2025-12-03','13,238명','https://image.tmdb.org/t/p/w500/kEmPnUUXaF9hPgDMlc0eJht5JYO.jpg',5.8,5,0,'2025-12-04 12:55:51','소문과 괴담에 휘말려 폐업한 ‘프레디의 피자가게’ 본점이 수십년 만에 다시 열리고, 그곳에 오랫동안 잠들어 있던 신형 프레디와 친구들이 눈을 뜨게 된다. 안면 인식 시스템을 가진 한층 더 기괴하고 오싹해진 신형 애니메트로닉스들은 이제 피자가게 밖으로 나와 세상을 공포에 몰아넣기 시작하는데…',NULL),(6,'위키드: 포 굿','2025-11-19','813,446명','https://image.tmdb.org/t/p/w500/2QQHvIysfrRhOE5fpaKNlxIwUW4.jpg',6.8,6,0,'2025-12-04 12:55:51','전혀 다르지만 서로에게 가장 소중한 친구가 된 ‘엘파바’와 ‘글린다’. 쉬즈에서의 마법같았던 둘의 우정은 오즈의 마법사와 그를 둘러싼 비밀들을 알게 되면서 다른 길을 선택할 수밖에 없게 내몰린다. 사람들의 시선을 더 이상 두려워하지 않게 된 사악한 마녀 ‘엘파바’와 사람들의 사랑을 받으면서도 모든 걸 잃을까 두려운 착한 마녀 ‘글린다’. 서로 대척점에 서게 된 두 사람은 거대한 여정의 끝에서 운명을 영원히 바꿀 선택을 마주하게 된다.',NULL),(7,'나우 유 씨 미 3','2025-11-12','1,290,364명','https://image.tmdb.org/t/p/w500/dECA069mRikkghzgSBsM0cvic4F.jpg',6.3,7,0,'2025-12-04 12:55:51','한때 더러운 방식으로 돈을 모으는 재벌들을 시원하게 혼내주던 마술사기단 ‘포 호스맨’. 은퇴 후 평범한 삶을 살고 있던 그들에게 새로운 임무를 알리는 의미심장한 카드가 배달된다. 그렇게 다시 모이게 된 오리지널 ‘포 호스맨’은 자신들을 흉내 내던 신예 마술사들까지 영입하며 미션을 준비한다. 그들의 목표는 무기 밀매, 자금 세탁 등 더러운 돈에 물든 ‘하트 다이아몬드’를 훔치는 것. 하지만 다이아몬드를 훔치고, 통쾌한 쇼를 선보이려는 이들 앞에는 수많은 함정이 펼쳐지는데…',NULL),(8,'극장판 체인소 맨: 레제편','2025-09-24','3,366,550명','https://image.tmdb.org/t/p/w500/yb87INOllFB52NS9CchWyljTaIx.jpg',7.9,8,0,'2025-12-04 12:55:51','데블 헌터로 일하는 소년 ‘덴지’는 조직의 배신으로 죽음에 내몰린 순간 전기톱 악마견 ‘포치타’와의 계약으로 하나로 합쳐져 누구도 막을 수 없는 존재 ‘체인소 맨’으로 다시 태어난다. 악마와 사냥꾼, 그리고 정체불명의 적들이 얽힌 잔혹한 전쟁 속에서 ‘레제’라는 이름의 미스터리한 소녀가 ‘덴지’ 앞에 나타나는데… ‘덴지’는 사랑이라는 감정에 이끌려 지금껏 가장 위험한 배틀에 몸을 던진다!',NULL),(9,'콘크리트 마켓','2025-12-03','5,505명','https://image.tmdb.org/t/p/w500/zptqwi1iObqjq9vbiozbu9iMUQp.jpg',0.0,10,0,'2025-12-04 12:55:51','대지진 이후 유일하게 남은 아파트. 그곳에서 현금 대신 통조림이 화폐가 되고, 식량과 연료, 약품 등 무엇이든 사고파는 황궁마켓이 열린다. 통조림을 훔치기 위해 황궁마켓에 숨어든 희로는 우연히 마켓 상인 회장인 박상용에 대한 비밀을 알게 되고, 상용의 왼팔인 태진에게 마켓의 새로운 주인이 될 수 있는 방법을 제안한다. 그러나 서로 다른 목적을 품은 두 사람의 거래가 시작되는 순간, 견고하던 황궁마켓의 질서가 흔들리기 시작하는데…',NULL),(10,'아바타: 불과 재','2025-12-17','','https://image.tmdb.org/t/p/w500/4M6dPb0UP3qwSnGn4OF5QKSYB56.jpg',0.0,0,1,'2025-12-04 12:55:52','인간들과의 전쟁으로 첫째 아들 ‘네테이얌’을 잃은 후, ‘제이크’와 ‘네이티리’는 깊은 슬픔에 빠진다. 상실에 빠진 이들 앞에 \'바랑\'이 이끄는 재의 부족이 등장하면서, 판도라는 더욱 큰 위험에 빠지게 되고, ‘설리’ 가족은 선택의 기로에 서게 되는데…',NULL),(11,'더 러닝 맨','2025-12-10','','https://image.tmdb.org/t/p/w500/klfSEbFOquMFjBQJ5uKAfp0rrsK.jpg',6.8,0,1,'2025-12-04 12:55:52','실직한 가장 ‘벤 리처즈’가 거액의 상금을 위해 30일간 잔인한 추격자들로부터 살아남아야 하는 글로벌 서바이벌 프로그램에 참가하며 펼쳐지는 추격 액션 블록버스터',NULL),(12,'척의 일생','2025-12-24','','https://image.tmdb.org/t/p/w500/vWYRZBqgkZVYN016v1lUOTUGBy0.jpg',7.3,0,1,'2025-12-04 12:55:52','인터넷은 끊기고, 도로 곳곳은 구멍이 뚫려 마비된 세상. 마치 지구의 마지막 날이 다가오는 것만 같은 나날들의 연속이다. 교사 \'마티\'는 온 세상이 언제 어둠에 갇혀도 이상할리 없는 지금, 이혼했지만 사랑이 남은 ‘펠리샤’를 만나기 위해 길을 나선다. 그런데 이 절박한 시간에도 거리에서, TV에서, 라디오에서 끊임없이 나오는 누군가를 위한 광고. \"39년 동안의 근사했던 시간, 고마웠어요 척!\" 하지만 주변의 그 누구도 알거나 본 적이 없다는 이 \'척\'이라는 남자는 마티에게 커다란 궁금증을 남긴다. 그는 누구일까? 세상은 정말 사라져만 가는 것일까?',NULL),(13,'누벨바그','2025-12-31','','https://image.tmdb.org/t/p/w500/8oWmrXajfr2AtSLlWb91S98vjjt.jpg',7.5,0,1,'2025-12-04 12:55:52','1959년 파리, 젊은 비평가 ‘고다르’가 올해 최악의 영화이자 세기의 데뷔작이 될 <네 멋대로 해라>를 찍는 미친 모험의 시간으로 점프하는 리처드 링클레이터의 시네마 매직',NULL),(14,'바늘을 든 소녀','2025-12-10','','https://image.tmdb.org/t/p/w500/oRdtRvztw4KGprO9LZN751GngTN.jpg',7.6,0,1,'2025-12-04 12:55:52','1919년 코펜하겐. 원치 않는 아이를 낳은 ‘카롤리네’는 버려진 아이들을 돌보는 ‘다그마르’의 집을 찾는다. 따뜻한 보금자리처럼 보이던 그곳엔, 누구도 말하지 않은 이야기가 숨겨져 있었다.',NULL),(15,'반지의 제왕 : 두 개의 탑','2002-12-19','42,495명','https://image.tmdb.org/t/p/w500/zxZdTi3fA7aDxEOivmzZAY2bmTu.jpg',8.4,9,0,'2025-12-04 12:55:51','9명의 반지원정대는 사우론의 세력에 맞서 반지를 지켜냈지만 반지 원정대는 뿔뿔이 흩어지게 된다. 메리와 피핀을 구하기 위해 우르크하이 군대를 추격하던 아라곤과 레골라스, 김리는 유령 숲에서 백색의 마법사로 부활한 마법사 간달프를 만나게 되고 사우론이 암흑세계의 두 개의 탑을 통합하여 점점 그 세력을 넓혀가고 있다는 사실을 듣게 된다. 이에 아라곤과 원정대는 중간계의 선한 무리의 통합을 이뤄 사우론의 세력을 견제해야 하는 큰 임무를 맡게 된다. 하지만 원수지간인 곤도르와 로한으로 나뉜 인간 종족의 통합은 쉽지 않고 게다가 로한의 왕마저 사루만에게 동화되는데...',NULL);
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
INSERT INTO `reviews` VALUES (1,'test1',1,5,'재밌다','2025-12-04 12:57:19');
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

-- Dump completed on 2025-12-04 13:05:45
