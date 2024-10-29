# myvimrc
a vimrc used by me
## Install Simple Guid
插件管理使用vim-plug, 需要vim 8
> 可能需要为git设置http代理  
> git config --global http.https://github.com.proxy http://127.0.0.1:10809   
> git config --global https.https://github.com.proxy http://127.0.0.1:10809

1. install vim-plug, 参考 https://github.com/junegunn/vim-plug  
安装插件会创建相应文件夹
> 如果没有代理使用：https://gist.github.com/boostmerlin/8dea1ea50777d1ecb7484ff13dd05fb0

2. make link .vimrc to myvimrc.
   * git clone https://github.com/boostmerlin/myvimrc.git, clone 本仓库.
   * mac, linux: ln -s path_to_myvimrc/vimrc $HOME/.vim/vimrc
   * windows: mklink %USERPROFILE%\\.vimrc path_to_myvimrc\vimrc
3. open vim, run :PlugInstall

## ideavimrc

windows: mklink %USERPROFILE%\.ideavimrc path_to_myvimrc\ideavimrc
linux: unused yet
mac: unused yet

## nvim
see nvim/README.md

## Instruction

* mapleader is: **space**
* `F4` map to :browse oldfiles。show the recent files
* `<leader>qs` 保存历史，下次打开用`<leader>ql`恢复
* `<leader>e[E]` 打开explorer
* `<leader>i` indent(缩进)可视切换
* s like flash, 增强f,F,t,T

## configuation
### ctrlsf.vim
依赖ag, 需要安装:  
windows:  
* choco install ag  
* winget install "The Silver Searcher"

mac:  
* brew install the_silver_searcher

more: https://github.com/ggreer/the_silver_searcher

### markdown preview
注意：  
vim >= 8.1
