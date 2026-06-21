CREATE DATABASE IF NOT EXISTS edu_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE edu_platform;

CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    name_ru VARCHAR(100) NOT NULL DEFAULT '',
    name_kk VARCHAR(100) NOT NULL DEFAULT '',
    description TEXT,
    description_ru TEXT,
    description_kk TEXT,
    icon VARCHAR(50) DEFAULT 'bi-book'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS themes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    name_ru VARCHAR(200) NOT NULL DEFAULT '',
    name_kk VARCHAR(200) NOT NULL DEFAULT '',
    description TEXT,
    description_ru TEXT,
    description_kk TEXT,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS topics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    theme_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    title_ru VARCHAR(200) NOT NULL DEFAULT '',
    title_kk VARCHAR(200) NOT NULL DEFAULT '',
    summary TEXT NOT NULL,
    summary_ru TEXT,
    summary_kk TEXT,
    examples TEXT,
    examples_ru TEXT,
    examples_kk TEXT,
    youtube_url VARCHAR(500) NOT NULL,
    FOREIGN KEY (theme_id) REFERENCES themes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
