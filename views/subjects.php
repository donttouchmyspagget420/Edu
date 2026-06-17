<section id="page-subjects" class="page-section d-none">
  <h2 class="fw-bold mb-2"><i class="bi bi-collection me-2"></i><span data-i18n="subjects_page.heading">Subjects</span></h2>
  <p class="text-muted mb-4" data-i18n="subjects_page.themes_explain">Each subject is divided into themes — focused topics that break down the material into manageable parts. Click any subject below to explore its themes.</p>

  <div id="subjects-loading" class="text-center py-5">
    <div class="spinner-border text-primary" role="status"><span class="visually-hidden" data-i18n="subjects_page.loading">Loading...</span></div>
  </div>
  <div id="subjects-grid" class="row g-4 d-none"></div>

  <div id="themes-view" class="d-none">
    <button class="btn btn-outline-secondary mb-3" id="back-to-subjects"><i class="bi bi-arrow-left me-1"></i><span data-i18n="subjects_page.back_subjects">Back to Subjects</span></button>
    <h3 id="theme-subject-name" class="fw-bold mb-3"></h3>
    <div id="themes-loading" class="text-center py-5 d-none">
      <div class="spinner-border text-primary" role="status"><span class="visually-hidden" data-i18n="subjects_page.loading">Loading...</span></div>
    </div>
    <div id="themes-grid" class="row g-4"></div>
  </div>

  <div id="topics-view" class="d-none">
    <button class="btn btn-outline-secondary mb-3" id="back-to-themes"><i class="bi bi-arrow-left me-1"></i><span data-i18n="subjects_page.back_themes">Back to Themes</span></button>
    <h3 id="topic-theme-name" class="fw-bold mb-3"></h3>
    <div id="topics-loading" class="text-center py-5 d-none">
      <div class="spinner-border text-primary" role="status"><span class="visually-hidden" data-i18n="subjects_page.loading">Loading...</span></div>
    </div>
    <div id="topics-list"></div>
  </div>
</section>
