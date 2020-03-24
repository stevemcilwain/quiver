# Releases

## 0.15

* Added qq-enum-mssql.zsh
* Added qq-enum-mysql.zsh
* Added qq-enum-oracle.zsh
* Added qq-enum-nfs.zsh
* Added qq-enum-pop3.zsh
* qq-srv.zsh: added 3 new listeners for tar, nc>file and b64

## 0.14 3/24/2020

* quiver.plugin.zsh: added zstyle tab autocompletion
** use qq-<tab> to search for commands across any namespace
* qq-install.zsh
** added jsbeautifier 
* qq-vars.zsh: set-output will now create the root directory if missing

## 0.12 3/22/2020

* qq-vars.zsh: Added global variables for the most common arguments, load and save
* qq-srv.zsh: added updog
* qq-project.zsh added folder scaffolding for projects / engagements
* qq-log.zsh integration with qq-vars
* Major change to output on all methods, uses $__OUTPUT as the directory from qq-vars.zsh
* Lot of minor changes

## 0.11 - 3/9/2020

* You can now specify a path to your markdown notes by setting $__NOTES
* qq-notes.zsh: notes search and display 
* qq-exploit.zsh: compilation helpers
* qq-enum-web-php: php specific enumeration such as lfi, rfi and scans
* minor fixes 

## 0.10 - 3/4/2020

* Added module: qq-enum-kerb.zsh for kerboros enumeration functions
* Added module: qq-enum-rdp.zsh for RDP enumeration functions
* Added module: qq-enum-smb.zsh for SMB enumeration functions
* Aded qq-debug to print ~/.quiver/log.txt 
* Fixed glow commands to not use pager, leaving the output available in the console window

## 0.9 - 3/4/2020

* Minor fixes and improvements
* Added scripts/recon.zsh
* Added qq-bounty for bug bounty helpers
* Added rescope to install script and qq-bounty
* Added qq-enum-ldap
* Removed noisy banner and log loading to ./quiver/log.txt
* Added qq-enum-ftp-notes-vsftp
* Added qq-custom.zsh module for your custom aliases and functions (ignored)
* Added .gitignore (for qq-custom.zsh)

## 0.8 - 2/25/2020

* qq-pivot: added ssh tunneling commands
* qq-log: added short aliases
* qq-enum-web: moved fuzzing to qq-enum-web-fuzz
* qq-enum-web-fuzz: added/grouped (not dirs) fuzzing commands
* qq-enum-web-xss: added XSS helpers
* qq-enum-web-ssl: added SSL commands and notes
* qq-aliases: better organization, added aliases for custom functions


