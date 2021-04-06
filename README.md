# Luan's Neovim distribution (alpha)

This Vim distribution is a re-write of
[luan/vimfiles](https://github.com/luan/vimfiles) with the goal of break free
from the original [vim](https://www.vim.org) and focus on supporting
[Neovim](https://neovim.io).  Neovim is a faster moving project that is much
more approachable for contributions.

If you're familiar with [luan/vimfiles](https://github.com/luan/vimfiles) and
want to know what has noticeably changed, try `:help vimfiles-migrating` (or
just `:help migrating`). You can view that help file online
[here](https://github.com/luan/nvim/blob/master/doc/migrating-from-legacy.txt).

## ALPHA disclaimer

This is currently an experiment to discover more efficient key mappings that
are 1) more discoverable and 2) more efficient. The goal is to end up with a
1.0 version of the config that will then be stable and ultimately faster.

While we undergo this experiment I want to caution you against using this if
you're not OK with having to fix some issues as you work. I will be glad to
assist you if I am available.

If this does not scare you away, or if you still want to help, I'd like to
encourage you to try this config and provide as much feedback as you can with
regards to features and bugs. Also think about how the new mappings affect you
carefully. Muscle memory from an old config may cause a little pain at first,
but we're shooting for a better end result here.

## Why a new repo?

The old repo may still be used by people stuck in the original vim for some
reason, so breaking that compatibility could be frustrating for them.

Furthermore, I feel like some of the decisions made with regards to keybindings
on the other repo need to be updated. Having a completely new fork makes it so
users have to intentionally transition, giving them the change to realize that
some things have changed.

## Installation

This config is exclusive to [Neovim](https://neovim.io), so you need to [install
it](https://github.com/neovim/neovim/wiki/Installing-Neovim) on your system
first. You also need python and the [python 3 client for
Neovim](https://github.com/neovim/python-client) installed(python 3 is
important). Those are well documented processes and are platform dependent. At
the moment I don't intend to provide an all-in-one installer as part of this
config as we used to have on luan/vimfiles.

**Dependencies**: We'll need a few extra things installed in your system in
order to properly setup everything:

  * [`curl`](https://curl.haxx.se/): used to install the plugin manager.
  * [`npm`](https://www.npmjs.com/): used to install JS tools and some language
    server binaries.
  * [`ripgrep`](https://github.com/BurntSushi/ripgrep): superfast grep
    replacement used by the search plugins.
  * [`fd`](https://github.com/sharkdp/fd): superfast fd replacement used
    by the file finding plugins.
  * [`bat`](https://github.com/sharkdp/bat):  A cat(1) clone with syntax
    highlighting and Git integration.
  * [`tmux`](https://github.com/tmux/tmux/wiki): used for terminal multiplexing

Once you have that setup, all you have to do is clone this config in the right
spot:

```bash
git clone https://github.com/luan/nvim ~/.config/nvim
```

Plugins will be automatically downloaded and setup as necessary.

## Updating

The distribution checks for updates on boot and every hour when it's running.
The check is non-disruptive and will only show messages passively when one of
the following is true:

* An update is available (and you should run `:ConfigUpdate` or
  `:ConfigUpdate!`).
* An error occurred fetching the remove version.
* You have local changes on your nvim config repo (you really shouldn't unless
  you're preparing a PR).

`:ConfigUpdate` updates the local config and you can also `:ConfigUpdate!` to
update *and* force run the post-update hooks.

## Customizing

In the config directory there's a special folder that is git ignored, that is
`$XDG_CONFIG_HOME/nvim/user`, it is created on first boot based on the
`user.defaults` on in this repo. The three hooks are:

* `user/before.vim`: Runs before everything, useful to set globals that change
  plugin behavior
* `user/plug.vim`: Runs during plugin setup, you can add your own choices of
  plugins here. More on adding plugins
  [here](https://github.com/junegunn/vim-plug)
* `user/after.vim`: Runs at the end, useful to override and map your own key
  bindings and configure your custom plugins. This is also where you'd change
  the colorscheme

It is recommended that you track your user settings on a separate repo and
symlink them in here, see [my dotfiles
repo](https://github.com/luan/dotfiles/tree/master/nvim/.config/nvim/user) for
an example.

### Options

  - `g:autosave`: add a `let g:autosave = 1` to your `user/before.vim` to enable
    autosaving.

## Troubleshooting

In the event things behave incorrectly or the config becomes unstable in
general, regular vim debugging methods apply. Check `:checkhealth` for clues on
what's wrong with your setup.

Make sure language servers are installed for your language;
`:ConfigInstallLanguageServers` installs a few that aren't automatically managed
by other plugins (this should have happened automatically but it is sometimes good
to make sure it runs successfully).

Sometimes plugin authors make backwards incompatible changes or push changes in
ways that confuse [vim-plug](https://github.com/junegunn/vim-plug). A simple way
to reset your plugin installation and start over is to remove them from the
load path in `~/.local/share/nvim/plugged` which can be run with
`:ConfigResetAllPluginsReallyDoIt!`.
