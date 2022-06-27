# Dependencies
- Emacs
- [Doom emacs](https://github.com/hlissner/doom-emacs#install).
- ripgrep (for a better project wide search with doom emacs, [see thread](https://www.reddit.com/r/DoomEmacs/comments/lsqnbg/comment/gosrxdd/?utm_source=share&utm_medium=web2x&context=3)).

# Install
```bash
rm -rf ~/.doom.d && git clone https://github.com/intoxx/doom-config ~/.doom.d && ~/.emacs.d/bin/doom sync
```

# Upgrade
```bash
git -C ~/.doom.d pull origin && ~/.emacs.d/bin/doom upgrade
```
