# Sistem Informasi Peminjaman Buku Perpustakaan Sekolah

Aplikasi web untuk manajemen peminjaman buku perpustakaan sekolah, dibangun dengan **PHP Native** dan **MySQL**. Mendukung dua peran pengguna (Admin & Siswa) untuk mendigitalisasi seluruh proses peminjaman buku.

>
---

## 📚 Daftar Isi
- [Fitur Utama](#fitur-utama)
- [Tech Stack](#tech-stack)
- [Quick Start](#quick-start)
- [Struktur Database](#struktur-database)
- [Arsitektur Aplikasi](#arsitektur-aplikasi)
- [API Documentation](#api-documentation)
- [Security](#security)
- [Deployment](#deployment)
- [Improvement Roadmap](#improvement-roadmap)

---

## ✨ Fitur Utama

### 👨‍💼 Admin Panel
- **Dashboard** dengan statistik real-time & notifikasi penting
  - Total buku, anggota, peminjaman aktif
  - Buku terlambat & request pending
- **Manajemen Data**
  - ✏️ CRUD buku, kategori, anggota
  - 📊 Riwayat transaksi lengkap
  - 🔍 Search & filter data
- **Approval Workflow**
  - Approve/reject request peminjaman dari siswa
  - Approve pengembalian buku
  - Manual peminjaman & pengembalian
- **Sistem Denda**
  - Perhitungan otomatis denda keterlambatan
  - Tracking pembayaran denda
- **Audit & Logging**
  - Log aktivitas admin (login, CRUD, approval)
  - Riwayat lengkap setiap transaksi

### 👨‍🎓 Student Panel
- **Self-Service Registration** & login
- **Book Catalog**
  - Lihat semua buku yang tersedia
  - Filter by kategori & stok
  - Informasi detail buku
- **Request Management**
  - Request peminjaman buku
  - Track status request
  - Lihat jadwal pengembalian
- **Personal History**
  - Riwayat peminjaman pribadi
  - Status peminjaman aktif
  - Denda (jika ada)
- **Profile Management**
  - Ubah password
  - Edit profil pribadi
  - Lihat informasi akun

---

## 🛠 Tech Stack

| Component | Technology |
|-----------|-----------|
| **Backend** | PHP 7.4+ (Native, tanpa framework) |
| **Database** | MySQL 5.7+ / MariaDB |
| **Frontend** | Bootstrap 5, HTML5, CSS3, JavaScript ES6+ |
| **Authentication** | Session-based, Password hashing (bcrypt) |
| **Server** | Apache 2.4+ / Nginx 1.20+ |

### Dependencies
- **PHP Extensions:** MySQLi, PDO
- **Frontend Libraries:** Bootstrap 5, jQuery (optional)
- **Security:** Password hashing (built-in `password_hash()`)

---

## 🚀 Quick Start

### Prerequisites
```bash
# Minimum versions
PHP >= 7.4
MySQL >= 5.7
Apache/Nginx

# Check PHP version
php -v

# Check MySQL
mysql --version
```

### Local Setup

1. **Clone Repository**
   ```bash
   git clone https://github.com/azizrauf7/projek_peminjaman_buku.git
   cd projek_peminjaman_buku
   ```

2. **Setup Database**
   ```bash
   # Create database
   mysql -u root -p
   > CREATE DATABASE db_perpustakaan;
   > EXIT;
   
   # Import schema
   mysql -u root -p db_perpustakaan < db_perpustakaan.sql
   ```

3. **Configuration**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Edit .env dengan database credentials
   nano .env
   ```

4. **Initialize Admin Account**
   ```
   1. Start local server: php -S localhost:8000
   2. Akses http://localhost:8000
   3. Akses http://localhost:8000/seed-admin.php untuk setup admin awal
   4. Delete/rename seed-admin.php setelah setup
   5. Login dengan credentials yang dibuat
   ```

5. **Run Application**
   ```bash
   # Development
   php -S localhost:8000
   
   # Production - configure your web server
   # See DEPLOYMENT.md for detailed setup
   ```

---

## 📊 Struktur Database

```
┌─────────────────────────────────────────────────────────┐
│ DATABASE: db_perpustakaan (7 Main Tables)              │
└─────────────────────────────────────────────────────────┘

admin
├── id_admin (PK)
├── username (UNIQUE)
├── password (hashed)
├── email
└── created_at

anggota (Members/Students)
├── id_anggota (PK)
├── nis_nisn (Student ID)
├── nama
├── email
├── password (hashed)
├── kelas_jurusan
├── jenis_kelamin
├── nohp
├── status_aktif
└── created_at

buku (Books)
├── id_buku (PK)
├── isbn (UNIQUE)
├── judul
├── pengarang
├── id_kategori (FK)
├── penerbit
├── tahun_terbit
├── stok_total
├── stok_tersedia
├── cover_path
└── created_at

kategori (Categories)
├── id_kategori (PK)
├── nama_kategori (UNIQUE)
└── created_at

transaksi (Transactions/Borrowing Records)
├── id_transaksi (PK)
├── id_anggota (FK)
├── id_buku (FK)
├── tgl_peminjaman
├── tgl_pengembalian_jadwal
├── tgl_pengembalian_aktual
├── status
├── denda
└── created_at

request_peminjaman (Borrow Requests)
├── id_request (PK)
├── id_anggota (FK)
├── id_buku (FK)
├── status (pending/approved/rejected)
├── tanggal_request
└── created_at

log_aktivitas (Activity Logs)
├── id_log (PK)
├── id_admin (FK)
├── aksi (action description)
├── waktu
└── created_at
```

### Key Relationships
```
anggota 1---* transaksi
buku 1---* transaksi
anggota 1---* request_peminjaman
buku 1---* request_peminjaman
admin 1---* log_aktivitas
kategori 1---* buku
```

---

## 🏗 Arsitektur Aplikasi

### Folder Structure
```
projek_peminjaman_buku/
├── admin/
│   ├── dashboard.php           # Admin dashboard
│   ├── anggota/                # Member management
│   │   ├── index.php
│   │   ├── tambah.php
│   │   ├── edit.php
│   │   └── hapus.php
│   ├── buku/                   # Book management
│   │   ├── index.php
│   │   ├── tambah.php
│   │   ├── edit.php
│   │   └── hapus.php
│   ├── kategori/               # Category management
│   ├── transaksi/              # Transaction history
│   ├── request/                # Request approval
│   └── laporan/                # Reports
├── siswa/
│   ├── dashboard.php           # Student dashboard
│   ├── register.php            # Self-registration
│   ├── katalog.php             # Book catalog
│   ├── request-pinjam.php      # Borrow request
│   ├── riwayat.php             # Borrowing history
│   ├── profil.php              # Profile management
│   └── pengaturan.php          # Settings
├── includes/
│   ├── koneksi.php             # Database connection
│   ├── fungsi.php              # Helper functions
│   ├── header.php              # Common header
│   ├── footer.php              # Common footer
│   ├── sidebar_admin.php       # Admin sidebar
│   └── sidebar_siswa.php       # Student sidebar
├── assets/
│   ├── css/                    # Stylesheets
│   ├── js/                     # JavaScript
│   ├── images/                 # Images & icons
│   └── buku/                   # Book covers
├── module/                     # Business logic modules
├── index.php                   # Login page entry point
├── login-proses.php            # Login processing
├── logout.php                  # Logout
├── lupa-password.php           # Password recovery
├── seed-admin.php              # Admin seeding script
├── db_perpustakaan.sql         # Database schema
├── koneksi.php                 # Database connection config
├── README.md                   # This file
├── DEPLOYMENT.md               # Deployment guide
├── SECURITY.md                 # Security documentation
└── .env.example                # Environment template
```

### Architecture Pattern
```
MVC-inspired (Modified)
├── Model Layer: Direct database queries (MySQLi)
├── View Layer: PHP templates dengan Bootstrap
└── Controller: Page PHP files handling logic
```

---

## 🔌 API Documentation

### Authentication Endpoints

#### Login
```http
POST /login-proses.php
Content-Type: application/x-www-form-urlencoded

username=admin&password=secret&role=admin
```

**Response:** Redirect ke dashboard atau error message

#### Logout
```http
GET /logout.php
```

---

### Admin Endpoints

#### Get All Members
```
GET /admin/anggota/index.php
Authentication: Admin session required
Response: HTML table dengan data anggota
```

#### Add Member
```
POST /admin/anggota/tambah.php
Parameters:
  - nis_nisn: string
  - nama: string
  - email: string
  - kelas_jurusan: string
  - jenis_kelamin: string
  - nohp: string
```

#### Edit Member
```
GET /admin/anggota/edit.php?id=1
POST /admin/anggota/edit.php
Parameters: (same as add)
```

#### Delete Member
```
GET /admin/anggota/hapus.php?id=1
Confirmation: Client-side confirm dialog
```

#### View Books
```
GET /admin/buku/index.php
Response: Table dengan buku, category join
```

#### Approve Borrow Request
```
POST /admin/request/approve.php
Parameters:
  - id_request: integer
  - action: approve/reject
```

---

### Student Endpoints

#### Register
```
POST /siswa/register.php
Parameters:
  - nis_nisn: string
  - nama: string
  - email: string (unique)
  - password: string
  - kelas_jurusan: string
  - jenis_kelamin: string
  - nohp: string
```

#### View Book Catalog
```
GET /siswa/katalog.php
Query params (optional):
  - kategori=1
  - search=keyword
Response: Filtered book list
```

#### Request Borrow
```
POST /siswa/request-pinjam.php
Parameters:
  - id_buku: integer
Response: Request created, redirect to dashboard
```

#### View Borrowing History
```
GET /siswa/riwayat.php
Response: Table dengan transaksi history
```

---

## 🔒 Security

### Implemented
- ✅ **Password Hashing:** Bcrypt (`password_hash()`)
- ✅ **Session Management:** Session-based authentication
- ✅ **Access Control:** Role-based (Admin/Student)
- ✅ **Input Validation:** Server-side validation
- ✅ **Output Escaping:** `htmlspecialchars()` untuk prevent XSS
- ✅ **Audit Logging:** Activity logging untuk admin actions
- ✅ **SQL Protection:** MySQLi (basic protection)

### Security Concerns & Improvements
See [SECURITY.md](SECURITY.md) for detailed security guidelines including:
- SQL injection prevention (prepared statements)
- CSRF token implementation
- Rate limiting for login
- Advanced authentication patterns

---

## 📋 Instalasi & Deployment

Untuk deployment ke production:
- **Shared Hosting (Cpanel):** Lihat [DEPLOYMENT.md](DEPLOYMENT.md) - Method 1
- **VPS/Cloud (Ubuntu):** Lihat [DEPLOYMENT.md](DEPLOYMENT.md) - Method 2
- **Docker:** Lihat [DEPLOYMENT.md](DEPLOYMENT.md) - Method 3

### Checklist Sebelum Deploy
- [ ] Database credentials di-setup correctly
- [ ] `.env` file konfigurasi dengan production values
- [ ] HTTPS/SSL certificate installed
- [ ] Admin account sudah dibuat
- [ ] File permissions set correctly (755 for dirs, 644 for files)
- [ ] Error logging configured (off display, log to file)
- [ ] Backups automated
- [ ] Security headers configured

---

## 🚀 Improvement Roadmap

### High Priority (v1.1)
- [ ] Implement prepared statements untuk semua queries
- [ ] Add CSRF token protection di semua forms
- [ ] Add rate limiting untuk login attempts
- [ ] Implement pagination untuk large datasets
- [ ] Add input validation helper functions
- [ ] Setup error logging system

### Medium Priority (v1.2)
- [ ] API endpoints (REST/GraphQL)
- [ ] Advanced search & filtering
- [ ] Export to PDF/Excel functionality
- [ ] Email notifications
- [ ] Two-factor authentication (optional)
- [ ] Dashboard analytics improvements

### Nice to Have (Future)
- [ ] Mobile app (React Native/Flutter)
- [ ] QR code scanning untuk book borrow
- [ ] Book recommendation system
- [ ] Reservation system
- [ ] Database encryption for sensitive data
- [ ] Full-text search capability

---

## 📊 Screenshots

### Login Page
![Login](screenshot/Screenshot%202026-07-14%20051412.png)

### Admin Dashboard
![Dashboard Admin](screenshot/Screenshot%202026-07-14%20050952.png)

### Student Book Catalog
![Katalog Buku](screenshot/Screenshot%202026-07-14%20051347.png)

---

## 👥 User Roles

### Admin
- Full system access
- Manage all data (buku, anggota, transaksi)
- Approve/reject requests
- View audit logs
- Generate reports

### Student
- Register & login self-service
- View available books
- Request borrow/return
- View personal borrowing history
- Manage own profile
- Track pending fines

---

## 🐛 Troubleshooting

### Common Issues

**Database Connection Error**
```
Error: "Koneksi gagal: SQLSTATE[HY000]"
Solution: Check DB credentials in .env, ensure MySQL running
```

**Login Not Working**
```
Solution: Check if session_start() is called, verify database has admin record
```

**403 Forbidden on admin pages**
```
Solution: Check file permissions (chmod 755), verify web server ownership
```

See [DEPLOYMENT.md](DEPLOYMENT.md#troubleshooting) untuk more troubleshooting tips.

---

## 📄 License

Project ini adalah educational project dan open untuk modification & distribution.

---

## 👤 Author

**Muhamad Rauf Aziz**
- 📧 Email: muhraufaziz@gmail.com
- 🔗 GitHub: [@azizrauf7](https://github.com/azizrauf7)
- 📅 Created: 2026-07-13

---

## 📚 Documentation

- [DEPLOYMENT.md](DEPLOYMENT.md) - Detailed deployment guide
- [SECURITY.md](SECURITY.md) - Security guidelines & best practices
- [.env.example](.env.example) - Environment configuration template

---

## 🤝 Contributing

Contributions welcome! Silakan:
1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

---

## ⭐ Show Your Support

Jika project ini membantu, silakan berikan ⭐ star di GitHub!

---

**Last Updated:** 2026-07-13
**Version:** 1.0.0
**Status:** Production Ready ✅
