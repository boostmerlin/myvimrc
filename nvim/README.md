# Neovim 配置

基于 **LazyVim + lazy.nvim** 的个人 Neovim 配置，使用 Lua 按功能组织插件，并通过本机 JSON 配置选择语言和 AI 扩展。

[返回项目总览](../README.md)

## 目录结构

```text
nvim/
├── init.lua                  # 启动入口
├── samplecfg/                # 本机配置与 GUI 配置样例
└── lua/
    ├── config/               # 插件引导、基础选项、快捷键、性能设置
    ├── plugins/              # 补全、文件树、终端等插件配置
    │   └── extras/       # 按本机配置选择的语言与 AI 扩展
    └── workspace.lua         # 本机 JSON 配置的读取与保存
```

## 功能

- **界面与导航**：Snacks 启动页、最近文件、项目入口、侧边文件树和文件选择器。
- **补全**：定制 blink.cmp，添加 Emoji 补全、`Alt + 数字` 选择候选项和命令行补全。
- **编辑**：多光标、mini.surround 包围操作、which-key 快捷键提示。
- **终端**：选择已安装的 PowerShell、CMD、Bash、Zsh、Fish、Nu Shell，或输入自定义 Shell。
- **输入法**：检测可用的输入法切换工具，支持本机覆盖命令与目标输入法。
- **可选扩展**：Python 测试与调试、C++ 检查与调试适配器、GLSL 工具、Avante AI 辅助。

## 安装

先安装 Neovim 和 Git，并克隆仓库：

```sh
git clone https://github.com/boostmerlin/myvimrc.git
```

以下命令中的 `path_to_myvimrc` 是占位符，请替换为仓库的实际绝对路径。目标位置如已有配置，请先备份并移开。Windows 的 `mklink` 命令在 **CMD** 中执行，创建符号链接可能需要管理员权限或开发者模式。

Neovim 版本及其他工具要求需与所使用的 LazyVim 版本匹配。首次安装插件需要能够访问 GitHub。

将仓库的 `nvim` 目录链接到 Neovim 配置目录。

**Windows（CMD）：**

```bat
mklink /D "%LOCALAPPDATA%\nvim" "path_to_myvimrc\nvim"
```

**Windows（PowerShell）：**

```powershell
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "path_to_myvimrc\nvim"
```

**Linux / macOS（默认配置路径）：**

```sh
mkdir -p "$HOME/.config"
ln -s "path_to_myvimrc/nvim" "$HOME/.config/nvim"
```

启动 `nvim` 后，配置会在缺少 lazy.nvim 时自动下载它，再加载 LazyVim 和自定义插件。首次启动需要等待插件安装完成，可使用 `:Lazy` 查看插件状态、`:checkhealth` 检查环境。

## 本机配置

将 `samplecfg/workspace-nvim.sample.json` 复制到 `workspace-nvim.json`，再根据本机环境修改。例如：

```json
{
  "im_select": {
    "default_command": "im-select-mspy",
    "default_im_select": "2052-0"
  },
  "extras": ["python"],
  "font": "0xProto Nerd Font Mono:h11"
}
```

| 字段 | 用途 |
| --- | --- |
| `extras` | 选择 `extras` 下要加载的扩展：`python`、`cpp`、`glsl`、`ai`、`spell` |
| `im_select` | 指定输入法切换命令与目标输入法；样例值需按本机工具调整 |
| `font` | 在入口代码检测到 GUI 环境时设置字体，需自行安装相应字体 |
| `env` | 可选的键值对象，在读取配置时设置 Neovim 进程的环境变量 |

这个文件位于 **Neovim 配置目录**，用于区分不同机器的设置，不会自动从当前代码项目中读取。不提供 `extras` 时，自定义可选扩展列表为空。

修改后重启 Neovim。该文件被 Git 忽略，不会默认纳入版本管理。

## 可选扩展

