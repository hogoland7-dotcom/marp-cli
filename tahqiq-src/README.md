# Thesis rebuild sources (backup)

Typst sources for rebuilding the thesis PDF (design-preserving, 15pt body).
Build: `python3 -c "import typst; typst.compile('main.typ', 'main.pdf', font_paths=['fonts'])"`
with `fonts/` containing Amiri-Regular/Bold/Italic/BoldItalic + AmiriQuran
(from https://github.com/aliftype/amiri).

Status: s08 (indexes + bib E1-7), s09 (bib E8-24), s10 (bib E25-31 + TOC) done.
s01-s07 await the re-uploaded original PDF.
