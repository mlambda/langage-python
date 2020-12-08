all:
	mkdir -p build
	ln -fs "$(PWD)/img" "$(PWD)/build"
	cp pandoc-theme/header.yml build/merged.md
	(echo; cat docs/index.md) >> build/merged.md
	cd docs && find . -regex ".*[0-9]+.*" -print0 | sort -zg | xargs -0I {} sh -c "(echo; cat {}) >> ../build/merged.md"
	pandoc \
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

.PHONY: all
