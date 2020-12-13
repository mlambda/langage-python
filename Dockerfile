FROM python:3.9.1-slim-buster

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    locales \
    && echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    curl \
    fontconfig \
    latexmk \
    pandoc \
    python3-dev \
    texlive \
    texlive-lang-french \
    texlive-science \
    texlive-xetex \
    unzip \
    zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o fonts.zip "https://fonts.google.com/download?family=Fira%20Sans|Fira%20Mono" \
    && unzip fonts.zip -d ~/.fonts \
    && fc-cache -v -f \
    && pip install pandoc-fignos pandoc-secnos 'panflute < 2'

WORKDIR /langage-python

COPY Makefile-docker .

ENTRYPOINT [ "make", "-f", "Makefile-docker" ]
