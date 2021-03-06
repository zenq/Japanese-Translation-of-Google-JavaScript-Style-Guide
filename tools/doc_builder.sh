#! /bin/sh

DOC_DIR=/usr/local/share/google_javascript_style_guide/doc/
HTML_DIR=${DOC_DIR}/_build/html/
WWW_DIR=/usr/share/nginx/html/data/google_javascript_style_guide/

echo "[START] `date '+%Y-%m-%d %H:%M:%S'`"
cd ${DOC_DIR}
echo "[PULL DOC]"
git pull
echo "[BUILD DOC]"
make html
perl -i -ple 'if (/__badcode__/) { s/(<span class="nx">)?__badcode__(<\/span>)?//; s/highlight-javascript/highlight-javascript gjsg_badcode/; }' _build/html/index.html
echo "[SYNC DOC]"
rsync -av ${HTML_DIR} ${WWW_DIR}
echo "[FINISH]"
