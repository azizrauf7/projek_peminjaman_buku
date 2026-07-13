<?php
require_once 'koneksi.php';
require_once 'includes/fungsi.php';

$title = 'Lupa Password - PerpusDigi';
include 'includes/header.php';

$error = '';
$success = '';
$username = '';
$email = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = clean($_POST['username']);
    $email = clean($_POST['email']);
    $password_baru = $_POST['password_baru'];
    $konfirmasi_password = $_POST['konfirmasi_password'];

    if (empty($username) || empty($email) || empty($password_baru) || empty($konfirmasi_password)) {
        $error = 'Semua field wajib diisi.';
    } elseif ($password_baru !== $konfirmasi_password) {
        $error = 'Password baru dan konfirmasi tidak cocok.';
    } elseif (strlen($password_baru) < 6) {
        $error = 'Password baru minimal 6 karakter.';
    } else {
        $sql = "SELECT id_anggota FROM anggota WHERE username = ? AND email = ? AND status_aktif = 1";
        $stmt = mysqli_prepare($koneksi, $sql);
        mysqli_stmt_bind_param($stmt, 'ss', $username, $email);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($row = mysqli_fetch_assoc($result)) {
            $id = $row['id_anggota'];
            $password_hash = hashPassword($password_baru);
            $update = mysqli_prepare($koneksi, "UPDATE anggota SET password = ? WHERE id_anggota = ?");
            mysqli_stmt_bind_param($update, 'si', $password_hash, $id);
            if (mysqli_stmt_execute($update)) {
                $success = 'Password berhasil direset. Silakan login kembali.';
                $username = $email = '';
            } else {
                $error = 'Gagal menyimpan password baru. Coba lagi.';
            }
        } else {
            $error = 'Data siswa tidak ditemukan atau akun tidak aktif.';
        }
    }
}
?>

<div class="container-fluid vh-100">
    <div class="row h-100 justify-content-center align-items-center">
        <div class="col-lg-5 col-md-7">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold">Lupa Password</h2>
                        <p class="text-muted">Masukkan data yang terdaftar untuk mereset password.</p>
                    </div>

                    <?php if ($error): ?>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <?php echo $error; ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>

                    <?php if ($success): ?>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <?php echo $success; ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>

                    <form action="lupa-password.php" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required value="<?php echo htmlspecialchars($username); ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" required value="<?php echo htmlspecialchars($email); ?>">
                        </div>

                        <div class="mb-3">
                            <div class="alert alert-info" role="alert">
                                Reset password ini hanya untuk akun <strong>siswa</strong>.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password Baru</label>
                            <input type="password" name="password_baru" class="form-control" required minlength="6">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Konfirmasi Password Baru</label>
                            <input type="password" name="konfirmasi_password" class="form-control" required minlength="6">
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Reset Password</button>
                    </form>

                    <div class="text-center mt-3">
                        <p class="mb-0">Sudah ingat password? <a href="index.php">Kembali ke Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include 'includes/footer.php'; ?>
