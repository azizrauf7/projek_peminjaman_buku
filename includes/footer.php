    <script src="<?php echo isset($base_url) ? $base_url : ''; ?>assets/js/bootstrap.bundle.min.js"></script>
    <script src="<?php echo isset($base_url) ? $base_url : ''; ?>assets/js/script.js"></script>
    <script>
        // Toggle Sidebar untuk Siswa Mobile
        function toggleSidebar() {
            const sidebarDiv = document.querySelector('body > .d-flex > div:first-child');
            if (sidebarDiv && sidebarDiv.classList.contains('d-flex')) {
                // Wrap sidebar jika belum
                if (!sidebarDiv.closest('.sidebar-wrapper')) {
                    const wrapper = document.createElement('div');
                    wrapper.className = 'sidebar-wrapper';
                    sidebarDiv.parentNode.insertBefore(wrapper, sidebarDiv);
                    wrapper.appendChild(sidebarDiv);
                }
            }
            const sidebar = document.querySelector('.sidebar-wrapper');
            if (sidebar) {
                sidebar.classList.toggle('active');
            }
        }
        
        // Close sidebar saat klik link
        document.querySelectorAll('.siswa-page .nav-link').forEach(link => {
            link.addEventListener('click', function() {
                const sidebar = document.querySelector('.sidebar-wrapper');
                if (sidebar && window.innerWidth <= 768) {
                    sidebar.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>