# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

"a riga di comando" (arigadicomando.it) is an Italian documentation site focused on command-line tools for working with structured data (CSV, JSON, etc.). The site documents tools like Miller, Frictionless, GDAL/OGR, csvkit, xsv, qsv, Nushell, and AI CLI tools.

## Key Commands

```bash
mkdocs serve              # Local dev server at http://127.0.0.1:8000
mkdocs gh-deploy --force  # Manual deploy to GitHub Pages
```

```bash
pip3 install mkdocs-material markdown mkdocstrings mkdocs-rss-plugin mkdocs-click mkdocs-table-reader-plugin pillow cairosvg
```

## Agent Operating Rule

- Non eseguire build o serve locali del sito (`mkdocs build`, `mkdocs serve`) salvo richiesta esplicita dell'utente.
- Aggiornare `CHANGELOG.md` in modo breve e user-oriented ogni volta che ci sono cambiamenti significativi.

## Architecture

- `mkdocs.yml` — Main config. The `nav:` section defines the full site navigation tree. Adding or moving pages requires editing this file.
- `docs/` — All markdown content. Each tool monograph lives in its own subdirectory (e.g., `docs/miller/`, `docs/frictionless/`).
- `docs/blog/posts/` — Blog posts (each in its own subfolder with an `index.md`). Authors defined in `docs/blog/.authors.yml`.
- `overrides/main.html` — Site-wide announcement banner.
- `.github/workflows/ci.yml` — Auto-deploys to GitHub Pages on push to `master`.

This file (CLAUDE.md) is excluded from the built site via `exclude_docs` in mkdocs.yml.

**Deployment:** Automatic via GitHub Actions on push to `master`.

## Content Guidelines

- All content is written in **Italian**
- Code examples use fenced blocks with language identifiers (` ```bash `, ` ```csv `, etc.)
- Available MkDocs Material features: admonitions, tabs (`pymdownx.tabbed`), emoji shortcodes, code annotations, content copy buttons, Mermaid diagrams, MathJax, task lists
- File paths in examples use Linux conventions
- Focus on practical CLI examples for data processing workflows
