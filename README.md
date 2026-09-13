# myvimrc

个人 Vim 系列编辑器配置，包含 **Vim / GVim、Neovim 和 JetBrains IdeaVim** 三套配置，用于统一常用编辑习惯，并配置文件导航、搜索、补全、终端和调试工具。

| 配置 | 适用环境 | 实现方式 |
| --- | --- | --- |
| `vimrc` | Vim / GVim | Vimscript + vim-plug |
| `nvim/` | Neovim | Lua + LazyVim + lazy.nvim |
| `ideavimrc` | JetBrains IDE | IdeaVim 配置与 IDE 原生动作映射 |

三套配置可以独立使用，不需要全部安装。快捷键尽量保持相近，但不完全一致。

## 目录结构

```text
myvimrc/
├── README.md      # 项目总览、Vim / GVim 与 IdeaVim 使用说明
├── vimrc          # Vim / GVim 配置
├── ideavimrc      # JetBrains IdeaVim 配置
└── nvim/          # Neovim 配置与独立 README
```

## 安装准备

先安装目标编辑器和 Git，并克隆仓库：

```sh
git clone https://github.com/boostmerlin/myvimrc.git
```

以下命令中的 `path_to_myvimrc` 是占位符，请替换为仓库的实际绝对路径。目标位置如已有配置，请先备份并移开。Windows 的 `mklink` 命令在 **CMD** 中执行，创建符号链接可能需要管理员权限或开发者模式。

## Neovim

安装、功能、本机配置和快捷键见 [Neovim 使用指南](nvim/README.md)。

## Vim / GVim

### 安装

该配置按 Vim 8 环境编写，Markdown 预览部分注明需要 Vim 8.1 或更高版本。

1. 按 [vim-plug 安装说明](https://github.com/junegunn/vim-plug) 将插件管理器安装到 Vim 的 autoload 目录。
2. 将仓库中的 `vimrc` 链接到用户配置位置。
3. 启动 Vim，执行 `:PlugInstall` 安装插件。

**Windows（CMD）：**

```bat
mklink "%USERPROFILE%\.vimrc" "path_to_myvimrc\vimrc"
```

**Linux / macOS：**

```sh
mkdir -p "$HOME/.vim"
ln -s "path_to_myvimrc/vimrc" "$HOME/.vim/vimrc"
```

文件内容搜索使用 CtrlSF，配置指定了 `ag`（The Silver Searcher），需额外安装并加入 `PATH`。配置还使用 `~/.vim/undo_dir` 和 `~/.vim/view` 保存编辑状态，使用前请确保目录存在。

### 功能与快捷键

包含 NERDTree 文件树、CtrlP 文件查找、CtrlSF 内容搜索、EasyMotion 跳转、多光标、注释、包围操作、Git 状态、撤销历史和 Markdown 预览。

`<leader>` 为空格，`<localleader>` 为逗号。

| 快捷键 | 功能 |
| --- | --- |
| `<leader>e` / `<leader>E` | 切换文件树 / 在文件树中定位当前文件 |
| `<leader>ff` / `<leader>fb` / `<leader>fm` | 混合文件查找 / 缓冲区查找 / 最近文件查找 |
| `Ctrl+f` 后按 `f` / `c` / `t` | 输入内容搜索 / 搜索光标下单词 / 切换搜索窗口 |
| `F4` | 浏览最近打开的文件 |
| `<leader>i` | 切换缩进可视化 |
| `s`、`f`、`F`、`t`、`T` | EasyMotion 快速跳转 |
| `Ctrl+n` | 多光标选择 |
| `<leader>ru` | 打开或关闭撤销历史窗口 |
| `<leader>ft` | 在底部打开终端 |
| `F8` / `Ctrl+F8` | 开始 / 停止 Markdown 预览 |
| `g0` | 切换相对行号 |

`vimrc` 顶部的 `s:code_monkey` 默认为 `0`，因此 ALE、coc.nvim 和受条件控制的 UltiSnips 配置默认不启用。需要这些功能时，将开关改为 `1`，并补齐相应依赖。

## JetBrains IdeaVim

安装 JetBrains IDE 的 IdeaVim 插件后，将 `ideavimrc` 放置或链接为用户目录下的 `.ideavimrc`。

仓库现有安装说明使用 Windows（CMD）：

```bat
mklink "%USERPROFILE%\.ideavimrc" "path_to_myvimrc\ideavimrc"
```

配置启用 surround、commentary、EasyMotion、多光标、参数与缩进文本对象、which-key 等能力；部分能力还需在 IDE 中安装对应扩展。

`<leader>` 为空格，常用映射如下：

| 快捷键 | 功能 |
| --- | --- |
| `<leader>ff` / `<leader>fr` | 查找文件 / 最近文件 |
| `<leader>fl` | 在项目视图定位当前文件 |
| `<leader>cr` / `<leader>rr` | 重命名代码元素 / 重命名文件 |
| `<leader>d` / `<leader>c` | 调试 / 停止 |
| `<leader>b` | 切换行断点 |
| `<leader>gb` / `<leader>gh` | Git 行注释 / 文件历史 |
| `<leader>o` | 显示文件结构 |
| `/` / `g/` | 使用 IDE 搜索 / 使用 Vim 搜索 |
| `Ctrl+o` / `Ctrl+i` | IDE 导航后退 / 前进 |
| `g0` | 切换相对行号 |

## 配置维护说明

- Vim 会话保存与恢复的路径目前不一致：保存使用 `~/.vim/my.vim`，而 `<leader>ql` 从 `~/my.vim` 恢复。使用会话恢复前需统一路径。
