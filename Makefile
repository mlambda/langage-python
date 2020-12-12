build:
	docker run --rm -v "$(PWD):/langage-python" hugomougard/langage-python:1.0.0


.PHONY: build
