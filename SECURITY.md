# Security Guidelines & Implementation

## 🔒 Keamanan Aplikasi PerpusDigi

Dokumen ini menjelaskan praktik keamanan yang diimplementasikan dalam PerpusDigi dan panduan untuk pengembang.

---

## 1. Authentication & Authorization

### Password Hashing
- **Algoritma:** bcrypt (recommended dan built-in di PHP)
- **Implementation:**
  ```php
  // Hashing password saat registrasi
  $hashed_password = password_hash($password, PASSWORD_BCRYPT);
  
  // Verifikasi password saat login
  if (password_verify($input_password, $hashed_password)) {
      // Password benar
  }
  ```
- **Keuntungan:** Salt otomatis, adaptive cost factor

### Session Management
- **Timeout:** 1 jam (konfigurasi di `.env`)
- **Session regeneration:** Dilakukan saat login untuk mencegah session fixation
- **Secure flag:** Cookies hanya dikirim via HTTPS di production

### Role-Based Access Control (RBAC)
```php
// Helper functions untuk role checking
if (!isAdmin()) {
    redirect('../../index.php');
}
```

---

## 2. Input Validation & Sanitization

### Current Implementation
- Server-side validation di semua form
- HTML escaping untuk output dengan `htmlspecialchars()`
- Type checking untuk integer ID

### Improvement Plan
```php
// Validate & sanitize input function (template)
function validateInput($data, $type = 'string') {
    $data = trim($data);
    
    switch($type) {
        case 'email':
            return filter_var($data, FILTER_VALIDATE_EMAIL);
        case 'integer':
            return filter_var($data, FILTER_VALIDATE_INT);
        case 'phone':
            return preg_match('/^(\+62|0)[0-9]{9,12}$/', $data) ? $data : false;
        default:
            return htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
    }
}
```

---

## 3. SQL Injection Prevention

### Current Status
- ❌ **ISSUE:** Menggunakan procedural MySQLi (vulnerable to SQL injection)
- ✅ **RECOMMENDED:** Prepared statements dengan parametrized queries

### Implementation Refactor
```php
// ❌ VULNERABLE (Current)
$query = "SELECT * FROM anggota WHERE id_anggota = " . $_GET['id'];

// ✅ SECURE (Use prepared statements)
$query = "SELECT * FROM anggota WHERE id_anggota = ?";
$stmt = $koneksi->prepare($query);
$stmt->bind_param("i", $_GET['id']);
$stmt->execute();
$result = $stmt->get_result();
```

### Migration Plan
- Prioritas tinggi: `login-proses.php`, `admin/*/tambah.php`, `admin/*/edit.php`
- Wrap semua DELETE/UPDATE/INSERT queries dengan prepared statements

---

## 4. Cross-Site Scripting (XSS) Prevention

### Current Implementation
- Output escaping dengan `htmlspecialchars()`

### Template untuk Output
```php
// ✅ SAFE - Escape semua user input yang ditampilkan
<td><?php echo htmlspecialchars($row['nama'], ENT_QUOTES, 'UTF-8'); ?></td>

// ✅ SAFE - Untuk attribute
<a href="<?php echo htmlspecialchars($row['link'], ENT_QUOTES); ?>">Link</a>
```

---

## 5. CSRF (Cross-Site Request Forgery) Protection

### Status
- ❌ **NOT IMPLEMENTED** - Priority untuk improvement

### Implementation Plan
```php
// Generate token
function generateCSRFToken() {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

// Validate token
function validateCSRFToken($token) {
    return hash_equals($_SESSION['csrf_token'] ?? '', $token);
}

// Dalam form
<input type="hidden" name="csrf_token" value="<?php echo generateCSRFToken(); ?>">

// Saat process
if (!validateCSRFToken($_POST['csrf_token'] ?? '')) {
    die('CSRF token validation failed');
}
```

---

## 6. Data Security

### Password Storage
- ✅ Bcrypt hashing
- ✅ Unique salt per password
- ❌ No rate limiting on login attempts (improvement needed)

### Sensitive Data
- Database credentials: gunakan `.env` file (jangan hardcode)
- Session data: store di server, bukan client
- Personal data: anggota/siswa info dilindungi by RBAC

### Database Encryption
- Currently: Plain text (acceptable untuk internal/intranet)
- Recommendation: Encrypt sensitive columns (no_hp, email) untuk production

---

## 7. Logging & Audit Trail

### Current Implementation
```php
// Log aktivitas - tabel log_aktivitas
INSERT INTO log_aktivitas (user_id, aksi, waktu) 
VALUES (?, ?, NOW())
```

### Logs yang Dicatat
- ✅ Login/logout
- ✅ Admin actions (tambah/edit/hapus buku, anggota, transaksi)
- ✅ Approval workflow

### Recommended Additions
- Login failures (untuk detect brute force)
- Failed authorization attempts
- Sensitive data access

---

## 8. Best Practices Checklist

- [ ] Ganti semua MySQLi query ke prepared statements
- [ ] Implement CSRF token di semua forms
- [ ] Add rate limiting for login attempts
- [ ] Add client-side validation (alongside server-side)
- [ ] Implement password strength requirements
- [ ] Add 2FA untuk admin (optional)
- [ ] Encrypt sensitive database columns
- [ ] Add API rate limiting jika ada API endpoints
- [ ] Implement HTTPS enforcing di production
- [ ] Regular security audits & penetration testing

---

## 9. Deployment Security

### Before Going to Production
```bash
# 1. Update .env dengan production values
# 2. Set SESSION_LIFETIME appropriately
# 3. Enable error logging (log to file, not display)
# 4. Disable APP_DEBUG
# 5. Use HTTPS only
# 6. Set proper file permissions
chmod 644 koneksi.php
chmod 644 index.php
chmod 750 includes/
# 7. Database backup strategy
# 8. Web server hardening (Apache/Nginx)
```

### PHP Configuration (php.ini)
```ini
# Security headers
display_errors = Off
log_errors = On
error_log = /var/log/php-errors.log

# Session security
session.cookie_httponly = On
session.cookie_secure = On
session.cookie_samesite = Strict

# Upload security
upload_max_filesize = 10M
post_max_size = 10M
```

---

## 10. Security Testing

### Manual Testing Checklist
- [ ] Test SQL injection: `' OR '1'='1`
- [ ] Test XSS: `<script>alert('XSS')</script>` di input fields
- [ ] Test CSRF: Submit form dari domain lain
- [ ] Test authorization: Akses admin page sebagai siswa
- [ ] Test session timeout: Tunggu > 1 jam, refresh page
- [ ] Test file upload: Upload PHP file jika ada upload feature

### Recommended Tools
- SQLMap: SQL injection testing
- OWASP ZAP: Web security scanner
- Burp Suite: Penetration testing

---

## 📞 Reporting Security Issues

Jika menemukan security vulnerability:
1. **Jangan** post di issue publik
2. Email: muhraufaziz@gmail.com dengan subject `[SECURITY] vulnerability name`
3. Sertakan: detail bug, cara reproduce, impact assessment

---

## 📚 References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [PHP Security Manual](https://www.php.net/manual/en/security.php)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [CWE Top 25](https://cwe.mitre.org/top25/)