通过 `workspace-nvim.json` 的 `extras` 数组选择，可以组合使用，例如 `["python", "cpp", "ai"]`。

| 扩展 | 仓库中的配置内容 |
| --- | --- |
| `python` | 导入 LazyVim 的 Python、DAP 和测试扩展，配置 neotest-python 与 Python 语法解析器 |
| `cpp` | 导入 clangd 与 CMake 扩展，配置 cpplint、`cppdbg` 及本机 C++ 工具链选项 |
| `glsl` | 配置 `glsl_analyzer` 工具安装与 vim-glsl 插件 |
| `ai` | 配置 Avante，以 GitHub Copilot 为提供方，附带图片粘贴、Markdown 渲染和补全源 |

这些文件是扩展配置，不保证包含完整开发工具链。相关功能还需按实际用途准备编译器、语言服务或调试配置。可通过 `:LazyExtras` 管理 LazyVim 的扩展选择。

AI 扩展需要完成插件构建，并在 Neovim 内执行 `:Copilot auth` 登录有相应使用权限的账号。配置指定读取代码项目根目录的 `avante.md` 作为指令文件，默认关闭自动建议。

## 常用快捷键

`<leader>` 表示空格。以下主要列出本仓库的自定义映射，其余快捷键由 LazyVim 提供。

| 快捷键 | 功能 |
| --- | --- |
| `<leader>e` / `<leader>E` | 打开或切换项目根目录 / 当前工作目录的文件树 |
| `<leader>je` | 在文件树中浏览当前文件所在目录 |
| `<leader>jb` / `<leader>jr` | 将工作目录切换到当前文件目录 / LazyVim 识别的项目根目录 |
| `<leader>fs` / `<leader>fS` | 选择 Shell / 查看当前 Shell 配置 |
| `<leader>fl` | 打开终端 |
| `<leader>mm` / `Ctrl+n` | 启动多光标编辑 |
| `gsa` / `gsd` / `gsr` | 添加 / 删除 / 替换包围符号 |
| `Alt+1` 至 `Alt+0` | 接受第 1 至第 10 个补全候选项 |
| `Tab` | 补全菜单可见时选择并接受候选项，否则回退到原按键行为 |

启用并加载 DAP 相关配置后，还提供以下调试映射：

| 快捷键 | 功能 |
| --- | --- |
| `F5` | 开始或继续调试 |
| `F9` | 切换断点 |
| `F10` / `F11` / `Shift+F11` | 单步跳过 / 进入 / 跳出 |
| `F8` / `Shift+F8` | 清除全部断点 / 清除当前文件断点 |

## 性能与 GUI 配置

- `lua/config/performance.lua` 默认禁用 Python、Node.js、Ruby 和 Perl 的 Neovim provider，以减少启动和探测开销。这些 provider 与外部语言服务器是不同机制；需要时可执行 `:EnablePython3`、`:EnableNode`、`:EnableRuby`、`:EnablePerl` 或 `:EnableAllProviders`。
- `lua/plugins/treesitter.lua` 从默认自动安装列表中移除多种语法解析器，实际列表还会受到已启用扩展的影响。
- `samplecfg/ginit.sample.vim` 提供 nvim-qt 样例；`config.sample.toml` 提供 Neovide 样例。两者需要按各自 GUI 的配置路径手动放置，具体路径见文件注释。

## 配置维护说明

- `lazyvim.json`、`lazy-lock.json`、`workspace-nvim.json`、`config.toml` 和 `ginit.vim` 被 Git 忽略。不同机器的扩展选择、插件版本和 GUI 设置可能不同。
- `lua/plugins/example.lua` 是参考模板，开头直接返回空配置，不会启用其中的示例插件。
- `complement.lua.nvim-cmp` 和 `explorer.lua.neo-tree` 保留了其他插件方案，当前使用的是对应的 `.lua` 配置文件。
- Python 测试配置中保留了 Windows 路径识别与输出乱码的说明；如使用该功能，请在本机验证。
