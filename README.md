# Luan's Neovim distribution (alpha)

This Vim distribution is a re-write of
[luan/vimfiles](https://github.com/luan/vimfiles) with the goal of break free
from the original [vim](https://www.vim.org) focus on supporting
[Neovim](https://neovim.io).  Neovim is a faster moving project that is much
more approachable for contributions.

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
first. You also need python and the [python client for
Neovim](https://github.com/neovim/python-client) installed. Those are well
documented processes and are platform dependent. At the moment I don't intend to
provide an all-in-one installer as part of this config as we used to have on
luan/vimfiles.

Once you have that setup, all you have to do is clone this config in the right
spot:

```bash
git clone https://github.com/luan/nvim ~/.config/nvim
```

Plugins will be automatically downloaded and setup as necessary.

## Updating

The distribution auto-updates daily (or after a reboot of the system), if you
have trouble with auto-updating or want to disable it for other reason add the
following to you `user/before.vim`:

```
let g:skip_autoupdate = 1
```

This distribution uses [vim-plug](https://github.com/junegunn/vim-plug) to
manage plugins, it also uses vim-plug to manage itself. So you can run
`:PlugUpdate` anytime to update all plugins and the distribution itself.
Whenever updating, if anything has changed, it is recommended that you restart
all instances of Neovim to reload plugins and configurations.

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
