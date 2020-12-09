#!/usr/bin/env zsh

mkdir -p build
ln -fs "$PWD/img" "$PWD/build"
cp pandoc-theme/header.yml build/merged.md
(echo; cat docs/index.md) >> build/merged.md
for f in docs/[0-9]*(n); do
    echo >> build/merged.md
    cat "$f" >> build/merged.md
done
pandoc \
    --variable date="Version du `date +%d/%m/%Y`" \
    --number-sections \
    --standalone \
    --template pandoc-theme/default.latex \
    --toc \
    --toc-depth=2 \
    --highlight-style breezedark \
    --pdf-engine=xelatex \
    --from markdown+grid_tables+table_captions \
    --to latex \
    --output build/main.tex \
    --filter pandoc-theme/filter.py \
    --filter pandoc-secnos \
    --filter pandoc-fignos \
    build/merged.md
