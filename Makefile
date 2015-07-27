DOCS=$(shell find ./ -name '*.docx' | sed 's|\.docx|\.md|g')

%.md : %.docx
	pandoc --to markdown_github -o $@ $<

to_markdown: $(DOCS)

clean:
	rm $(DOCS)

default: to_markdown
