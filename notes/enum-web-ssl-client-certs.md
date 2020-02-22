# Creating Client Certificates

## Create key with csr
```bash
openssl req -newkey rsa:4096 -keyout <user key> -out <user csr> -nodes -days 365 -subj "/CN=<name>"
```

## Sign CSR wtih CA
```bash
openssl x509 -req -in <user csr> -CA <ca cert> -CAkey <ca key> -out <signed user cert> -set_serial 01 -days 365
```

## Convert to pkcs12 for use in browsers as client certificate
```bash
openssl pkcs12 -export -clcerts -in <signed user cert> -inkey <user key> -out <user>.p12
```