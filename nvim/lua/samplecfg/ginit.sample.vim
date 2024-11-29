" Windows: %LOCALAPPDATA%\nvim\ginit.vim
" MacOS: ~/.config/nvim/ginit.vim
" Linux: ~/.config/nvim/ginit.vim

set mouse=a

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont 0xProto Nerd Font Mono:h11
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif