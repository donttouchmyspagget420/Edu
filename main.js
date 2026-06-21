let currentLang = 'en';
let langData = {};
let subjectsCache = {};

document.addEventListener('DOMContentLoaded', () => {
    currentLang = localStorage.getItem('edu_lang') || 'en';

    document.querySelectorAll('[data-page]').forEach(link => {
        link.addEventListener('click', e => {
            e.preventDefault();
            showPage(link.dataset.page);
        });
    });

    document.querySelectorAll('[data-lang]').forEach(item => {
        item.addEventListener('click', e => {
            e.preventDefault();
            setLang(item.dataset.lang);
        });
    });

    document.getElementById('back-to-subjects').addEventListener('click', () => {
        document.getElementById('themes-view').classList.add('d-none');
        document.getElementById('subjects-grid').classList.remove('d-none');
        document.getElementById('subjects-loading').classList.add('d-none');
    });

    document.getElementById('back-to-themes').addEventListener('click', () => {
        document.getElementById('topics-view').classList.add('d-none');
        document.getElementById('themes-view').classList.remove('d-none');
    });

    loadLang(currentLang).then(() => showPage('home'));
});

function loadLang(lang) {
    return fetch(`lang/${lang}.json`)
        .then(r => { if (!r.ok) throw new Error(); return r.json(); })
        .then(data => {
            langData = data;
            currentLang = lang;
            localStorage.setItem('edu_lang', lang);
            document.getElementById('currentLangLabel').textContent = lang.toUpperCase();
            applyTranslations();
            subjectsCache = {};
        })
        .catch(() => { if (lang !== 'en') return loadLang('en'); });
}

function setLang(lang) {
    loadLang(lang).then(() => {
        const s = document.getElementById('page-subjects');
        if (!s.classList.contains('d-none')) {
            resetSubjectsNav();
            loadSubjects();
        }
    });
}

function resetSubjectsNav() {
    document.getElementById('themes-view').classList.add('d-none');
    document.getElementById('topics-view').classList.add('d-none');
    document.getElementById('subjects-grid').classList.add('d-none');
    document.getElementById('subjects-loading').classList.remove('d-none');
}

function t(key) {
    return key.split('.').reduce((o, k) => o?.[k] ?? key, langData);
}

function applyTranslations() {
    document.querySelectorAll('[data-i18n]').forEach(el => {
        el.innerHTML = t(el.dataset.i18n);
    });
}

function showPage(page) {
    document.querySelectorAll('.page-section').forEach(s => s.classList.add('d-none'));
    document.getElementById(`page-${page}`).classList.remove('d-none');
    document.querySelectorAll('[data-page]').forEach(l => l.classList.remove('active'));
    document.querySelector(`[data-page="${page}"]`)?.classList.add('active');
    if (page === 'subjects') {
        resetSubjectsNav();
        loadSubjects();
    }
}

function api(path) {
    return fetch(`${path}&lang=${currentLang}`).then(r => r.json());
}

function loadSubjects() {
    const grid = document.getElementById('subjects-grid');
    const loading = document.getElementById('subjects-loading');

    if (subjectsCache[currentLang]) {
        renderSubjects(subjectsCache[currentLang]);
        return;
    }

    api('api.php?action=subjects').then(subjects => {
        subjectsCache[currentLang] = subjects;
        renderSubjects(subjects);
    });
}

function renderSubjects(subjects) {
    const grid = document.getElementById('subjects-grid');
    const loading = document.getElementById('subjects-loading');

    grid.innerHTML = subjects.map(s => `
        <div class="col-md-4">
            <div class="card subject-card h-100 border-0 shadow-sm" data-id="${s.id}" data-name="${s.name}">
                <div class="card-body text-center p-4">
                    <i class="bi ${s.icon} display-1 text-primary mb-3"></i>
                    <h5 class="card-title">${s.name}</h5>
                    <p class="card-text text-muted small">${s.description}</p>
                </div>
            </div>
        </div>
    `).join('');

    grid.querySelectorAll('.subject-card').forEach(card => {
        card.addEventListener('click', () => {
            loadThemes(card.dataset.id, card.dataset.name);
        });
    });

    loading.classList.add('d-none');
    grid.classList.remove('d-none');
}

function loadThemes(subjectId, subjectName) {
    document.getElementById('subjects-grid').classList.add('d-none');
    document.getElementById('themes-view').classList.remove('d-none');
    document.getElementById('theme-subject-name').textContent = subjectName;

    const grid = document.getElementById('themes-grid');
    const loading = document.getElementById('themes-loading');
    grid.innerHTML = '';
    loading.classList.remove('d-none');

    api(`api.php?action=themes&subject_id=${subjectId}`).then(themes => {
        grid.innerHTML = themes.map(t => `
            <div class="col-md-6 col-lg-4">
                <div class="card theme-card h-100 border-0 shadow-sm" data-id="${t.id}">
                    <div class="card-body p-4">
                        <h5 class="card-title">${t.name}</h5>
                        <p class="card-text text-muted small">${t.description}</p>
                    </div>
                </div>
            </div>
        `).join('');

        grid.querySelectorAll('.theme-card').forEach(card => {
            card.addEventListener('click', () => {
                const name = card.querySelector('.card-title').textContent;
                loadTopics(card.dataset.id, name);
            });
        });
        loading.classList.add('d-none');
    });
}

function loadTopics(themeId, themeName) {
    document.getElementById('themes-view').classList.add('d-none');
    document.getElementById('topics-view').classList.remove('d-none');
    document.getElementById('topic-theme-name').textContent = themeName;

    const list = document.getElementById('topics-list');
    const loading = document.getElementById('topics-loading');
    list.innerHTML = '';
    loading.classList.remove('d-none');

    api(`api.php?action=topics&theme_id=${themeId}`).then(topics => {
        list.innerHTML = topics.map((topic, i) => `
            <div class="card border-0 shadow-sm mb-3 topic-card">
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-lg-8 mb-3 mb-lg-0">
                            <h5 class="fw-bold">${topic.title}</h5>
                        </div>
                        <div class="col-lg-4 text-lg-end">
                            <a href="${topic.youtube_url}" target="_blank" class="btn btn-danger">
                                <i class="bi bi-youtube me-1"></i> ${t('watch')}
                            </a>
                        </div>
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#topic-${topic.id}" aria-expanded="false">
                            <i class="bi bi-chevron-down me-1"></i> ${t('subjects_page.show_explanation')}
                        </button>
                        <div class="collapse mt-3" id="topic-${topic.id}">
                            <div class="card card-body border-0 bg-light p-3">
                                <p class="mb-2">${topic.summary}</p>
                                ${topic.examples ? `<div class="mt-2 pt-2 border-top"><strong>${t('subjects_page.examples')}:</strong><p class="mb-0 mt-1 text-muted">${topic.examples}</p></div>` : ''}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `).join('');
        loading.classList.add('d-none');
    });
}
