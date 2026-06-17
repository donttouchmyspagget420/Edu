# JenylOku

Educational platform that organizes knowledge into subjects → themes → topics with summaries and YouTube video links. Built as a single-page app with multilingual support (English, Russian, Kazakh).

## Dependencies

| Software | Version |
|----------|---------|
| PHP | 8.0+ |
| MariaDB / MySQL | 10.4+ |
| Bootstrap | 5.3.3 (CDN) |
| Bootstrap Icons | 1.11.3 (CDN) |

No package manager or build step required — everything runs via a web server with PHP and MariaDB.

## Setup

1. Place files in your web root (e.g. `/opt/lampp/htdocs/web/`)
2. Make sure MariaDB is running
3. Visit `install.php` in your browser to create the database and seed data
4. Open `index.php` to start browsing

## Structure

```
├── index.php          # App shell (navbar, footer, includes views)
├── install.php        # Runs db.sql to create DB + seed data
├── db.sql             # Schema + all seed data in 3 languages
├── config.php         # Database connection
├── api.php            # JSON API (lang-aware)
├── main.js            # Client logic (SPA nav, API calls, translations)
├── style.css          # Custom styles
├── lang/              # Static UI translations (en, ru, kk)
│   ├── en.json
│   ├── ru.json
│   └── kk.json
└── views/             # PHP partials for each page section
    ├── home.php
    ├── subjects.php
    └── about.php
```

## Authors

- **Alyia70** — ideas & product manager/owner
- **dont** — idea & requirements
- **opencode** (big-pickle) — implementation
