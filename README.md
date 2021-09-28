# Install
See[doom emacs installation](https://github.com/hlissner/doom-emacs#install)

Then copy the configuration and install related packages :
```bash
rm -rf ~/.doom.d && git clone https://github.com/intoxx/doom-config ~/.doom.d && ~/.emacs.d/bin/doom sync
```

# Update
```bash
~/.emacs.d/bin doom upgrade && git pull ~/.doom.d origin
```
