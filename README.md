# Sistem Informasi Peminjaman Buku Perpustakaan Sekolah

Aplikasi web untuk manajemen peminjaman buku perpustakaan sekolah, dibangun dengan **PHP Native** dan **MySQL**. Mendukung dua peran pengguna (Admin & Siswa) untuk mendigitalisasi seluruh proses peminjaman dan pengembalian buku.

## Fitur Utama

**Untuk Admin**
- Dashboard dengan statistik & notifikasi (buku terlambat, request pending)
- Kelola data buku, kategori, dan anggota (CRUD)
- Approve/reject request peminjaman & pengembalian dari siswa
- Peminjaman & pengembalian manual
- Perhitungan denda keterlambatan otomatis
- Riwayat transaksi & laporan
- Log aktivitas untuk audit trail

**Untuk Siswa**
- Registrasi & login mandiri
- Melihat katalog buku yang tersedia
- Request peminjaman & pengembalian buku
- Melihat riwayat & status peminjaman pribadi
- Kelola profil dan ubah password

## Tech Stack

- **Backend:** PHP Native (tanpa framework)
- **Database:** MySQL
- **Frontend:** Bootstrap 5, JavaScript, CSS
- **Autentikasi:** Session-based, password hashing dengan bcrypt

## Struktur Database

Terdiri dari 7 tabel utama: `admin`, `anggota`, `buku`, `kategori`, `transaksi`, `request_peminjaman`, `request_pengembalian`, dan `log_aktivitas` — dengan relasi foreign key untuk menjaga konsistensi data antar peminjaman, buku, dan anggota.

## Struktur Folder

```
peminjaman/
├── admin/          # Panel Admin (dashboard, kelola buku, anggota, transaksi)
├── siswa/          # Panel Siswa (katalog, request pinjam/kembali, profil)
├── includes/       # Komponen shared (header, footer, sidebar, helper functions)
├── assets/         # CSS, JS, dan gambar
├── koneksi.php     # Koneksi database & session
├── index.php       # Halaman login
└── seed-admin.php  # Setup akun admin awal
```

## Instalasi

1. Clone repository ini
   ```bash
   git clone https://github.com/azizrauf7/projek_peminjaman_buku.git
   ```
2. Import database (buat database baru lalu import struktur tabel di atas)
3. Atur koneksi database di `koneksi.php`
4. Jalankan `seed-admin.php` untuk membuat akun admin awal
5. Jalankan project di local server (XAMPP/Laragon) dan akses `index.php`

## Keamanan

- Password disimpan dengan hashing bcrypt
- Setiap halaman terproteksi dilengkapi pengecekan session & role (admin/siswa)
- Log aktivitas untuk login dan aksi penting admin

## Status

Project ini dikembangkan sebagai proyek pembelajaran individu. Beberapa peningkatan yang direncanakan ke depan: prepared statements penuh di seluruh query, proteksi CSRF, pagination, dan fitur pencarian/filter.

## 👤 Author

**Muhamad Rauf Aziz**
📧 muhraufaziz@gmail.com
