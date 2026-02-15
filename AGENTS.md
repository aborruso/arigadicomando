# Repository Guidelines

## Project Structure & Module Organization
- `docs/`: primary Markdown content for the MkDocs site (Italian documentation).
- `mkdocs.yml`: site configuration and navigation.
- `overrides/`: custom theme overrides for Material for MkDocs.
- `docs/assets/`, `docs/images/`, `docs/javascripts/`, `docs/stylesheets/`: static assets.
- `script/`: utility scripts used by maintainers.
- `site/`: generated site output (do not edit by hand).

## Build, Test, and Development Commands
- `mkdocs serve`: run the local dev server with live reload.
- `mkdocs gh-deploy --force`: publish the site to GitHub Pages.
- `pip3 install mkdocs-material markdown mkdocstrings mkdocs-rss-plugin mkdocs-click mkdocs-table-reader-plugin pillow cairosvg`: install required Python dependencies.
- `mkdocs build`: build locale del sito.

## Agent Operating Rule
- Non eseguire build o serve locali del sito (`mkdocs build`, `mkdocs serve`) salvo richiesta esplicita dell'utente.
- Aggiornare `CHANGELOG.md` in modo breve e user-oriented ogni volta che ci sono cambiamenti significativi.

## Coding Style & Naming Conventions
- Content is written in Italian; keep terminology consistent with existing pages.
- Use Markdown with fenced code blocks and language identifiers (e.g., ```bash).
- Prefer kebab-case for new filenames and paths under `docs/` (e.g., `dati/trasforma.md`).
- Keep examples CLI-focused and use POSIX paths.

## Testing Guidelines
- No automated tests are defined in this repository.
- Validare con build/serve locale solo se richiesto esplicitamente dall'utente.

## Commit & Pull Request Guidelines
- Recent commits use short, descriptive Italian sentences; there is no strict conventional format. Use an imperative tone and be specific (avoid generic “update”).
- PRs should include:
  - A clear summary of what changed and why.
  - Links to related issues or discussions when applicable.
  - Screenshots or a brief note on visual changes if you modified styles or layout.

## Security & Configuration Tips
- Keep `mkdocs.yml` in sync with new pages to avoid broken navigation links.
- Do not edit `site/` directly; it is generated output.
- If you add plugins or extensions, document the dependency in this file and ensure local setup stays simple.
