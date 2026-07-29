with open("website/head.html", "r", encoding="utf-8") as head: html = head.read()
with open("README.md", "r", encoding="utf-8") as main: content = main.read()

html += content
html += """
</body>
</html>
"""

with open("_site/index.html", "w", encoding="utf-8") as web: web.write(html)
