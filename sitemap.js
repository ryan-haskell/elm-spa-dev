// generates my sitemap
const path = require('path')
const fs = require('fs')

var listFilesInDirectory = function(dir, filelist) {
  var path = path || require('path');
  var fs = fs || require('fs'),
      files = fs.readdirSync(dir);
  filelist = filelist || [];
  files.forEach(function(file) {
      if (fs.statSync(path.join(dir, file)).isDirectory()) {
          filelist = listFilesInDirectory(path.join(dir, file), filelist);
      }
      else {
          filelist.push(path.join(dir, file));
      }
  });
  return filelist;
};

const markdownPaths = (fp) =>
  listFilesInDirectory(fp)
    .map(a => a.substr(fp.length).split('.md')[0])

const base = `https://www.elm-spa.dev`
const urls =
  [ '/'
  , '/docs'
  , ...markdownPaths(path.join(__dirname, 'public', 'content', 'docs')).map(a => `/docs${a}`)
  , '/guide'
  , ...markdownPaths(path.join(__dirname, 'public', 'content', 'guide')).map(a => `/guide${a}`)
  ]

fs.writeFileSync(path.join(__dirname, 'public/dist/sitemap.xml'),
  `<?xml version="1.0" encoding="UTF-8"?>
  <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    ${urls.map(url => `<url><loc>${base}${url}</loc></url>`).join('\n    ')}
  </urlset> `
)


