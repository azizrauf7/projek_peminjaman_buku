<?php
session_start();
require_once '../../koneksi.php';
require_once '../../includes/fungsi.php';

if (!isLoggedIn() || !isAdmin()) {
    redirect('../../index.php');
}

$title = 'Laporan Kas Denda';
$base_url = '../../';
include '../../includes/header.php';

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

// Hitung total
$total_query = mysqli_query($koneksi, "
    SELECT SUM(k.jumlah_denda) as total_jumlah, COUNT(k.id_kas) as total_transaksi
    FROM kas_denda k
    $where
");
$total_data = mysqli_fetch_assoc($total_query);
$total_jumlah = $total_data['total_jumlah'] ?? 0;
$total_transaksi = $total_data['total_transaksi'] ?? 0;

// Ambil list anggota untuk filter
$list_anggota = mysqli_query($koneksi, "SELECT id_anggota, nama FROM anggota ORDER BY nama ASC");
?>

<div class="d-flex">
    <?php include '../../includes/sidebar_admin.php'; ?>
    
    <div class="flex-grow-1 p-4" style="margin-left: 280px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Laporan Kas Denda</h2>
            <a href="export-kas.php?bulan=<?php echo $filter_bulan; ?>&tahun=<?php echo $filter_tahun; ?>&id_anggota=<?php echo $filter_anggota; ?>" 
               class="btn btn-outline-dark btn-sm">
                📥 Export Excel
            </a>
        </div>
        
        <!-- Filter -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="GET" class="row g-3">
                    <div class="col-md-2">
                        <label class="form-label">Tahun</label>
                        <select name="tahun" class="form-select">
                            <?php for ($i = date('Y'); $i >= 2020; $i--): ?>
                                <option value="<?php echo $i; ?>" <?php echo $filter_tahun == $i ? 'selected' : ''; ?>>
                                    <?php echo $i; ?>
                                </option>
                            <?php endfor; ?>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Bulan (Opsional)</label>
                        <select name="bulan" class="form-select">
                            <option value="">Semua Bulan</option>
                            <?php for ($i = 1; $i <= 12; $i++): ?>
                                <option value="<?php echo $i; ?>" <?php echo $filter_bulan == $i ? 'selected' : ''; ?>>
                                    <?php echo date('F', mktime(0, 0, 0, $i, 1)); ?>
                                </option>
                            <?php endfor; ?>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Siswa (Opsional)</label>
                        <select name="id_anggota" class="form-select">
                            <option value="">Semua Siswa</option>
                            <?php while ($ag = mysqli_fetch_assoc($list_anggota)): ?>
                                <option value="<?php echo $ag['id_anggota']; ?>" <?php echo $filter_anggota == $ag['id_anggota'] ? 'selected' : ''; ?>>
                                    <?php echo $ag['nama']; ?>
                                </option>
                            <?php endwhile; ?>
                        </select>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Filter</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Ringkasan -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title">Total Pemasukan</h6>
                        <h3 class="text-success">Rp <?php echo number_format($total_jumlah, 0, ',', '.'); ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title">Total Transaksi</h6>
                        <h3 class="text-info"><?php echo $total_transaksi; ?></h3>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Tabel Kas -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Tanggal</th>
                                <th>Siswa</th>
                                <th>NIS/NISN</th>
                                <th>Buku</th>
                                <th>Jumlah Denda</th>
                                <th>Admin</th>
                                <th>Keterangan</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (mysqli_num_rows($kas) > 0): ?>
                                <?php 
                                $no = 1;
                                while ($k = mysqli_fetch_assoc($kas)): 
                                ?>
                                <tr>
                                    <td><?php echo $no++; ?></td>
                                    <td><?php echo formatTanggal(date('Y-m-d', strtotime($k['tanggal_bayar']))); ?></td>
                                    <td><?php echo $k['nama_anggota']; ?></td>
                                    <td><?php echo $k['nis_nisn'] ?? '-'; ?></td>
                                    <td><?php echo $k['judul_buku']; ?></td>
                                    <td>
                                        <span class="badge bg-success">
                                            Rp <?php echo number_format($k['jumlah_denda'], 0, ',', '.'); ?>
                                        </span>
                                    </td>
                                    <td><small><?php echo $k['nama_admin']; ?></small></td>
                                    <td><small><?php echo $k['keterangan']; ?></small></td>
                                </tr>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <tr>
                                    <td colspan="8" class="text-center">Tidak ada data kas denda</td>
                                </tr>
                            <?php endif; ?>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="5" class="text-end">Total:</th>
                                <th>
                                    <span class="badge bg-success">
                                        Rp <?php echo number_format($total_jumlah, 0, ',', '.'); ?>
                                    </span>
                                </th>
                                <th colspan="2"></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '../../includes/footer.php'; ?>