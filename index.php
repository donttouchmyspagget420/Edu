<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JenylOku - Explore & Learn</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link href="style.css" rel="stylesheet">
</head>

<body class="d-flex flex-column min-vh-100">
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top shadow-sm">
    <div class="container">
      <a class="navbar-brand fw-bold" href="#"><i class="bi bi-mortarboard-fill me-2"></i>EduLearn</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item"><a class="nav-link active" href="#" data-page="home" data-i18n="nav.home">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="#" data-page="subjects" data-i18n="nav.subjects">Subjects</a></li>
          <li class="nav-item"><a class="nav-link" href="#" data-page="about" data-i18n="nav.about">About</a></li>
        </ul>
        <div class="dropdown">
          <button class="btn btn-sm btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
            <i class="bi bi-globe me-1"></i><span id="currentLangLabel">EN</span>
          </button>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="#" data-lang="en">English</a></li>
            <li><a class="dropdown-item" href="#" data-lang="ru">Русский</a></li>
            <li><a class="dropdown-item" href="#" data-lang="kk">Қазақша</a></li>
          </ul>
        </div>
      </div>
    </div>
  </nav>

  <main id="page-content" class="flex-grow-1">
    <div class="container py-4">
      <?php include 'views/home.php'; ?>
      <?php include 'views/subjects.php'; ?>
      <?php include 'views/about.php'; ?>
    </div>
  </main>

  <footer class="bg-dark text-white text-center py-3 mt-auto">
    <small>&copy; 2026 EduLearn. <span data-i18n="footer">All rights reserved.</span></small>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="main.js"></script>
</body>

</html>
