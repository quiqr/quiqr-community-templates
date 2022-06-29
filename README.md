# EMBGIT

Embgit is an minimal git client made in go. It's main goals are:

- fat binary, dependancy free
- support for all main platforms
- clone, add, commit, push
- use ssh-keys for identification

Embgit is a [Quiqr](https://quiqr.org) project.

<a href="https://quiqr.org"><img src="https://book.quiqr.org/logo-nav.svg" width=150 /></a>

# Usage
NAME:
   embgit - A new cli application

USAGE:
   embgit [global options] command [command options] [arguments...]

COMMANDS:
   alladd        alladd
   clone         complete a task on the list
   commit        commit
   fingerprint   get fingerprint from ssl key pair
   keygen        create passwordless ssl key pair (RSA)
   keygen_ecdsa  create passwordless ssl key pair (ECDSA needed for GitHub)
   push          push to remote
   version       display version
   help, h       Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h  show help (default: false)

## Build

make build

## Cross platform builds

go get github.com/mitchellh/gox

make buildx

## Release info

Edit ```const version``` in ```main.go```

```
GITHUB_TOKEN=xxxxx make release
```

