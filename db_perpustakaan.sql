-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 25 Apr 2026 pada 08.03
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpustakaan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `nohp` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id_admin`, `username`, `password`, `nama_lengkap`, `email`, `nohp`, `created_at`, `updated_at`, `is_active`) VALUES
(1, 'admin', '$2y$10$vyPJ.cg76akRIsKNPRCsruGLd3QT6/2Z2DAJfqxMIpwoCrgGh0hgO', 'Administrator', 'admin@perpustakaan.com', '081234567890', '2026-02-11 18:46:08', '2026-04-11 07:05:27', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota`
--

CREATE TABLE `anggota` (
  `id_anggota` int(11) NOT NULL,
  `nis_nisn` varchar(30) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `kelas_jurusan` varchar(50) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT 'L',
  `alamat` text DEFAULT NULL,
  `nohp` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tanggal_daftar` date DEFAULT curdate(),
  `status_aktif` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggota`
--

INSERT INTO `anggota` (`id_anggota`, `nis_nisn`, `nama`, `kelas_jurusan`, `jenis_kelamin`, `alamat`, `nohp`, `email`, `username`, `password`, `tanggal_daftar`, `status_aktif`, `created_at`, `updated_at`) VALUES
(2, '19982773', 'Rauf Skuy', 'XII PPLG 2', 'L', 'cibodas', '088999766689', 'muhraufaziz@gmail.com', 'ryuuu_o12', '$2y$10$9gqCXkc2ax00mKb5e8ztguSmna/MX8PF84T0RFlJ7cDv7mvsoC0a.', '2026-02-11', 1, '2026-02-11 14:47:25', '2026-04-11 06:48:56'),
(3, '278319277', 'Dimas Fadilah', 'XII RPL 1', 'L', 'Cimahi', '087789897000', 'dimas@gmail.com', 'dimas', '$2y$10$1N5yRaLBT/JzFQw2O3zFPOw6jv6EIgvK75DBzGCMqBmeLPaxTSSou', '2026-04-03', 1, '2026-04-03 10:39:12', '2026-04-11 10:06:09'),
(4, '232412345', 'muhktarsipsab', 'XII PPLG 4', 'L', 'kolong jembatan', '0888237483', 'muhktersz@gmail.com', 'utaysipsap12', '$2y$10$VW1Jf77lfD5nSk1Mtwvs4uJyIo8N1nJkgV/hYyoFVQjd2nIa1qCqu', '2026-04-06', 1, '2026-04-06 16:04:16', '2026-04-06 16:04:16'),
(5, '22222222', 'Bayu', 'XII PPLG 2', 'L', 'batujajar', '081234567', 'bayu@gmail.com', 'bayu', '$2y$10$vUceG99xCXfftyh1u2t4quEKVZEgm7BJfsonMb4fVjuPfTlqok90u', '2026-04-25', 1, '2026-04-25 09:19:42', '2026-04-25 09:19:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `judul` varchar(255) NOT NULL,
  `pengarang` varchar(150) NOT NULL,
  `penerbit` varchar(100) DEFAULT NULL,
  `tahun_terbit` year(4) DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  `stok_tersedia` int(11) NOT NULL DEFAULT 0,
  `stok_total` int(11) NOT NULL DEFAULT 0,
  `lokasi_rak` varchar(50) DEFAULT NULL,
  `cover_path` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `isbn`, `judul`, `pengarang`, `penerbit`, `tahun_terbit`, `id_kategori`, `stok_tersedia`, `stok_total`, `lokasi_rak`, `cover_path`, `deskripsi`, `created_at`, `updated_at`) VALUES
(4, '9780439708180', 'Harry Potter and the Sorcerer`s Stone', 'J.K. Rowling', 'Gramedia Pustaka Utama', '2000', 1, 4, 5, 'Rak-002', '698c7ff08e44f.jpg', 'singkat saja', '2026-02-11 19:12:37', '2026-04-25 09:35:19'),
(5, '9786020332957', 'Matahari', 'Tere Liye', 'Gramedia Pustaka Utama', '2021', 8, 5, 5, 'Rak-002', '698d7ecc80b83.jpg', 'Novel dengan tebal 440 halaman ini, berkisah mengenai petualangan antarklan dengan tokoh utamanya, yaitu Raib. Raib adalah generasi keturunan murni dari Klan Bulan dan ia melakukan petualangan ke dunia paralel bersama dua sahabatnya, yaitu Seli dan Ali. Seli berasal dari keturunan klan Matahari, sementara Ali berasal dari klan Bumi atau tanah. Sebenarnya, mereka bertiga merupakan anak remaja pada umumnya, tetapi di novel inilah awal dari segalanya terungkap. Namaku Raib, usiaku 15 tahun, kelas sepuluh. Aku anak perempuan seperti kalian, adik-adik kalian, tetangga kalian. Aku punya dua kucing, namanya si Putih dan si Hitam. Mama dan papaku menyenangkan. Guru-guru di sekolahku seru. Teman-temanku baik dan kompak. Aku sama seperti remaja kebanyakan, kecuali satu hal. Sesuatu yang kusimpan sendiri sejak kecil. Sesuatu yang menakjubkan. Namaku Raib. Dan aku bisa menghilang. Buku pertama dari serial “BUMI”', '2026-02-12 14:18:36', '2026-04-11 08:56:50'),
(6, '9786020332956', 'Bumi', 'Tere Liye', 'Gramedia Pustaka Utama', '2016', 8, 3, 5, 'Rak-002', '69cefe5904344.jpeg', 'Namaku Raib, usiaku 15 tahun, kelas sepuluh. Aku anak perempuan seperti kalian, adik-adik kalian, tetangga kalian. Aku punya dua kucing, namanya si Putih dan si Hitam. Mama dan papaku menyenangkan. Guru-guru di sekolahku seru. Teman-temanku baik dan kompak. Aku sama seperti remaja kebanyakan, kecuali satu hal. Sesuatu yang kusimpan sendiri sejak kecil. Sesuatu yang menakjubkan. Namaku Raib. Dan aku bisa menghilang.', '2026-04-03 06:40:09', '2026-04-25 09:22:08'),
(7, '9786024246945', 'Laut Bercerita', 'Leila S. Chudori', 'Kepustakaan Populer Gramedia', '2017', 1, 2, 2, 'Rak-002', '69cf01a08900f.jpg', 'Laut Bercerita adalah novel karya Leila S. Chudori yang diterbitkan oleh Kepustakaan Populer Gramedia (KPG) Jakarta pada tahun 2017. Novel ini berkisah tentang persahabatan, cinta, keluarga, dan kehilangan para tokoh-tokohnya. Mengambil latar sosial kehidupan mahasiswa pada tahun 90-an dan 2000 membuat novel ini bisa membawa pembaca untuk melihat kembali peristiwa-peristiwa di masa lalu.', '2026-04-03 06:54:08', '2026-04-24 11:58:18'),
(8, '979-3062-79-7', 'Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', '2005', 8, 3, 3, 'Rak-001', '69cf3a627bd57.jpg', 'Sejak duduk di bangku kelas satu Sekolah Dasar (SD) hingga kelas tiga Sekolah Menengah Pertama (SMP), mereka belajar dalam kelas yang sama dan menyebut diri mereka sebagai Laskar Pelangi. Dalam perjalanan mereka, hadir seorang anak perempuan bernama Flo yang menjadi anggota baru Laskar Pelangi. Flo adalah murid pindahan yang membawa dinamika baru dalam kelompok mereka', '2026-04-03 10:56:18', '2026-04-11 09:57:14'),
(9, '0-7475-4624-X', 'Harry Potter and the Goblet of Fire', 'J.K. Rowling', 'Gramedia Pustaka Utama', '2017', 1, 2, 3, 'Rak-002', '69cf3b75027f4.jpg', 'Novel fantasi yang ditulis oleh penulis Inggris J. K. Rowling dan merupakan novel keempat dalam seri Harry Potter. Novel ini mengisahkan Harry Potter, seorang penyihir pada tahun keempatnya di Sekolah Sihir Hogwarts, dan misteri seputar didaftarkannya nama Harry dalam Turnamen Triwizard, yang mengharuskannya untuk bertanding.', '2026-04-03 11:00:33', '2026-04-18 10:26:06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kas_denda`
--

CREATE TABLE `kas_denda` (
  `id_kas` int(11) NOT NULL,
  `id_transaksi` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `jumlah_denda` decimal(10,2) NOT NULL,
  `tanggal_bayar` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_admin` int(11) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kas_denda`
--

INSERT INTO `kas_denda` (`id_kas`, `id_transaksi`, `id_anggota`, `jumlah_denda`, `tanggal_bayar`, `id_admin`, `keterangan`) VALUES
(1, 5, 2, 29000.00, '2026-04-03 01:08:04', 1, 'Pembayaran denda lunas'),
(2, 12, 4, 50000.00, '2026-04-06 09:07:47', 1, 'Pembayaran denda lunas'),
(3, 7, 2, 2000.00, '2026-04-11 01:57:07', 1, 'Pembayaran denda lunas'),
(4, 14, 2, 3000.00, '2026-04-24 05:04:49', 1, 'Pembayaran denda lunas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `deskripsi`, `created_at`) VALUES
(1, 'Fiksi', NULL, '2026-02-11 18:46:08'),
(2, 'Non-Fiksi', NULL, '2026-02-11 18:46:08'),
(3, 'Sains', NULL, '2026-02-11 18:46:08'),
(4, 'Teknologi', NULL, '2026-02-11 18:46:08'),
(5, 'Sejarah', NULL, '2026-02-11 18:46:08'),
(6, 'Biografi', NULL, '2026-02-11 18:46:08'),
(7, 'Komik', NULL, '2026-02-11 18:46:08'),
(8, 'Novel', NULL, '2026-02-11 18:46:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id_log` bigint(20) NOT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `id_anggota` int(11) DEFAULT NULL,
  `aktivitas` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_aktivitas`
--

INSERT INTO `log_aktivitas` (`id_log`, `id_admin`, `id_anggota`, `aktivitas`, `deskripsi`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, NULL, 2, 'register', 'Registrasi anggota baru: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 14:47:25'),
(2, 1111114, NULL, 'hapus_anggota', 'Menghapus anggota: rauf', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 14:55:04'),
(3, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 15:01:29'),
(4, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 18:46:57'),
(5, 1, NULL, 'tambah_buku', 'Menambah buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 18:55:39'),
(6, 1, NULL, 'hapus_buku', 'Menghapus buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:01:20'),
(7, 1, NULL, 'tambah_buku', 'Menambah buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:02:38'),
(8, 1, NULL, 'hapus_buku', 'Menghapus buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:05:56'),
(9, 1, NULL, 'tambah_buku', 'Menambah buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:10:14'),
(10, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:11:02'),
(11, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:11:41'),
(12, 1, NULL, 'hapus_buku', 'Menghapus buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:11:59'),
(13, 1, NULL, 'tambah_buku', 'Menambah buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:12:37'),
(14, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:13:04'),
(15, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:15:17'),
(16, 1, NULL, 'peminjaman', 'Peminjaman buku oleh anggota ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:15:33'),
(17, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:19:01'),
(18, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 19:30:58'),
(19, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:09:27'),
(20, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:10:09'),
(21, 1, NULL, 'pengembalian', 'Pengembalian buku ID transaksi: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:10:59'),
(22, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:11:12'),
(23, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:11:28'),
(24, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:11:45'),
(25, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:12:04'),
(26, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:13:16'),
(27, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:16:33'),
(28, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:17:41'),
(29, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:18:46'),
(30, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:18:57'),
(31, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:19:06'),
(32, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:19:24'),
(33, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:21:58'),
(34, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:22:07'),
(35, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:23:10'),
(36, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:23:19'),
(37, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:24:38'),
(38, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:24:45'),
(39, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:25:17'),
(40, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 20:25:25'),
(41, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-11 21:15:19'),
(42, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:05:22'),
(43, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:07:17'),
(44, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:12:02'),
(45, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:12:15'),
(46, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:14:08'),
(47, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:14:34'),
(48, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:14:55'),
(49, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:15:04'),
(50, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 08:16:10'),
(51, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 09:54:54'),
(52, 1, NULL, 'tambah_buku', 'Menambah buku: Bumi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:18:36'),
(53, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:18:52'),
(54, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:19:11'),
(55, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:19:52'),
(56, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:20:26'),
(57, 1, NULL, 'edit_buku', 'Mengedit buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:21:11'),
(58, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:22:00'),
(59, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:22:23'),
(60, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:23:21'),
(61, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:23:33'),
(62, 1, NULL, 'peminjaman', 'Peminjaman buku oleh anggota ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:24:02'),
(63, 1, NULL, 'peminjaman', 'Peminjaman buku oleh anggota ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:25:05'),
(64, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:28:23'),
(65, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-12 14:28:42'),
(66, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:31:34'),
(67, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:31:44'),
(68, 1, NULL, 'pengembalian', 'Pengembalian buku ID transaksi: 3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:31:59'),
(69, 1, NULL, 'pengembalian', 'Pengembalian buku ID transaksi: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:32:02'),
(70, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:32:41'),
(71, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:36:19'),
(72, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:54:45'),
(73, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 08:55:01'),
(74, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:02:58'),
(75, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:03:09'),
(76, NULL, 2, 'request_peminjaman', 'Request peminjaman buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:05:13'),
(77, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:05:39'),
(78, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:05:57'),
(79, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Rauf Skuy', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:06:32'),
(80, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:11:19'),
(81, NULL, 2, 'request_pengembalian', 'Request pengembalian buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:13:11'),
(82, 1, NULL, 'approve_pengembalian', 'Approve pengembalian: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 09:13:49'),
(83, NULL, 2, 'request_peminjaman', 'Request peminjaman buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 13:39:46'),
(84, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Rauf Skuy', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-20 13:40:39'),
(85, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-28 21:26:31'),
(86, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-28 21:36:24'),
(87, 1, NULL, 'pengembalian', 'Pengembalian buku ID transaksi: 5', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-28 21:37:19'),
(88, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-28 21:48:40'),
(89, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:28:50'),
(90, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:30:44'),
(91, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:31:08'),
(92, NULL, 2, 'request_peminjaman', 'Request peminjaman buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:31:55'),
(93, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:32:32'),
(94, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:32:41'),
(95, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Rauf Skuy', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:32:52'),
(96, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:35:50'),
(97, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:36:24'),
(98, NULL, 2, 'request_peminjaman', 'Request peminjaman buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:36:42'),
(99, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 09:03:54'),
(100, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-01 11:37:58'),
(101, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 08:20:04'),
(102, NULL, 2, 'request_pengembalian', 'Request pengembalian buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 08:20:21'),
(103, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 08:20:25'),
(104, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 08:20:35'),
(105, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Rauf Skuy', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 08:20:48'),
(106, 1, NULL, 'approve_pengembalian', 'Approve pengembalian: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 08:20:53'),
(107, 1, NULL, 'tambah_buku', 'Menambah buku: Bumi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 06:40:09'),
(108, 1, NULL, 'edit_buku', 'Mengedit buku: Bumi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 06:40:28'),
(109, 1, NULL, 'tambah_buku', 'Menambah buku: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 06:54:08'),
(110, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 06:54:42'),
(111, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 07:18:12'),
(112, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 07:18:22'),
(113, NULL, 2, 'bayar_denda', 'Bayar denda Rp 1,000 via cash', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 07:27:02'),
(114, 1, NULL, 'lunas_denda', 'Markkan transaksi ID 2 sebagai lunas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 07:49:14'),
(115, 1, NULL, 'lunas_denda', 'Markkan transaksi ID 3 sebagai lunas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 07:52:12'),
(116, 1, NULL, 'lunas_denda', 'Markkan transaksi ID 5 sebagai lunas, Rp 29,000', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:08:04'),
(117, 1, NULL, 'edit_buku', 'Mengedit buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:11:32'),
(118, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:11:44'),
(119, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:11:54'),
(120, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:12:01'),
(121, 1, NULL, 'edit_buku', 'Mengedit buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:12:17'),
(122, 1, NULL, 'edit_buku', 'Mengedit buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:12:29'),
(123, 1, NULL, 'edit_buku', 'Mengedit buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:13:09'),
(124, 1, NULL, 'edit_buku', 'Mengedit buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 08:13:15'),
(125, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 09:30:18'),
(126, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:25:52'),
(127, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:35:48'),
(128, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:36:22'),
(129, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:37:50'),
(130, NULL, 3, 'register', 'Registrasi anggota baru: dimas', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:39:12'),
(131, NULL, 3, 'login', 'Siswa login: dimas', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:39:53'),
(132, NULL, 3, 'login', 'Siswa login: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 10:40:50'),
(133, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:42:09'),
(134, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:45:48'),
(135, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.113.0 Chrome/142.0.7444.265 Electron/39.8.3 Safari/537.36', '2026-04-03 10:46:02'),
(136, 1, NULL, 'tambah_buku', 'Menambah buku: Laskar Pelangi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 10:56:18'),
(137, 1, NULL, 'tambah_buku', 'Menambah buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 11:00:33'),
(138, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 11:00:53'),
(139, NULL, 3, 'logout', 'Siswa logout: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 11:21:03'),
(140, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 12:51:45'),
(141, NULL, 2, 'request_peminjaman', 'Request peminjaman buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 12:52:13'),
(142, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Rauf Skuy', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-03 12:52:30'),
(143, NULL, 3, 'login', 'Siswa login: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:09:09'),
(144, NULL, 3, 'logout', 'Siswa logout: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:10:38'),
(145, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:10:50'),
(146, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:14:24'),
(147, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:18:03'),
(148, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:18:17'),
(149, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:18:35'),
(150, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 20:18:43'),
(151, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '2026-04-04 21:54:46'),
(152, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-04 22:11:08'),
(153, NULL, 3, 'login', 'Siswa login: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:22:37'),
(154, NULL, 3, 'request_peminjaman', 'Request peminjaman buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:23:36'),
(155, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Dimas Fadilah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:23:54'),
(156, NULL, 3, 'request_pengembalian', 'Request pengembalian buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:24:09'),
(157, 1, NULL, 'approve_pengembalian', 'Approve pengembalian: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:24:21'),
(158, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:59:09'),
(159, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 15:59:50'),
(160, 1, NULL, 'peminjaman', 'Peminjaman buku oleh anggota ID: 3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:00:13'),
(161, 1, NULL, 'peminjaman', 'Peminjaman buku oleh anggota ID: 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:01:17'),
(162, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:03:02'),
(163, NULL, 4, 'register', 'Registrasi anggota baru: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:04:16'),
(164, NULL, 4, 'login', 'Siswa login: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:04:26'),
(165, NULL, 4, 'request_peminjaman', 'Request peminjaman buku: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:04:50'),
(166, NULL, 4, 'logout', 'Siswa logout: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:05:25'),
(167, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:05:37'),
(168, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: muhktarsipsab', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:05:45'),
(169, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:05:48'),
(170, NULL, 4, 'login', 'Siswa login: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:05:57'),
(171, NULL, 4, 'request_pengembalian', 'Request pengembalian buku: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:06:10'),
(172, NULL, 4, 'logout', 'Siswa logout: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:06:25'),
(173, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:06:36'),
(174, 1, NULL, 'approve_pengembalian', 'Approve pengembalian: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:06:49'),
(175, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:07:13'),
(176, NULL, 4, 'login', 'Siswa login: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:07:23'),
(177, NULL, 4, 'logout', 'Siswa logout: utaysipsap12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:07:33'),
(178, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:07:41'),
(179, 1, NULL, 'lunas_denda', 'Markkan transaksi ID 12 sebagai lunas, Rp 50,000', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:07:47'),
(180, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-06 16:08:05'),
(181, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 06:39:39'),
(182, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 06:48:30'),
(183, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 06:50:04'),
(184, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 06:50:08'),
(185, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 06:53:17'),
(186, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 06:55:06'),
(187, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 07:57:10'),
(188, 1, NULL, 'edit_buku', 'Mengedit buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:19:44'),
(189, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:50:22'),
(190, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:50:49'),
(191, NULL, 3, 'login', 'Siswa login: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:53:35'),
(192, NULL, 3, 'request_peminjaman', 'Request peminjaman buku: Harry Potter and the Goblet of Fire', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:54:24'),
(193, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Dimas Fadilah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:54:39'),
(194, NULL, 3, 'logout', 'Siswa logout: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:55:50'),
(195, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:56:00'),
(196, NULL, 2, 'request_pengembalian', 'Request pengembalian buku: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:56:35'),
(197, 1, NULL, 'approve_pengembalian', 'Approve pengembalian: Matahari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:56:50'),
(198, 1, NULL, 'lunas_denda', 'Markkan transaksi ID 7 sebagai lunas, Rp 2,000', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 08:57:07'),
(199, 1, NULL, 'pengembalian', 'Pengembalian buku ID transaksi: 11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 09:57:14'),
(200, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 10:04:00'),
(201, NULL, 3, 'login', 'Siswa login: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 10:05:26'),
(202, NULL, 3, 'logout', 'Siswa logout: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 10:05:30'),
(203, NULL, 3, 'login', 'Siswa login: dimas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 10:06:23'),
(204, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 10:06:39'),
(205, 1, NULL, 'pengembalian', 'Pengembalian buku ID transaksi: 8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 10:26:06'),
(206, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 11:52:22'),
(207, NULL, 2, 'request_peminjaman', 'Request peminjaman buku: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 11:53:09'),
(208, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Rauf Skuy', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 11:53:31'),
(209, 1, NULL, 'logout', 'Admin logout: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 11:54:18'),
(210, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 11:56:30'),
(211, NULL, 2, 'request_pengembalian', 'Request pengembalian buku: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 11:58:03'),
(212, 1, NULL, 'approve_pengembalian', 'Approve pengembalian: Laut Bercerita', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 11:58:18'),
(213, 1, NULL, 'lunas_denda', 'Markkan transaksi ID 14 sebagai lunas, Rp 3,000', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 12:04:49'),
(214, 1, NULL, 'login', 'Admin login: admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 08:27:50'),
(215, NULL, 2, 'login', 'Siswa login: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 08:28:48'),
(216, NULL, 2, 'logout', 'Siswa logout: ryuuu_o12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:17:48'),
(217, NULL, 5, 'register', 'Registrasi anggota baru: bayu', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:19:42'),
(218, NULL, 5, 'login', 'Siswa login: bayu', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:19:55'),
(219, NULL, 5, 'request_peminjaman', 'Request peminjaman buku: Bumi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:20:40'),
(220, NULL, 5, 'request_peminjaman', 'Request peminjaman buku: Harry Potter and the Sorcerer`s Stone', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:20:50'),
(221, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Bayu', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:22:08'),
(222, 1, NULL, 'approve_peminjaman', 'Approve request peminjaman: Bayu', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 09:35:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `request_peminjaman`
--

CREATE TABLE `request_peminjaman` (
  `id_request` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `tanggal_request` datetime DEFAULT current_timestamp(),
  `lama_pinjam` int(11) DEFAULT 7,
  `keterangan` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `id_admin` int(11) DEFAULT NULL,
  `tanggal_response` datetime DEFAULT NULL,
  `alasan_reject` text DEFAULT NULL,
  `id_transaksi` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `request_peminjaman`
--

INSERT INTO `request_peminjaman` (`id_request`, `id_anggota`, `id_buku`, `tanggal_request`, `lama_pinjam`, `keterangan`, `status`, `id_admin`, `tanggal_response`, `alasan_reject`, `id_transaksi`) VALUES
(1, 2, 4, '2026-02-20 09:05:13', 7, 'woi pinjem hehe', 'approved', 1, '2026-02-20 09:06:32', NULL, 4),
(2, 2, 5, '2026-02-20 13:39:46', 7, 'mau baca', 'approved', 1, '2026-02-20 13:40:39', NULL, 5),
(3, 2, 4, '2026-03-31 07:31:55', 7, '', 'approved', 1, '2026-03-31 07:32:52', NULL, 6),
(4, 2, 5, '2026-03-31 07:36:42', 7, '', 'approved', 1, '2026-04-02 08:20:48', NULL, 7),
(5, 2, 9, '2026-04-03 12:52:13', 7, '', 'approved', 1, '2026-04-03 12:52:30', NULL, 8),
(6, 3, 9, '2026-04-06 15:23:36', 7, 'revandahlan', 'approved', 1, '2026-04-06 15:23:54', NULL, 9),
(7, 4, 7, '2026-04-06 16:04:50', 7, 'untuk dibaca', 'approved', 1, '2026-04-06 16:05:45', NULL, 12),
(8, 3, 9, '2026-04-11 08:54:24', 7, '', 'approved', 1, '2026-04-11 08:54:39', NULL, 13),
(9, 2, 7, '2026-04-18 11:53:09', 3, '', 'approved', 1, '2026-04-18 11:53:31', NULL, 14),
(10, 5, 6, '2026-04-25 09:20:40', 7, '', 'approved', 1, '2026-04-25 09:22:08', NULL, 15),
(11, 5, 4, '2026-04-25 09:20:50', 7, '', 'approved', 1, '2026-04-25 09:35:19', NULL, 16);

-- --------------------------------------------------------

--
-- Struktur dari tabel `request_pengembalian`
--

CREATE TABLE `request_pengembalian` (
  `id_request` int(11) NOT NULL,
  `id_transaksi` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `tanggal_request` datetime DEFAULT current_timestamp(),
  `keterangan` text DEFAULT NULL,
  `kondisi_buku` enum('baik','rusak_ringan','rusak_berat','hilang') DEFAULT 'baik',
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `id_admin` int(11) DEFAULT NULL,
  `tanggal_response` datetime DEFAULT NULL,
  `alasan_reject` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `request_pengembalian`
--

INSERT INTO `request_pengembalian` (`id_request`, `id_transaksi`, `id_anggota`, `tanggal_request`, `keterangan`, `kondisi_buku`, `status`, `id_admin`, `tanggal_response`, `alasan_reject`) VALUES
(1, 4, 2, '2026-02-20 09:13:11', 'udah beres bang', 'baik', 'approved', 1, '2026-02-20 09:13:49', NULL),
(2, 6, 2, '2026-04-02 08:20:21', '', 'baik', 'approved', 1, '2026-04-02 08:20:53', NULL),
(3, 9, 3, '2026-04-06 15:24:09', '', 'baik', 'approved', 1, '2026-04-06 15:24:21', NULL),
(4, 12, 4, '2026-04-06 16:06:10', '', 'rusak_berat', 'approved', 1, '2026-04-06 16:06:49', NULL),
(5, 7, 2, '2026-04-11 08:56:35', '', 'baik', 'approved', 1, '2026-04-11 08:56:50', NULL),
(6, 14, 2, '2026-04-24 11:58:03', '', 'baik', 'approved', 1, '2026-04-24 11:58:18', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL DEFAULT curdate(),
  `batas_kembali` date NOT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` enum('dipinjam','dikembalikan','terlambat','hilang') DEFAULT 'dipinjam',
  `denda` decimal(10,2) DEFAULT 0.00,
  `keterangan` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_anggota`, `id_buku`, `id_admin`, `tanggal_pinjam`, `batas_kembali`, `tanggal_kembali`, `status`, `denda`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 1, '2026-02-11', '2026-02-18', '2026-02-11', 'dikembalikan', 0.00, NULL, '2026-02-11 19:15:33', '2026-02-11 20:10:59'),
(2, 2, 5, 1, '2026-02-12', '2026-02-19', '2026-02-20', 'dikembalikan', 0.00, NULL, '2026-02-12 14:24:02', '2026-04-03 07:49:14'),
(3, 2, 4, 1, '2026-02-12', '2026-02-13', '2026-02-20', 'dikembalikan', 0.00, NULL, '2026-02-12 14:25:05', '2026-04-03 07:52:12'),
(4, 2, 4, 1, '2026-02-20', '2026-02-27', '2026-02-20', 'dikembalikan', 0.00, NULL, '2026-02-20 09:06:32', '2026-02-20 09:13:49'),
(5, 2, 5, 1, '2026-02-20', '2026-02-27', '2026-03-28', 'dikembalikan', 0.00, NULL, '2026-02-20 13:40:39', '2026-04-03 08:08:04'),
(6, 2, 4, 1, '2026-03-31', '2026-04-07', '2026-04-02', 'dikembalikan', 0.00, NULL, '2026-03-31 07:32:52', '2026-04-02 08:20:53'),
(7, 2, 5, 1, '2026-04-02', '2026-04-09', '2026-04-11', 'dikembalikan', 0.00, NULL, '2026-04-02 08:20:48', '2026-04-11 08:57:07'),
(8, 2, 9, 1, '2026-04-03', '2026-04-10', '2026-04-18', 'dikembalikan', 8000.00, NULL, '2026-04-03 12:52:30', '2026-04-18 10:26:06'),
(9, 3, 9, 1, '2026-04-06', '2026-04-13', '2026-04-06', 'dikembalikan', 0.00, NULL, '2026-04-06 15:23:54', '2026-04-06 15:24:21'),
(10, 3, 6, 1, '2026-04-06', '2026-04-13', NULL, 'dipinjam', 0.00, NULL, '2026-04-06 16:00:13', '2026-04-06 16:00:13'),
(11, 2, 8, 1, '2026-04-06', '2026-04-13', '2026-04-11', 'dikembalikan', 0.00, NULL, '2026-04-06 16:01:17', '2026-04-11 09:57:14'),
(12, 4, 7, 1, '2026-04-06', '2026-04-13', '2026-04-06', 'dikembalikan', 0.00, 'Kondisi: rusak berat', '2026-04-06 16:05:45', '2026-04-06 16:07:47'),
(13, 3, 9, 1, '2026-04-11', '2026-04-18', NULL, 'dipinjam', 0.00, NULL, '2026-04-11 08:54:39', '2026-04-11 08:54:39'),
(14, 2, 7, 1, '2026-04-18', '2026-04-21', '2026-04-24', 'dikembalikan', 0.00, NULL, '2026-04-18 11:53:31', '2026-04-24 12:04:49'),
(15, 5, 6, 1, '2026-04-25', '2026-05-02', NULL, 'dipinjam', 0.00, NULL, '2026-04-25 09:22:08', '2026-04-25 09:22:08'),
(16, 5, 4, 1, '2026-04-25', '2026-05-02', NULL, 'dipinjam', 0.00, NULL, '2026-04-25 09:35:19', '2026-04-25 09:35:19');

--
-- Trigger `transaksi`
--
DELIMITER $$
CREATE TRIGGER `after_peminjaman` AFTER INSERT ON `transaksi` FOR EACH ROW BEGIN
    IF NEW.status = 'dipinjam' THEN
        UPDATE buku 
        SET stok_tersedia = stok_tersedia - 1
        WHERE id_buku = NEW.id_buku;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_pengembalian` AFTER UPDATE ON `transaksi` FOR EACH ROW BEGIN
    IF OLD.status = 'dipinjam' AND NEW.status = 'dikembalikan' THEN
        UPDATE buku 
        SET stok_tersedia = stok_tersedia + 1
        WHERE id_buku = NEW.id_buku;
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id_anggota`),
  ADD UNIQUE KEY `nis_nisn` (`nis_nisn`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indeks untuk tabel `kas_denda`
--
ALTER TABLE `kas_denda`
  ADD PRIMARY KEY (`id_kas`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`),
  ADD UNIQUE KEY `nama_kategori` (`nama_kategori`);

--
-- Indeks untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id_log`);

--
-- Indeks untuk tabel `request_peminjaman`
--
ALTER TABLE `request_peminjaman`
  ADD PRIMARY KEY (`id_request`),
  ADD KEY `id_buku` (`id_buku`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `idx_request_peminjaman_status` (`status`),
  ADD KEY `idx_request_peminjaman_anggota` (`id_anggota`);

--
-- Indeks untuk tabel `request_pengembalian`
--
ALTER TABLE `request_pengembalian`
  ADD PRIMARY KEY (`id_request`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `idx_request_pengembalian_status` (`status`),
  ADD KEY `idx_request_pengembalian_transaksi` (`id_transaksi`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_buku` (`id_buku`),
  ADD KEY `id_admin` (`id_admin`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `anggota`
--
ALTER TABLE `anggota`
  MODIFY `id_anggota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `kas_denda`
--
ALTER TABLE `kas_denda`
  MODIFY `id_kas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id_log` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT untuk tabel `request_peminjaman`
--
ALTER TABLE `request_peminjaman`
  MODIFY `id_request` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `request_pengembalian`
--
ALTER TABLE `request_pengembalian`
  MODIFY `id_request` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kas_denda`
--
ALTER TABLE `kas_denda`
  ADD CONSTRAINT `kas_denda_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`),
  ADD CONSTRAINT `kas_denda_ibfk_2` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`),
  ADD CONSTRAINT `kas_denda_ibfk_3` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`);

--
-- Ketidakleluasaan untuk tabel `request_peminjaman`
--
ALTER TABLE `request_peminjaman`
  ADD CONSTRAINT `request_peminjaman_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_peminjaman_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_peminjaman_ibfk_3` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `request_peminjaman_ibfk_4` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `request_pengembalian`
--
ALTER TABLE `request_pengembalian`
  ADD CONSTRAINT `request_pengembalian_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_pengembalian_ibfk_2` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_pengembalian_ibfk_3` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
