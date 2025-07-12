# Copilot Instructions for "a riga di comando"

This is an Italian technical documentation site about command-line tools for data processing, built with MkDocs Material. The site focuses on CLI utilities for structured text files (CSV, JSON, XML) and serves as both a learning resource and reference guide.

## Project Architecture

**Documentation Structure**: The site follows a hierarchical organization under `docs/`:
- **Tool monographs** (`miller/`, `frictionless/`, `csvkit/`, etc.) - Deep dives into specific tools
- **Recipes** (`ricette/`) - Practical how-to guides with command examples
- **AI tools** (`ai/`) - Modern AI CLI utilities like LLM CLI
- **Data workflows** (`dati/`) - Generic data processing patterns
- **Utilities reference** (`utilities/`) - Comprehensive tool listing

**Content Patterns**: Each tool section typically includes:
- `index.md` - Introduction and installation
- `ricette.md` - Tool-specific recipes and examples
- Additional specialized pages (e.g., `verbi.md` for Miller commands)

**Navigation**: Defined in `mkdocs.yml` with Italian labels and organized by logical workflow rather than alphabetical order.

## Writing Conventions

**Language**: All content is in Italian. Use appropriate Italian technical terminology:
- "riga di comando" (command line), "utility" (tools), "ricette" (recipes)
- Maintain formal but accessible tone throughout

**Code Examples**: Always use tabbed code blocks with clear input/output separation:
```markdown
=== "comando"
    ```bash
    mlr --csv cat base.csv
    ```
=== "output"
    ```
    nome,dataNascita,altezza,peso
    ```
```

**File References**: Include sample data files in tool-specific `risorse/` directories. Reference them with relative paths like `[file](./risorse/base.csv)`.

**Admonitions**: Use Material's admonition syntax for important notes:
- `!!! warning "🚧 Pagina in costruzione"` for work-in-progress content
- `!!! info` for additional context
- `!!! note` for format-aware tool distinctions

## Content Development Workflow

**New Tool Documentation**:
1. Create tool directory under `docs/`
2. Add index page with installation and basic usage
3. Add to navigation in `mkdocs.yml`
4. Include in utilities listing with description and links
5. Add practical recipes with real-world examples

**Recipe Creation**: Focus on specific, actionable solutions with:
- Clear problem statement
- Complete command with explanation
- Expected output
- Notes about tool-specific behavior (format-aware vs. generic)

**Tagging**: Use YAML frontmatter tags for cross-referencing:
```yaml
tags:
  - paste
  - qsv
  - unire
  - colonne
```

## Build and Deploy

The site uses GitHub Actions (`.github/workflows/ci.yml`) for automated deployment:
- Builds on push to master branch
- Uses MkDocs Material with plugins for RSS, blog, and search
- Deploys to GitHub Pages via `mkdocs gh-deploy`

Required Python packages are installed in the workflow. For local development, install the same packages listed in the CI workflow.

**Work-in-Progress**: Use the include `--8<-- "includes/lavori_in_corso.md"` for pages under construction.

## Key Patterns to Follow

- **Tool Categories**: Distinguish between Unix-standard tools (cat, cut, grep) and specialized data tools (Miller, qsv, frictionless)
- **Format Awareness**: Always note when tools are "format aware" (understand CSV structure) vs. generic text processors
- **Real Examples**: Use concrete sample files rather than abstract examples
- **Cross-References**: Link between related tools and concepts extensively
- **Progressive Complexity**: Start with basic usage, then advance to complex workflows

When adding new content, follow the established Italian terminology and maintain the educational, practical focus that makes complex CLI tools accessible to Italian-speaking users.

## Note di output markdown

Si prega di rispettare la formattazione Markdown più standard per garantire la compatibilità e la leggibilità.

In particolare:

- Dopo ogni titolo (es. `# Titolo`, `## Sottotitolo`), inserire sempre una riga vuota.
- Dopo il carattere di un elenco numerato (es. `1.`, `2.`), inserire un solo spazio.
- Dopo il carattere di un elenco puntato (es. `-`, `*`), inserire un solo spazio.
- Dopo i due punti (`:`) che precedono un elenco puntato o numerato, inserire sempre una riga vuota.
