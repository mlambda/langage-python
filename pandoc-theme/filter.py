import panflute


admonitions = frozenset(["remarque", "conseils", "attention", "definition"])


def action(elem, doc):
    if isinstance(elem, panflute.Div) and elem.classes[0] in admonitions:
        return [
            panflute.RawBlock(r"\begin{%s}" % elem.classes[0], format="latex"),
            *elem.content,
            panflute.RawBlock(r"\end{%s}" % elem.classes[0], format="latex"),
        ]


def main(doc=None):
    doc = panflute.load()
    doc.walk(action, doc=doc)
    panflute.dump(doc)


if __name__ == "__main__":
    main()
