
require('dashboard').setup({

  theme = 'doom', -- Use the 'doom' theme for a layout similar to your screenshot
  config = {
  header={

"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"                                                             /)                              ",
"                                                   /\\___/\\ ((                              ",
"                           |\\__/,|   (`\\            \\`@_@'/  ))                               ",
"                          _.|o o  |_   ) )           {_:Y:.}_//                                ",
"                         -(((---(((------------------{_}^-'{_}-------                          ",
"                        ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄                           ",
"                        █  █  █ █       █       █  █ █  █   █  █▄█  █                         ",
"        |\\__/,|   (`\\ █   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █  _._     _,-'\"\"`-._   ",
"        |_ _  |.--.) )  █       █   █▄▄▄█  █ █  █       █   █       █ (,-.`._,'(       |\\`-/|",
"        ( T   )     /   █  ▄    █    ▄▄▄█  █▄█  █       █   █       █     `-.-' \\ )-`( , o o)",
"        (((^_(((/(((_/ █ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █          `-    \\`_`\"'-",
"                        █▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█                         ",
"                     |\\      _,,,---,,_               /\\_/\\           ___               ",
"               ZZZzz /,`.-'`'    -.  ;-;;,_        = o_o =_______    \\ \\            ",
"                     |,4-  ) )-,_. ,\\ (  `'-'        __^      __(  \\.__) )            ",
"                     '---''(_/--'  `-'\\_)          (@)<_____>__(_____)____/              ",
"",
"",
"",
"",
"",
"",
"",
"",
"",
},
    center = {
      {
        icon = '  ',
        desc = 'Find File                   ',
        key = 'f',
        action = 'Telescope find_files'
      },
      {
        icon = '  ',
        desc = 'New file                    ',
        key = 'e',
        action = 'enew'
      },
      {
        icon = '  ',
        desc = 'Recent files                ',
        key = 'r',
        action = 'Telescope oldfiles'
      },
      {
        icon = '󰊄  ',
        desc = 'Find text                   ',
        key = 't',
        action = 'Telescope live_grep'
      },
      {
        icon = '  ',
        desc = 'Configuration               ',
        key = 'c',
        action = 'edit ~/.config/nvim/init.lua'
      },
      {
        icon = '  ',
        desc = 'Update Plugins              ',
        key = 'u',
        action = 'PackerSync'
      },
      {
        icon = '󰩈  ',
        desc = 'Quit Neovim                 ',
        key = 'q',
        action = 'qa'
      },
    },
    footer = { "v0.9.0 and 36 Plugins" },
  },
})
