export default class starWiki {
  async postProcessPage(pageTitle, doc) {
    let selectors = [
      "figure",
      "header",
      "link",
      "meta",
      "noscript",
      "script",
      "style",
      "title",

      "a#top",
      "div.hatnote",
      "div.thumb",

      "#mwoffliner-jsConfigVars",
      ".catlinks",
      ".ext-phonos",
      ".infobox",
      ".mw-empty-elt",
      ".mw-file-element",
      ".sidebar",
      ".vertical-navbox",

      // check Kurdish_language
      ".preview-warning"
    ];

    let elements = doc.querySelectorAll(`${selectors}`);

    elements.forEach(element => {
      element.remove();      
    });

    doc.documentElement.className = '';
    doc.body.className = '';

    return doc
  }
}
