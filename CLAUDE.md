# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

"a riga di comando" (arigadicomando.it) is an Italian documentation site focused on command-line tools for working with structured data (CSV, JSON, etc.). The site documents tools like Miller, Frictionless, GDAL/OGR, csvkit, xsv, Nushell, and AI CLI tools.

## Key Commands

**Build and deploy:**
```bash
mkdocs serve  # Local development server
mkdocs gh-deploy --force  # Deploy to GitHub Pages
```

**Install dependencies:**
```bash
pip3 install mkdocs-material markdown mkdocstrings mkdocs-rss-plugin mkdocs-click mkdocs-table-reader-plugin pillow cairosvg
```

## Architecture

**MkDocs Material site with:**
- `mkdocs.yml` - Main configuration with navigation structure
- `docs/` - All documentation content (76+ markdown files)
- `overrides/` - Custom theme overrides
- `blog/` - Blog posts with RSS feed
- `script/` - Utility scripts
- `.github/workflows/` - CI/CD for auto-deployment to GitHub Pages

**Content structure:**
- Monographic sections for major tools (Miller, Frictionless, GDAL/OGR, etc.)
- AI section covering LLM CLI tools (llm, ttok, MarkItDown)
- Data processing sections (explore, convert, transform, describe)
- Recipe collection for common CLI tasks

**Language:** All content is in Italian

**Deployment:** Automatic via GitHub Actions on push to master

## Content Guidelines

- All documentation is written in Italian
- Code examples use triple backtick fenced blocks with language identifiers
- Use Material for MkDocs features: admonitions, tabs, emoji shortcodes
- File paths in examples use Linux conventions
- Focus on practical CLI examples for data processing workflows
