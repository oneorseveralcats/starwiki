# StarWiki

<img width="955" height="1045" alt="English Wikipedia entry opened in KoReader" src="https://github.com/user-attachments/assets/78f8408d-35f6-428c-ad23-acf6892a19b5" />

StarWiki is a project to create StarDict-formatted offline Wikipedia encyclopedias. The project uses
[mwoffliner](https://github.com/openzim/mwoffliner) to scrape Wikipedia articles, strip most
elements from them (so that only the summary section at the top of the page is left) and pack them
into a zim file. From there, [pyglossary](https://github.com/ilius/pyglossary) is used to convert
from Zim to StarDict format.

There are likely going to be some formatting issues with certain articles. I have fixed all that I
have seen but I haven't looked at anywhere near all the dictionary entries. Also, I am a native
English speaker with minimal second-language abilities so haven't really made use of the non-English
dictionaries here.

Dictionaries are either the top 1 million articles for a language or all articles if the language
has less than a million articles.

There are both compressed and uncompressed versions of the dictionaries. The compressed is much
smaller (English is 4x smaller at ~800MBs vs 3.8GBs), but requires more memory to use. If you're
using a larger dictionary with something like [Crosspoint Reader](https://crosspointreader.com/),
you will probably have to use the uncompressed version.

Dictionaries for currently generated languages:

| Language | Compressed | Uncompressed |
| --- | --- | --- |
| English | [en_1m](https://github.com/oneorseveralcats/starwiki/releases/latest/download/starwiki_en_1m.tar.gz) | [en_1m](https://github.com/oneorseveralcats/starwiki/releases/latest/download/starwiki_en_1m_uncompressed.tar.gz) |
| Esperanto | [eo_all](https://github.com/oneorseveralcats/starwiki/releases/latest/download/starwiki_eo_all.tar.gz) | [eo_all](https://github.com/oneorseveralcats/starwiki/releases/latest/download/starwiki_eo_all_uncompressed.tar.gz) |
| Toki Pona | [tok_all](https://github.com/oneorseveralcats/starwiki/releases/latest/download/starwiki_tok_all.tar.gz) | [tok_all](https://github.com/oneorseveralcats/starwiki/releases/latest/download/starwiki_tok_all_uncompressed.tar.gz) |
