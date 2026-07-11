<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($title) ? $title : 'PerpusDigi'; ?></title>
    <link rel="stylesheet" href="<?php echo isset($base_url) ? $base_url : ''; ?>assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?php echo isset($base_url) ? $base_url : ''; ?>assets/css/style.css">
</head>
<body<?php echo isset($_SESSION['role']) && $_SESSION['role'] == 'siswa' ? ' class="siswa-page"' : ''; ?>>
    <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'siswa'): ?>
    <button class="btn-toggle-sidebar toggle-sidebar d-md-none" onclick="toggleSidebar()">
        <span>☰ Menu</span>
    </button>
    <style>
        .toggle-sidebar {
            display: none;
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 1001;
            background-color: #0d6efd;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
        }
        .toggle-sidebar:hover {
            background-color: #0b5ed7;
        }
    </style>
    <?php endif; ?>