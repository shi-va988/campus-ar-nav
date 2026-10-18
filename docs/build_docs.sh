#!/usr/bin/env bash
# Build script to convert markdown report and slides into PDF and PPTX using pandoc
# Requirements: pandoc, wkhtmltopdf or LaTeX for PDF, libreoffice for pptx conversion (optional)

set -e
ROOT_DIR=$(dirname "$0")
cd "$ROOT_DIR"

REPORT_MD=final_report.md
SLIDES_MD=final_slides.md
OUT_DIR=build
mkdir -p "$OUT_DIR"

# Generate PDF of report using pandoc + wkhtmltopdf (if installed)
if command -v pandoc >/dev/null 2>&1; then
  echo "Generating PDF report via pandoc..."
  pandoc "$REPORT_MD" -o "$OUT_DIR/final_report.pdf" --pdf-engine=xelatex || true
else
  echo "pandoc not found; install pandoc to generate PDFs and PPTX"
fi

# Generate reveal.js HTML slides (pandoc) and PDF export
if command -v pandoc >/dev/null 2>&1; then
  echo "Generating reveal.js HTML slides..."
  pandoc "$SLIDES_MD" -t revealjs -s -o "$OUT_DIR/slides.html" --slide-level=2 || true
  echo "If you want PPTX, convert slides HTML via headless browser or use LibreOffice on exported HTML/PDF"
fi

echo "Build complete. Check $OUT_DIR for outputs (if pandoc was installed)."
