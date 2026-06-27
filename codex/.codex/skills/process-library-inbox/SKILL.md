---
name: process-library-inbox
description: Process files dropped into Mark's Google Drive library inbox, including papers, books, handwritten notes, course notes, slides, and miscellaneous resources. Use when asked to process, organize, ingest, classify, or empty the library inbox; extract and verify metadata; detect duplicates and variants; assign global resource IDs; create canonical Markdown records; route files into typed collections; update indexes; or validate an inbox migration.
---

# Process Library Inbox

Turn unclassified inbox files into canonical library resources while preserving
Markdown as the metadata source of truth.

## Ground the Run

1. Read `references/library-layout.md`.
2. Read the live conventions, configuration, applicable templates, and
   collection indexes listed there. Prefer live conventions when they differ
   from the reference.
3. Inspect Git status and preserve unrelated or user-authored changes.
4. Inventory the inbox without changing it. If it is empty, report that and
   stop.
5. Detect conflicts between configuration, metadata paths, and actual folders
   before ingestion. Report a blocking conflict rather than extending an
   inconsistent layout.
6. Use the numbered collections declared in `kb.yaml`; do not fall back to
   legacy unnumbered collection names.

## Classify Before Moving

Classify each item as a paper, book, course note, handwritten note, slide deck,
miscellaneous resource, or variant/supporting file of an existing entity. Follow
the routing rules in `references/library-layout.md`.

Do not classify from a filename alone. Inspect file metadata and content using
appropriate read-only tools:

- PDF: `pdfinfo`, `pdftotext`, and OCR when required.
- EPUB/MOBI: ebook metadata and title/copyright pages when supported.
- DOCX/PPTX: document properties and extracted OOXML text.
- Images/scans: EXIF and OCR when useful.
- Other formats: MIME-specific metadata and a safe preview.

Ask for confirmation only when content, ownership, or parent association remains
ambiguous after inspection.

## Check Identity and Metadata

1. Compute SHA-256 for every inbox file. Compare against the typed library and
   other inbox files. Never create a second entity for an exact duplicate.
2. Determine whether a file is a canonical entity, another format of the same
   entity, or an annotated/handwritten/supplementary variant. Variants belong to
   their parent and do not receive a new ID.
3. Extract intrinsic metadata appropriate to the resource type. Keep missing
   values empty; never invent facts.
4. For published works, verify metadata against authoritative primary sources:
   publisher/DOI metadata, arXiv, official proceedings, or ISBN catalog data.
5. Infer topics conservatively from titles, abstracts, headings, or keywords.
   Use lowercase kebab-case.
6. Use the status supplied by the user. Default papers and books to `unread` and
   notes to `raw` when status is not supplied.
7. Leave unresolved items in the inbox and report the exact missing decision.

## Assign IDs and Create Records

1. Enumerate canonical records recursively for the chosen namespace.
2. Allocate the next unused global ID only after identity, duplicate, parent,
   and metadata checks succeed. IDs are permanent and never reused.
3. Use the applicable live template. When none exists, use the minimal schema in
   `references/library-layout.md`.
4. Keep metadata intrinsic. Resource records may link to related resources but
   do not point back to PARA projects.
5. Keep citation data structured; do not add a formatted citation property.
6. Store binary paths relative to the configured Drive library root.
7. Refuse to overwrite an existing record or destination.

## Place Files

Follow the type-specific destinations in `references/library-layout.md` and
preserve original extensions.

For a variant, use the parent ID plus a suffix such as `-annotated`,
`-handwriting`, `-slides`, `-supplement`, or a format label. Update the parent
record's file metadata instead of creating another record.

Record the source hash, move the file, and verify the destination hash. If
verification fails, restore or preserve the inbox source and report the failure.

## Update Navigation

1. Add the record to its collection index.
2. For papers, maintain the all-papers index, venue index, and one index per
   venue with papers grouped by year.
3. Keep entries sorted by ID unless a live convention specifies another order.
4. Update the migration manifest when the live system still uses it.

## Validate and Report

Validate before declaring success:

- Markdown filenames agree with IDs.
- IDs are unique within each global namespace.
- Metadata follows the applicable template or minimal schema.
- Every canonical and variant path resolves.
- Destination paths agree with type-specific metadata.
- Destination hashes equal inbox hashes.
- Updated index links resolve and each item appears once.
- `git diff --check` passes.
- Failed or ambiguous items remain safely in the inbox.

Do not delete legacy duplicates, commit Git changes, or reorganize unrelated
resources unless explicitly requested. Report processed IDs, classifications,
destinations, metadata sources, variants, unresolved items, validation results,
and whether changes are uncommitted.
