# myvimrc
## Install Simple Guid
> **home** is user directory, substitute home on windows=%USERPROFILE% or on linux=~  
> you need run cmd in administrator and make sure git command available
1. mkdir home/.vim && mkdir home/.vim/bundle
2. install Vundle:  
    git clone https://github.com/VundleVim/Vundle.vim.git home/.vim/bundle/Vundle.vim
3. make link .vimrc to myvimrc.
   * git clone myvimrc, clone this repo.
   * linux: ln -s path_to_myvimrc/vimrc home/.vim/vimrc
   * windows: mklink home\.vimrc path_to_myvimrc\vimrc
4. open vim, run :PluginInstall

## Instruction
* mapleader is: **,**
* `Ctrl-r` map to :browse oldfiles。show the recent files
* `<leader>ss` 保存历史，下次打开用`<leader>rs`恢复
* `Ctrl-e` 打开explorer
* `<leader>i` indent(缩进)可视切换
