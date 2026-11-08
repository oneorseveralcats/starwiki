# StarWiki

StarWiki is a project to create StarDict-formatted offline Wikipedia encyclopedias. The project uses
[mwoffliner](https://github.com/openzim/mwoffliner) to scrape Wikipedia articles, strip most
elements from them (so that only the summary section at the top of the page is left) and pack them
into a zim file. From there, [pyglossary](https://github.com/ilius/pyglossary) is used to convert
from Zim to StarDict format.

There are likely going to be some formatting issues with certain articles. I have fixed all that I
have seen but I haven't looked at anywhere near all the dictionary entries. Also, I am an English
speaker so haven't really made use of the non-English dictionaries here.

Dictionaries are either the top 1 million articles for a language or all articles if the language
has less than a million articles.

Dictionaries for currently generated languages:

| Language | Compressed | Uncompressed |
| --- | --- | --- |
| English | [en_1m](https://github.com/oneorseveralcats/starwiki/releases/download/english/starwiki_en_1m.zip) | [en_1m](https://github.com/oneorseveralcats/starwiki/releases/download/english/starwiki_en_1m_uncompressed.zip) |
| Esperanto | [eo_all](https://github.com/oneorseveralcats/starwiki/releases/download/esperanto/starwiki_eo_all.zip) | [eo_all](https://github.com/oneorseveralcats/starwiki/releases/download/esperanto/starwiki_eo_all_uncompressed.zip) |
| Toki Pona | [tok_all](https://github.com/oneorseveralcats/starwiki/releases/download/toki_pona/starwiki_tok_all.zip) | [tok_all](https://github.com/oneorseveralcats/starwiki/releases/download/toki_pona/starwiki_tok_all_uncompressed.zip) |
