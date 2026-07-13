# Panduan Deployment - PerpusDigi

Panduan lengkap untuk mendeploy aplikasi PerpusDigi ke production, testing, atau server lain.

---

## 📋 Prerequisites

### Minimum Requirements
- PHP 7.4+ (recommended: PHP 8.0+)
- MySQL 5.7+ atau MariaDB 10.3+
- Web server: Apache 2.4+ atau Nginx 1.20+
- 100MB disk space
- Koneksi internet (untuk setup awal)

### Local Development
Sebelum deploy, pastikan aplikasi running sempurna di local:
```bash
cd projek_peminjaman_buku
php -S localhost:8000
# Akses http://localhost:8000
```

---

## 🚀 Deployment Methods

### Method 1: Shared Hosting (Cpanel/Plesk)

#### Step 1: Prepare Files
```bash
# 1. Clone atau download repository
git clone https://github.com/azizrauf7/projek_peminjaman_buku.git

# 2. Setup environment
cp .env.example .env

# 3. Edit .env dengan config hosting
nano .env
```

#### Step 2: Upload via FTP/SFTP
```bash
# Gunakan FileZilla atau rsync
# Upload semua files ke public_html/ atau folder public

# Permissions
chmod 755 /path/to/app
chmod 644 /path/to/app/*.php
chmod 755 /path/to/app/includes
```

#### Step 3: Database Setup via Cpanel
```
1. Go to MySQL Databases
2. Create new database: db_perpustakaan
3. Create database user
4. Add user to database (All privileges)
5. Go to phpMyAdmin
6. Import db_perpustakaan.sql
```

#### Step 4: Configure Connection
```php
// Edit koneksi.php
$host = 'localhost'; // atau hostname dari hosting
$user = 'db_user_name';
$pass = 'db_password';
$db = 'db_perpustakaan';
```

#### Step 5: Run Initialization
```
1. Akses http://yourdomain.com/seed-admin.php
2. Buat akun admin awal
3. Delete seed-admin.php dari server (security)
4. Login dengan akun admin
```

---

### Method 2: VPS/Cloud Server (Ubuntu/Debian)

#### Step 1: Server Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install LEMP Stack
sudo apt install -y nginx mysql-server php php-mysql php-fpm php-cli

# Start services
sudo systemctl start nginx mysql-server php8.2-fpm
sudo systemctl enable nginx mysql-server php8.2-fpm
```

#### Step 2: Configure Nginx
```nginx
# File: /etc/nginx/sites-available/perpusdigi
server {
    listen 80;
    server_name yourdomain.com;
    root /var/www/perpusdigi;
    index index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    location ~ /\. {
        deny all;
    }
}
```

```bash
# Enable site
sudo ln -s /etc/nginx/sites-available/perpusdigi /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

#### Step 3: Clone Repository
```bash
cd /var/www
git clone https://github.com/azizrauf7/projek_peminjaman_buku.git perpusdigi
cd perpusdigi

# Setup environment
cp .env.example .env
nano .env
```

#### Step 4: Database Setup
```bash
# Login MySQL
sudo mysql -u root

# Create database & user
CREATE DATABASE db_perpustakaan;
CREATE USER 'perpus_user'@'localhost' IDENTIFIED BY 'strong_password';
GRANT ALL PRIVILEGES ON db_perpustakaan.* TO 'perpus_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Import schema
mysql -u perpus_user -p db_perpustakaan < db_perpustakaan.sql
```

#### Step 5: Configure Permissions
```bash
# Set ownership
sudo chown -R www-data:www-data /var/www/perpusdigi

# Set permissions
sudo chmod -R 755 /var/www/perpusdigi
sudo chmod -R 644 /var/www/perpusdigi/*.php
sudo chmod -R 644 /var/www/perpusdigi/includes/*.php
```

#### Step 6: SSL Certificate (HTTPS)
```bash
# Install Certbot
sudo apt install -y certbot python3-certbot-nginx

# Generate certificate
sudo certbot certonly --standalone -d yourdomain.com

# Configure Nginx for HTTPS (Certbot auto-configure)
sudo certbot --nginx -d yourdomain.com
```

---

### Method 3: Docker Deployment

#### Dockerfile
```dockerfile
# File: Dockerfile
FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    mysql-client \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Copy application
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000
CMD ["php-fpm"]
```

