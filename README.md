# Auto Welcome Back Mod
This mod is [hzgaming.net](https://hzgaming.net/) server-related mod. It is intended to greets people automatically on `/f` channel when they log in.

In order to avoid greeting again family members if they just relogging, there is a 5 minutes cooldown. If the family member logged out in last 5 minutes then the mod will not greet him/her/they again.

## Installation
1. Download and put `autowb.lua` file into your [moonloader](https://www.blast.hk/threads/13305/) directory.
2. Restart your game or reload LUA files.

## Usage
Everything works using chat commands:
- `/autowb`: toogle auto welcome back (enable or disable). Default: *enabled*
- `/autowbfn`: welcome back only with first name instead of full name. Default: *enabled*
- `/autowbshort`: say `wb *name*` instead of `Welcome back *name*`. Default: *disabled*
- `/autowbhelp`: show the help message

**Note:** Preferences is only stored on memory. If you reload your game, these preferences will be reset.

## Contributions
Feel free to tell any bugs on issue, or push requests if you made some cool improvements.

## Credits
This mod is an improvement of the initial work of **Akagami Y. Sumiyoshi** on Yakuza Discord.
