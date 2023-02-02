# DEPRECATED V1

Hi! If you're reading this it means you've stuck around using my config for a while. It's been a great honor to maintain this with you. Thank you!

A lot has changed in the world of development editors since in the past few years since I've been trying to keep this up to date. But most importantly, a lot has changed in my own ability to keep a high quality general purpose configuration around for public consumption.

TL;DR: This config, as a general purpose IDE is now deprecated. I have not been able to, and will no longer pretend to be able to, keep it fresh for every possible language you might work in. More importantly I am hereon advocating that you maintain your own config, or if you must use something off the shelf, find a more suitable alternative.

If you want to keep using this v1 config and get rid of the warning checkout the `v1.0` tag. But you should probably for the repo instead.

## What's changing with this repo?

This is now officially "Luan's config" not "distribution". The vim ecosystem does not need more distributions and this was never fully "marketed" as a general purpose one anyway. It just happened to become the de-facto standard set of tools we used while pairing on Cloud Foundry, but I have long left that community, and it's time I focus on maintaining this for myself.

More specifically:
- No more auto-updates. Anyone who uses this config is expected to pull the
repo to get new changes.
- I will add and change things here how ever I see fit. This is more than just
a benevolent dictatorship. This is just me keeping these as my personal
settings.
- I will most likely not accept contributions here unless they're fixing a bug
or adding something really cool (but if you do this, you should probably talk
to me first).

There will still be a way to provide user customizations. Mostly because I
need private hooks in order to use this at work, so if you fall into the
category of still wanting to use this, you could do that I guess.

## Why though?

Like I said above, I don't have the time or motivation to keep this generic. I
don't work directly with the users of this and I don't spent virtually any
time actively maintaining things here other than for my own needs or when
someone reaches out directly already. I don't have the inputs to keep
improving user experience.

## What should you use instead?

I have personally gotten a lot from knowing the ins and outs of my editor. I've even dabbled in VSCode a lot recently and made plugins/customizations for that. If you have the energy and interest, just set your own configuration up. I won't write down any specific recommendations for plugins here because that can get stale, but Neovim is likely to still be the best Vim when you read this. Also go to /r/neovim, there's lots of good stuff there all the time. And learn lua.

If you don't have the time or interest to do that, I recommend looking into a popular config. LunarVim is at the time of writing a solid config that works well for a lot of cases, and it's well documented. NvChad is another good one. But do your research. I also heard great things about Doom Emacs, it defaults to using vim bindings, don't worry.

You can also try out GUI editors, VSCode is solid and easy, JetBrain's stuff is incredibly powerful. There's nothing wrong with using those things.

Finally, and if you got this far into this long-winded doc it's possible you really like me, you're welcome to use this config. I won't block you. And I will do my best to make it stable (for my own sake and sanity really). If you do that and have any problems I'll be happy to try to help, but I expect you are very motivated to figure things out on your own at this point.

