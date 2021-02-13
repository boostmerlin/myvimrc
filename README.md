# myvimrc
a vimrc used by me
## Install Simple Guid
插件管理使用vim-plug, 需要vim 8, 不再使用Vundle
> 可能需要为git设置http代理  
> git config --global http.https://github.com.proxy http://127.0.0.1:10809   
> git config --global https.https://github.com.proxy http://127.0.0.1:10809

1. install vim-plug, 参考 https://github.com/junegunn/vim-plug  
安装插件会创建相应文件夹
> 如果没有代理使用：https://gist.github.com/boostmerlin/8dea1ea50777d1ecb7484ff13dd05fb0

2. make link .vimrc to myvimrc.
   * git clone myvimrc, clone 本仓库.
   * mac: ln -s path_to_myvimrc/vimrc $HOME/.vim/vimrc
   * windows: mklink %USERPROFILE%\\.vimrc path_to_myvimrc\vimrc
3. open vim, run :PlugInstall

## Instruction

* mapleader is: **,**
* `F4` map to :browse oldfiles。show the recent files
* `<leader>ss` 保存历史，下次打开用`<leader>rs`恢复
* `Ctrl-e` 打开explorer
* `<leader>i` indent(缩进)可视切换
* 其它用法参数相应的插件

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
