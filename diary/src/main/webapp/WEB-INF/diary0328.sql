-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.33-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- diary 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `diary`;
CREATE DATABASE IF NOT EXISTS `diary` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `diary`;

-- 테이블 diary.diary 구조 내보내기
CREATE TABLE IF NOT EXISTS `diary` (
  `diary_date` date NOT NULL,
  `feeling` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` text NOT NULL,
  `weather` enum('맑음','흐림','비','눈') NOT NULL,
  `content` text NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`diary_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.diary:~5 rows (대략적) 내보내기
DELETE FROM `diary`;
INSERT INTO `diary` (`diary_date`, `feeling`, `title`, `weather`, `content`, `update_date`, `create_date`) VALUES
	('2024-03-23', '&#128512;', '토요일 나들이', '맑음', '토요일은 날씨가 너무 좋았고 오랜만에 운전하니 스트레스가 풀렸다 취미가 운전이 될거 같아ㅋㅋㅋ', '2024-03-25 09:49:15', '2024-03-25 09:49:15'),
	('2024-03-25', '&#128512;', '3월25일', '비', '오늘 비온다', '2024-03-26 17:23:06', '2024-03-25 09:44:05'),
	('2024-03-26', '&#128512;', '다이어리 프로젝트', '맑음', '오늘은 구디아카데미에서 다이어리 프로젝트 진행중 \r\n', '2024-03-26 17:48:18', '2024-03-25 16:19:41'),
	('2024-03-27', '&#128512;', '노트북', '맑음', '오늘은 아침부터 날씨도 좋고 노트북도 가져왔다 \r\n진지한 일상을 나름 보내고 있지만 쉽지는 않은 것 같다\r\n내가 살아온 경험해온 사회생활과는 다른 일상을 보내고 있는 요즘...', '2024-03-27 08:54:50', '2024-03-27 08:54:34'),
	('2024-03-28', '😷', '기분', '맑음', '기분', '2024-03-27 17:03:22', '2024-03-27 17:03:22');

-- 테이블 diary.login 구조 내보내기
CREATE TABLE IF NOT EXISTS `login` (
  `my_session` enum('ON','OFF') NOT NULL,
  `on_date` datetime DEFAULT NULL,
  `off_date` datetime DEFAULT NULL,
  PRIMARY KEY (`my_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.login:~1 rows (대략적) 내보내기
DELETE FROM `login`;
INSERT INTO `login` (`my_session`, `on_date`, `off_date`) VALUES
	('ON', '2024-03-25 17:06:58', '2024-03-25 17:03:22');

-- 테이블 diary.lunch 구조 내보내기
CREATE TABLE IF NOT EXISTS `lunch` (
  `lunch_date` date NOT NULL,
  `menu` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`lunch_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.lunch:~0 rows (대략적) 내보내기
DELETE FROM `lunch`;

-- 테이블 diary.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_id` varchar(50) NOT NULL,
  `member_pw` varchar(50) NOT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.member:~1 rows (대략적) 내보내기
DELETE FROM `member`;
INSERT INTO `member` (`member_id`, `member_pw`) VALUES
	('admin', '1234');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
