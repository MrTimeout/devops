# passwd command

## Configuration files of interest

`/etc/passwd`, `/etc/shadow`, `/etc/group` and `/etc/pam.d/passwd`

## Format of status of passwd

```sh
> sudo passwd --status $TARGET_USER

$TARGET_USER {password-status} {last-password-change} {minimum-days-to-change-password:-0} {maximum-days-to-change-password:-99999} {warning-days-before-expire:7} {inactive-days-after-password-expired:-1} (method to encrypt) # extended version of schema

user -S date -n -x -w -i (method to encrypt) # Simplified version of schema
```

Password status can be:

- __LK__ -> Password Locked
- __NP__ -> No Password
- __PS__ -> Password Set

## Options params

- `-S/--status`
- `-l/--lock`
- `-u/--unlock`
- `-d/--delete`
- `-e/--expire`
- `-n/--minimum`
- `-x/--maximum`
- `-w/--warning`
- `-i/--inactive`
- `--sdtin`