#### docker-compose.yml
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "80:80"
    volumes:
      - .:/var/www/html
    depends_on:
      - db
    environment:
      DB_HOST: db
      DB_USER: perpus_user
      DB_PASS: password123
      DB_NAME: db_perpustakaan

  db:
    image: mysql:8.0
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: db_perpustakaan
      MYSQL_USER: perpus_user
      MYSQL_PASSWORD: password123
    volumes:
      - db_data:/var/lib/mysql
      - ./db_perpustakaan.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  db_data:
```

Deploy dengan Docker:
```bash
docker-compose up -d
# Akses http://localhost
```

---

## 🔧 Post-Deployment Configuration

### 1. Environment Variables
```bash
# Copy dan edit .env
cp .env.example .env

# Edit database credentials, app settings
nano .env
```

### 2. File Permissions
```bash
# Production permissions
find /path/to/app -type f -exec chmod 644 {} \;
find /path/to/app -type d -exec chmod 755 {} \;

# Writable directories (jika ada upload)
chmod 775 /path/to/app/uploads
```

### 3. Database Backup Strategy
```bash
# Automated daily backup
# File: /usr/local/bin/backup-perpusdigi.sh
#!/bin/bash
BACKUP_DIR="/backups/perpusdigi"
mkdir -p $BACKUP_DIR
mysqldump -u perpus_user -p'password' db_perpustakaan > $BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql
find $BACKUP_DIR -name "*.sql" -mtime +30 -delete  # Delete backups older than 30 days
```

```bash
# Add to crontab
crontab -e
# Add: 0 2 * * * /usr/local/bin/backup-perpusdigi.sh
```

### 4. Security Hardening

#### Apache/Nginx Config
```apache
# .htaccess (Apache)
<FilesMatch "\.(env|sql|log)$">
    Deny from all
</FilesMatch>

# Prevent directory listing
Options -Indexes
```

```nginx
# Nginx config
location ~ /\. {
    deny all;
    access_log off;
    log_not_found off;
}

location ~ "^/\.env|\.sql|\.log" {
    deny all;
}
```

#### Disable Dangerous Features
```php
// Di koneksi.php atau includes/fungsi.php
ini_set('display_errors', '0');
ini_set('log_errors', '1');
error_reporting(E_ALL);
```

### 5. Monitoring & Logging

```bash
# Setup log rotation
# File: /etc/logrotate.d/perpusdigi
/var/www/perpusdigi/logs/*.log {
    daily
    rotate 14
    compress
    delaycompress
    notifempty
    create 644 www-data www-data
}
```

---

## 📊 Post-Deployment Checklist

- [ ] Database successfully created & seeded
- [ ] Admin account created
- [ ] Login working (both admin & siswa)
- [ ] All CRUD operations working
- [ ] File uploads working (if applicable)
- [ ] Emails sending (if configured)
- [ ] Backups automated
- [ ] SSL certificate installed (HTTPS)
- [ ] Error logging configured
- [ ] Performance monitoring setup
- [ ] Database optimization (indexes, queries)
- [ ] Security headers configured
- [ ] Rate limiting configured

---

## 🐛 Troubleshooting

### Issue: Database Connection Error
```
Error: "Koneksi gagal: SQLSTATE[HY000] [2002]"
```
**Solution:**
- Verify MySQL is running: `sudo systemctl status mysql`
- Check credentials in `.env`
- Ensure database user has privileges
- Test connection: `mysql -u user -p -h host`

### Issue: 403 Forbidden
```
Forbidden: You don't have permission to access this resource
```
**Solution:**
```bash
sudo chown -R www-data:www-data /path/to/app
sudo chmod -R 755 /path/to/app
```

### Issue: Blank Page / 500 Error
**Solution:**
```bash
# Enable error logging
tail -f /var/log/php-errors.log
tail -f /var/log/nginx/error.log

# Check file permissions
ls -la /var/www/perpusdigi/
```

### Issue: Session Not Working
**Solution:**
```bash
# Check session save path exists & writable
php -r "echo ini_get('session.save_path');"
ls -la /var/lib/php/sessions/
```

---

## 🔄 Updating Application

```bash
cd /var/www/perpusdigi

# Backup first
mysqldump -u perpus_user -p db_perpustakaan > backup_$(date +%Y%m%d).sql

# Pull latest changes
git pull origin main

# Run database migrations (if any)
# Update .env if needed
```

---

## 📞 Support & References

- [PHP Documentation](https://www.php.net/docs.php)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [DigitalOcean Tutorials](https://www.digitalocean.com/community/tutorials)

---

**Last Updated:** 2026-07-13  
**Author:** Muhamad Rauf Aziz
