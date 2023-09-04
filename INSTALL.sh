#!/bin/sh

yay -S so-git # Stack Overflow Queries
yay -S perf browsh gh

yay -S weechat # ranger is unneded (we already have an awesome file manager)

yay -S discordo
yay -S nodejs-mapscii

yay -S pipx
# pipx install textual-paint # PAINT in your terminal
pipx install tuir # Reddit

# See: https://seniormars.github.io/posts/neomutt/#motivation
# yay -Sy neomutt # an email client
# yay -Sy gnupg # TODO: Still in WIP.

yay -S discordo-git # Discord Client

# # Create a key and follow the instructions that are prompted:
# gpg --full-generate-key
#
# # Copy your public key:
# gpg --list-secret-keys --keyid-format=long
#
# # FIX: Unable to open mailbox /var/spool/mail/$USER
# sudo touch /var/mail/$USER
# sudo chown $USER:mail /var/mail/$USER
# sudo chmod 660 /var/mail/$USER

pipx install urlscan

# gh extension install dlvhdr/gh-dash # Octo is preferred over gh dash
