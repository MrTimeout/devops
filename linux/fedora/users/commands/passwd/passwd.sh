#!/bin/bash
# Source: https://www.redhat.com/sysadmin/managing-users-passwd

# We have more info and configuration files in the directory: /etc/pam.d/passw
# /etc/passwd | /etc/shadow | /etc/group

# Output format of "passwd --status $TARGET_USER"
# $TARGET_USER {password-status} {last-password-change} {minimum-days-to-change-password} {maximum-days-to-change-password} {warning-days-to-change-password} {inactive-days-after-password-expired} (Password set, unknown crypt variant.)
# Default: $TARGET_USER PS 2022-02-23 0 99999 7 -1 (Password set, unknown crypt variant.)

# The task of changing passwords of accounts in the system is achieved through calls to the
# Linux-PAM(Pluggable Authentication Modules) and libuser API.
TARGET_USER=ivan

$(awk -F ':' '{print $1}' /etc/passwd | grep -w -c "$TARGER_USER") -ge 1 && userdel $TARGET_USER

useradd $TARGET_USER

# The second column shows us the Password status:
#   PS = Password Set
#   LK = Password Locked
#   NP = No Password
# Same as passwd --status $TARGET_USER
passwd -S $TARGET_USER
passwd --status $TARGET_USER

# Output
# ivan PS 2022-02-23 0 99999 7 -1 (Password set, unknown crypt variant.)

# The -l option is used to lock the password of a specified account, and it is available to root
# only. The result is that the user cannot use the password to log in to the system but can use
# other means such as SSH public key authentication.
# If you create an user without password, it will be locked by default.
passwd -l $TARGET_USER
passwd --lock $TARGET_USER

# Output: passwd -S $TARGET_USER
# ivan LK 2022-02-23 0 99999 7 -1 (Password locked.)

# This option will unlock the password of an user with the password locked.
passwd -u $TARGET_USER
passwd --unlock $TARGET_USER

# We can delete the password of an account using -d/--delete on an account.
# passwd -d $TARGET_USER
passwd --delete $TARGET_USER

passwd -S $TARGET_USER
# Output:
# ivan NP 2022-02-23 0 99999 7 -1 (Empty password.)

# We can expire a password for an account. The user will be forced to change the password
# during the next login attempt.
# passwd $TARGET_USER # We have to set again the password previously to this setp
passwd -e $TARGET_USER
# passwd --expire $TARGET_USER
# Output:
# ivan PS 1970-01-01 0 99999 7 -1 (Password set, unknown crypt variant.)

# When we try to enter in the user ivan, it wil prompt to put our password two times (?) and
# then we have to change the password (we can't use our name in some form in the password)
# Output:
# [mrtimeout@fedora ~]$ su ivan
# Password:
# You are required to change your password immediately (administrator enforced).
# Current password:
# New password:
# Retype new password:

# We can set a minimum amount of days by the user cannot modify his password:
passwd -n 10 $TARGET_USER
passwd --minimum 10 $TARGET_USER

passwd --status $TARGET_USER
# Output:
# ivan PS 2022-02-23 10 99999 7 -1 (Password set, unknown crypt variant.)
# By default, the number of days is 0, so he can change the password whenever he wants.

# Set the maximum number of days a password remains valid. After MAX_DAYS, the password is 
# required to be changed. Maximum set default to 99999
passwd -x 90 $TARGET_USER
passwd --maximum 90 $TARGET_USER

passwd --status $TARGET_USER
# Output:
# ivan PS 2022-02-23 10 90 7 -1 (Password set, unknown crypt variant.)

# Set the number of days in advance the user will begin receiving warnings that the password
# will expire
passwd -w 7 $TARGET_USER
passwd --warnning 7 $TARGET_USER

passwd --status $TARGET_USER
# Output:
# ivan PS 2022-02-23 10 90 7 -1 (Password set, unknown crypt variant.)

# After inactive days, the user with an expired password can't access the account.
passwd -i 5 $TARGET_USER
passwd --inactive $TARGET_USER
# We expire the password of the user account
passwd -e $TARGET_USER
# We try to access the account after more than 5 days and we can't access (I guess that it is right)

# We can pass the user password by stdin
echo "thisisthepassword" | passwd --stdin $TARGET_USER
