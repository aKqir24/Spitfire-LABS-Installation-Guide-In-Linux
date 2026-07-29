SITE_DIR="_site/"
INDEX_SITE="${SITE_DIR}/index.html"

if [ -f LABS.dll.zip ]; then
    cp LABS.dll.zip "${SITE_DIR}"
fi
if [ -f website/style.css ]; then
    cp website/style.css "${SITE_DIR}"
fi

SUMMARY_TXT='<span class="large bold">'
BLOCKQUOTE_STYLE='<blockquote><i style="color: var(--primary);">'

sed -i \
    -e "s|.*NOTE|${BLOCKQUOTE_STYLE}info</i> ${SUMMARY_TXT}NOTE|g" \
    -e "s|.*TIP|${BLOCKQUOTE_STYLE}light</i> ${SUMMARY_TXT}TIP|g" \
    -e "s|.*WARNING|${BLOCKQUOTE_STYLE}warning</i> ${SUMMARY_TXT}WARNING|g" \
    -e "s|.*IMPORTANT|${BLOCKQUOTE_STYLE}info</i> ${SUMMARY_TXT}IMPORTANT|g" \
    -e 's|\(<a class="link" href="https://akqir24.github.io/Spitfire-LABS-Installation-Guide-In-Linux/">Check Out In Website</a>\)|</i>|g' \
    -e 's|<span><b>Or install wine-staging (recommended)</b></span>|<span><b>Or install wine-staging (recommended)</b><i>expand_more</i></span>|g' \
    "${INDEX_SITE}"
