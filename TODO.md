## Distrobox

- [ ] Ensure distrobox is set up automatically on relevant systems (Atomic Desktops)
- [ ] Ensure docker-compose is installed and configured automatically inside distrobox

## Zellij

- [ ] Install Zellij autolock and zellij.vim
- [~] Create Zellij plugin for custom command menu; takes commands from kdl, and
  lists them in bar
- [ ] [Install zjstatus](https://github.com/dj95/zjstatus) to make zellij header
      and footer rows more compact

## Zsh

- [~] Shorten hostnames to two chars on all computers
- [~] PS1 - Indicate whether the terminal is in a container
- [~] PS1 - If logged into root, replace $ with # (if not already), then
  consider removing username
- [ ] [Try Nushell](https://www.nushell.sh/) as a replacement of zsh
- [ ] Instead of using `<C-c>` to interrupt, use `<C-x>`, so `<C-c>` can be used
      to copy

## Writing

[Implement suggestions from this blogpost](https://nickjanetakis.com/blog/vim-is-saving-me-hours-of-work-when-writing-books-and-courses)

- [~] `set lazyredraw` and `set regexpengine=1`
- [~] Install [Vim Markdown](https://github.com/preservim/vim-markdown)
- [ ] Install [Fastfold](https://github.com/Konfekt/FastFold)

Add visual first-line indentation to Neovim

- [ ] Try using `:set breakindent` and `:set breakindentopt=shift:-4`. This
      works, except relies on adding a left-margin on the first line, which I don't
      believe is possible.
- [ ] [Render markdown.vim](https://github.com/MeanderingProgrammer/render-markdown.nvim) could be used for this purpose, using the `paragraph.indent` option
- [ ] [Check this thread](https://old.reddit.com/r/neovim/comments/1leak8d/is_visual_firstline_indentation_possible_in/)

## Git

- [ ] Try delta as git diff handler
- [ ] Make a custom command to search COMMIT_MSG contents in lazygit `git log --all --grep="TMS#a5898"` (I can't believe this isn't a feature)

## jrnl

- [ ] Write Zellij plugin to indicate the amount of time since the journal was
      last updated
