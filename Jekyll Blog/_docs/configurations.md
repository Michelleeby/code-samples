---
layout: default
---

# Configuration Settings

## Plugins
- [Jekyll Google API Generator](#Jekyll-Google-API-Generator)

### Jekyll Google API Generator

```yaml
jekyll_google_api_generator:
  api_key: "YOUR-API-KEY"
  spreadsheet_id: "YOUR-SPREADSHEET-ID"
  sheets_to_fetch:
    - title: "Sheet Title"
      range: "A:Z"
    - title: "Another Sheet Title"
      range: "A:AA"
  output_dir: "PATH-TO-OUTPUT"
```