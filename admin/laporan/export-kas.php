<?php
session_start();
require_once '../../koneksi.php';
require_once '../../includes/fungsi.php';

if (!isLoggedIn() || !isAdmin()) {
    redirect('../../index.php');
}

// Filter
$filter_bulan = $_GET['bulan'] ?? '';
$filter_tahun = $_GET['tahun'] ?? date('Y');
$filter_anggota = $_GET['id_anggota'] ?? '';

$where = "WHERE 1=1";
if (!empty($filter_bulan)) {
    $where .= " AND MONTH(k.tanggal_bayar) = $filter_bulan AND YEAR(k.tanggal_bayar) = $filter_tahun";
} else {
    $where .= " AND YEAR(k.tanggal_bayar) = $filter_tahun";
}
if (!empty($filter_anggota)) {
    $where .= " AND k.id_anggota = $filter_anggota";
}

// Query kas
$kas = mysqli_query($koneksi, "
    SELECT k.*, 
           a.nama as nama_anggota, a.nis_nisn,
           b.judul as judul_buku,
           ad.nama_lengkap as nama_admin
    FROM kas_denda k
    JOIN transaksi t ON k.id_transaksi = t.id_transaksi
    JOIN anggota a ON k.id_anggota = a.id_anggota
    JOIN buku b ON t.id_buku = b.id_buku
    JOIN admin ad ON k.id_admin = ad.id_admin
    $where
    ORDER BY k.tanggal_bayar DESC
");

// Set header untuk download
header('Content-Type: application/vnd.ms-excel');
header('Content-Disposition: attachment; filename="Laporan_Kas_Denda_' . date('Y-m-d') . '.xls"');

// Output HTML yang bisa dibaca Excel
echo "<table border='1'>";
echo "<tr><th colspan='8'><h3>Laporan Kas Denda Perpustakaan</h3></th></tr>";
echo "<tr><th colspan='8'>Periode: " . (empty($filter_bulan) ? $filter_tahun : date('F Y', mktime(0, 0, 0, $filter_bulan, 1, $filter_tahun))) . "</th></tr>";
echo "<tr>
        <th>No</th>
        <th>Tanggal</th>
        <th>Siswa</th>
        <th>NIS/NISN</th>
        <th>Buku</th>
        <th>Jumlah Denda</th>
        <th>Admin</th>
        <th>Keterangan</th>
      </tr>";

$no = 1;
$total = 0;
while ($k = mysqli_fetch_assoc($kas)) {
    $total += $k['jumlah_denda'];
    echo "<tr>";
    echo "<td>" . $no++ . "</td>";
    echo "<td>" . date('d-m-Y', strtotime($k['tanggal_bayar'])) . "</td>";
    echo "<td>" . $k['nama_anggota'] . "</td>";
    echo "<td>" . ($k['nis_nisn'] ?? '-') . "</td>";
    echo "<td>" . $k['judul_buku'] . "</td>";
    echo "<td>Rp " . number_format($k['jumlah_denda'], 0, ',', '.') . "</td>";
    echo "<td>" . $k['nama_admin'] . "</td>";
    echo "<td>" . $k['keterangan'] . "</td>";
    echo "</tr>";
}

echo "<tr>";
echo "<td colspan='5'><strong>TOTAL</strong></td>";
echo "<td><strong>Rp " . number_format($total, 0, ',', '.') . "</strong></td>";
echo "<td colspan='2'></td>";
echo "</tr>";
echo "</table>";
?>