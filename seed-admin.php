<?php
require_once 'koneksi.php';
require_once 'includes/fungsi.php';

// Data admin default
$username = 'admin';
$password = hashPassword('admin123'); // Password: admin123
$nama_lengkap = 'Administrator';
$email = 'admin@perpustakaan.com';
$nohp = '081234567890';

// Cek apakah admin sudah ada
$check = mysqli_query($koneksi, "SELECT * FROM admin WHERE username = '$username'");

if (mysqli_num_rows($check) > 0) {
    echo "Admin sudah ada!";
} else {
    // Insert admin
    $sql = "INSERT INTO admin (username, password, nama_lengkap, email, nohp) 
            VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($koneksi, $sql);
    mysqli_stmt_bind_param($stmt, "sssss", $username, $password, $nama_lengkap, $email, $nohp);
    
    if (mysqli_stmt_execute($stmt)) {
        echo "Admin berhasil dibuat!<br>";
        echo "Username: admin<br>";
        echo "Password: admin123<br>";
    } else {
        echo "Gagal membuat admin!";
    }
}

// Insert beberapa kategori
$kategori = [
    'Fiksi',
    'Non-Fiksi',
    'Sains',
    'Teknologi',
    'Sejarah',
    'Biografi',
    'Komik',
    'Novel'
];

foreach ($kategori as $kat) {
    $check_kat = mysqli_query($koneksi, "SELECT * FROM kategori WHERE nama_kategori = '$kat'");
    if (mysqli_num_rows($check_kat) == 0) {
        mysqli_query($koneksi, "INSERT INTO kategori (nama_kategori) VALUES ('$kat')");
        echo "Kategori '$kat' berhasil ditambahkan!<br>";
    }
}
// Buat tabel kas_denda untuk tracking pemasukan dari denda
$create_kas_table = "
CREATE TABLE IF NOT EXISTS kas_denda (
    id_kas INT PRIMARY KEY AUTO_INCREMENT,
    id_transaksi INT NOT NULL,
    id_anggota INT NOT NULL,
    jumlah_denda DECIMAL(10,2) NOT NULL,
    tanggal_bayar TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_admin INT,
    keterangan VARCHAR(255),
    FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi),
    FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
)";

if (mysqli_query($koneksi, $create_kas_table)) {
    echo "Tabel kas_denda berhasil dibuat!<br>";
} else {
    echo "Error creating table: " . mysqli_error($koneksi) . "<br>";
}

// Tambahkan kolom jumlah_pinjam jika belum ada
$check_request_col = mysqli_query($koneksi, "SHOW COLUMNS FROM request_peminjaman LIKE 'jumlah_pinjam'");
if (mysqli_num_rows($check_request_col) == 0) {
    mysqli_query($koneksi, "ALTER TABLE request_peminjaman ADD COLUMN jumlah_pinjam INT DEFAULT 1 AFTER id_buku");
    echo "Kolom jumlah_pinjam pada request_peminjaman berhasil ditambahkan!<br>";
}

$check_transaksi_col = mysqli_query($koneksi, "SHOW COLUMNS FROM transaksi LIKE 'jumlah_pinjam'");
if (mysqli_num_rows($check_transaksi_col) == 0) {
    mysqli_query($koneksi, "ALTER TABLE transaksi ADD COLUMN jumlah_pinjam INT DEFAULT 1 AFTER id_buku");
    echo "Kolom jumlah_pinjam pada transaksi berhasil ditambahkan!<br>";
}