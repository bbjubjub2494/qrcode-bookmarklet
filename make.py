#!/usr/bin/env python3
import string, urllib.parse

with open('template.html') as f:
    lines = f.readlines()
for i, l in enumerate(lines):
    lines[i] = l.strip()
i = lines.index("// qrcode.min.js HERE")
with open('qrcodejs/qrcode.min.js') as f:
    lines[i] = f.read()
document = ''.join(lines)

URL_UNSAFE = {'#', '?', ' ', '\t'}
URL_SAFE= set(string.printable) - URL_UNSAFE
url = 'data:text/html,' + urllib.parse.quote(document, safe=''.join(URL_SAFE))
with open("URL", "w") as out:
    out.write(url)
