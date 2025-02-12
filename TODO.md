# TODO

- [x] Fix Atuin on Linux
- [x] Install 1P on Linux
- [ ] Install op to manage secrets on remote
- [ ] Try Homebrew/brewfile on Linux

  - https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f
  - Consider that you need other packages: cargo, mas, it might be better to use your script. You can actually use mas in a brewfile.

- [ ] Use ZSH consistently
- [ ] Install Monaspace nerdfont

A neat idea might be a tool that lets you write a package file with:

```
brew pckg1
mas pckg2
apt pckg3
cargo pckg4
```

And also keeps immutable records at every update.
