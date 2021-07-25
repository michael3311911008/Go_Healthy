-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2021 at 08:26 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gohealth`
--

-- --------------------------------------------------------

--
-- Table structure for table `exercise`
--

CREATE TABLE `exercise` (
  `id_exercise` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `video_link` varchar(40) NOT NULL,
  `description` varchar(150) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `difficulty` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exercise`
--

INSERT INTO `exercise` (`id_exercise`, `title`, `video_link`, `description`, `type`, `difficulty`) VALUES
(1, '20 minute workout full body ', 'https://youtu.be/oAPCPjnU1wA', 'At home workouts now a days are literally a lifesaver at times, especially when you do not have a gym membership or you simply cannot make it to the g', 0, 'hard'),
(2, '10 minut fullbody workout', 'https://youtu.be/-Lt25-l9qss', 'Hello friends,this workout is commented static & dynamic full body workout for beginners and there are 20 exercises each takes 30 seconds! You can per', 0, 'easy'),
(3, '12  minute AB workout', 'https://youtu.be/Goo0g_zmFBY', 'I know I\'m popular for my super duper intense Sixpack Workouts .. and I also have Beginner ones. But what about something  Werbung If you', 0, 'medium'),
(4, 'fullbody  workout', 'https://youtu.be/8IwNI8r-jo0', 'If you want to workout and don\'t know where to start, try my plus size positive, fat friendly, full body workout.  It\'s a great beginner workout for o', 0, 'easy'),
(5, 'replace treadmill - cardio wor', 'https://youtu.be/edIK5SZYMZo', 'Join Chris Heria as he shows you how to Replace Treadmill With this 10 Min HIIT/CARDIO Workout that is going to build muscle and burn fat. Follow alon', 0, 'easy'),
(6, 'full body build muscle workout', 'https://youtu.be/xRRS5eJLET4', 'workout with rown ', 0, 'medium');

-- --------------------------------------------------------

--
-- Table structure for table `historybmi`
--

CREATE TABLE `historybmi` (
  `id` int(11) NOT NULL,
  `bmi` double NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `historybmi`
--

INSERT INTO `historybmi` (`id`, `bmi`, `date`) VALUES
(2, 20.761245674740486, '2021-05-22'),
(2, 20.761245674740486, '2021-05-22'),
(7, 17.301038062283737, '2021-05-29'),
(7, 24.221453287197235, '2021-05-29'),
(8, 24.691358024691358, '2021-05-29'),
(9, 24.691358024691358, '2021-05-29'),
(9, 24.691358024691358, '2021-05-29'),
(10, 24.691358024691358, '2021-05-29'),
(10, 24.221453287197235, '2021-05-29'),
(10, 17.301038062283737, '2021-05-30'),
(10, 24.221453287197235, '2021-05-30'),
(10, 24.816326530612244, '2021-05-30'),
(10, 27.68166089965398, '2021-05-30'),
(10, 27.68166089965398, '2021-05-30'),
(10, 27.68166089965398, '2021-05-30'),
(10, 25.24933720489837, '2021-05-30'),
(10, 30.864197530864196, '2021-05-30'),
(10, 30.864197530864196, '2021-05-30'),
(10, 24.691358024691358, '2021-05-30'),
(10, 166.66666666666669, '2021-05-30');

-- --------------------------------------------------------

--
-- Table structure for table `useraccount`
--

CREATE TABLE `useraccount` (
  `id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(80) NOT NULL,
  `name` varchar(30) NOT NULL,
  `gender` enum('Male','female','','') NOT NULL,
  `DOB` date NOT NULL,
  `height` double NOT NULL,
  `weight` double NOT NULL,
  `profilepict` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `useraccount`
--

INSERT INTO `useraccount` (`id`, `email`, `password`, `name`, `gender`, `DOB`, `height`, `weight`, `profilepict`) VALUES
(1, 'shuak@mail..com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'shuak', 'Male', '0000-00-00', 170, 60, '87f.jpg'),
(7, 'sheri@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'sheri', 'Male', '0000-00-00', 170, 70, 'image_picker1095241012.jpg'),
(8, 'shiu@mail.com', '20eabe5d64b0e216796e834f52d61fd0b70332fc', 'shiu', 'Male', '0000-00-00', 180, 80, 'image_picker1842711833.png'),
(9, 'shou@mail.com', '8cb2237d0679ca88db6464eac60da96345513964', 'shou', 'Male', '0000-00-00', 180, 80, 'image_picker1279867996.png'),
(10, 'shiu@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'dara', 'Male', '0000-00-00', 60, 60, 'image_picker1024929676.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exercise`
--
ALTER TABLE `exercise`
  ADD PRIMARY KEY (`id_exercise`);

--
-- Indexes for table `historybmi`
--
ALTER TABLE `historybmi`
  ADD KEY `id` (`id`);

--
-- Indexes for table `useraccount`
--
ALTER TABLE `useraccount`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exercise`
--
ALTER TABLE `exercise`
  MODIFY `id_exercise` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
