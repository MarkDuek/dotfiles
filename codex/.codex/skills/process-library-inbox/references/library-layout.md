# Library Layout and Routing

## Live Sources

- Notes repository: `/home/mark/Resources/mark-notes/repo`
- Repository library: `03-resources/library`
- Drive root: `/home/mark/gdrive/03. Resources/Library`
- Drive inbox: `00-inbox`

Read before every run:

- `03-resources/library/conventions.md`
- `03-resources/library/kb.yaml`
- `03-resources/templates/`
- Each relevant collection `index.md`
- `03-resources/library/01-papers/all-papers.md`

The numbered layout below is authoritative. Live filesystem structure and
`kb.yaml` must agree with it; do not use legacy unnumbered collection aliases.

## Collections and IDs

| Resource | ID | Repository collection | Drive collection |
| --- | --- | --- | --- |
| Paper | `P####` | `01-papers` | `01-papers` |
| Book | `B####` | `02-books` | `02-books` |
| Standalone handwritten note | `N####` | `03-handwritten-notes` | `03-handwritten-notes` |
| Course note or lecture | `C####` | `04-course-notes` | `04-course-notes` |
| Standalone slide deck | `N####` | `05-slides` | `05-slides` |
| Miscellaneous resource | `N####` | `99-misc` | `99-misc` |
| Meeting note | `M####` | Follow live convention | Follow live convention |

IDs are global within their prefix and never reused.

## Routing Rules

- Paper: create `P####`; organize by venue and year.
- Book or ebook: create `B####`. Different formats and annotated editions of the
  same edition are variants under one book.
- Course note: create `C####` when the note represents a lecture or coherent
  course unit.
- Handwriting tied to a paper, book, or course note: add it as that parent's
  `handwriting` variant; do not create another ID.
- Standalone handwriting with independent knowledge value: create `N####` with
  type `handwritten-note`.
- Slides tied to a course note or other resource: add a `slides` variant to the
  parent. A reusable standalone deck receives `N####` with type `slides`.
- Supplements, datasets, images, answer keys, and alternate formats associated
  with an existing entity stay under that parent.
- Administrative or project-only files do not automatically belong in the
  reusable library. Leave ambiguous items in the inbox for confirmation.
- A reusable item that fits no specific collection receives `N####` in
  `99-misc`.

## Destination Shapes

Paper Markdown:

```text
repo/03-resources/library/01-papers/<venue>/<year>/P####.md
```

Paper binary:

```text
01-papers/<venue>/<year>/P####/P####.<ext>
```

Other Markdown:

```text
repo/03-resources/library/<collection>/<ID>.md
```

Other binaries:

```text
<collection>/<ID>/<ID>.<ext>
```

Variants share the entity folder:

```text
<ID>-annotated.pdf
<ID>-handwriting.pdf
<ID>-slides.pdf
<ID>-supplement.zip
<ID>.epub
<ID>.mobi
```

## Metadata Schemas

Use a live template when available. Preserve its key names and field order.

### Paper

Required core:

```yaml
id: P0000
type: paper
title: "Title"
authors: []
year:
venue:
volume:
issue:
pages:
status: unread
topics: []
files:
  canonical: 01-papers/venue/year/P0000/P0000.pdf
identifiers:
  doi:
  arxiv:
  url:
related: []
```

### Book

Required core:

```yaml
id: B0000
type: book
title: "Title"
authors: []
year:
edition:
publisher:
status: unread
topics: []
files:
  canonical: 02-books/B0000/B0000.pdf
identifiers:
  isbn:
  url:
related: []
```

### Course Note

Required core:

```yaml
id: C0000
type: course-note
title: "Title"
course:
institution:
term:
date:
status: raw
topics: []
files:
  canonical: 04-course-notes/C0000/C0000.pdf
related: []
```

### Standalone Handwriting, Slides, or Miscellaneous

Required core:

```yaml
id: N0000
type: handwritten-note
title: "Title"
date:
status: raw
topics: []
files:
  canonical: 03-handwritten-notes/N0000/N0000.pdf
related: []
```

Set `type` and collection path to `slides`/`05-slides` or
`misc`/`99-misc` as appropriate.

## Paper Indexes

```text
01-papers/
├── index.md
├── all-papers.md
└── <venue>/
    ├── index.md
    └── <year>/
        └── P####.md
```

Each venue index groups papers by year. Reuse existing venue slugs. Current
examples include `arxiv`, `cvpr`, `ieee-communications-letters`, and
`ieee-signal-processing-letters`.
