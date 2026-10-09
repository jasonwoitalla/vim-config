# IntelliJ IDEA + IdeaVim

Install **IdeaVim** from **Settings > Plugins > Marketplace**, restart if prompted,
and enable **Tools > Vim**. No additional Vim plugins are required. Java/Kotlin
navigation, imports, formatting, and completion use IntelliJ's native support.

## Load the configuration

Open or create `~/.ideavimrc` and add:

```vim
source ~/.config/nvim/external-keymaps/intellij/ideavimrc
```

Use the absolute path to your checkout if it is elsewhere. If you already have
mappings for the same keys, remove them or source this file after them so these
bindings win. Back up your existing configuration before replacing it.

Alternatively, copy the contents of [`ideavimrc`](ideavimrc) into `~/.ideavimrc`.
Do not source `init.lua`: IdeaVim reads Vimscript, not Neovim Lua.

Reload from the editor's Vim command line:

```vim
:source ~/.ideavimrc
```

The configuration uses `<Action>(...)` to call native IDE actions. Those mappings
deliberately use `nmap`, `xmap`, and `imap`, because IdeaVim does not support
`<Action>` on the right-hand side of `noremap`.

## Native editor settings

In **Settings** (called Preferences in some macOS versions):

| Area | Setting |
| --- | --- |
| Editor > Code Style > Java/Kotlin > Tabs and Indents | Disable **Use tab character**; set **Tab size**, **Indent**, and **Continuation indent** to your preferred project style. Use 2 for Tab size/Indent to match `init.lua`; project conventions can override this. |
| Editor > Code Style | Disable **Detect and use existing file indents for editing** if you want to force the configured indentation rather than infer it from files. |
| Editor > General > Soft Wraps | Disable soft wraps to match `wrap=false`. |
| Editor > General > Smart Keys | Keep native paired-bracket/quote insertion enabled. |
| Editor > General > Code Completion | Enable **Show suggestions as you type**. |
| Tools > Actions on Save | Enable **Reformat code**, choose whole-file formatting to match Neovim, and scope it to the languages/files you want formatted. |
| Editor > Inspections > Proofreading | Enable spelling/typo inspections and the appropriate English dictionary if desired. |

Keep **Optimize imports** on save disabled unless you separately want it:
`init.lua` formats on save but does not explicitly organize imports. IntelliJ's
formatting and inspection rules remain the source of truth. Indentation is
configured through IntelliJ's Code Style settings, not unsupported IdeaVim
`expandtab`/`tabstop`/`shiftwidth` options.

Actions on Save are project settings. Configure them for each existing project;
use **File > New Projects Setup > Settings for New Projects** for future projects.
IntelliJ autosaves, so formatting may run on autosave as well as an explicit save.

## Language shortcuts

See the [shared reference](../README.md#language-navigation-and-actions) for the
complete table. In particular:

| Keys | Native behavior |
| --- | --- |
| `gra` | Show intention actions/quick fixes; choose **Import class** on an unresolved type |
| `gri` | Go to implementation |
| `grr` | Find usages |
| `grn` | Rename with IntelliJ's refactoring support |
| `grt` | Go to type declaration |
| `gO` | File structure popup |
| `K` | Hover documentation/error information |
| `Ctrl-Space` (Insert) | Basic Completion |
| `Ctrl-s` (Insert) | Parameter Info |

Wait for project indexing and configure the project's JDK/build import before
expecting these commands to work. Vim emulation does not replace IntelliJ's
language engine.

## Conflicts and differences

The config routes `Ctrl-h/j/k/l/d/u` to IdeaVim in Normal mode and
`Ctrl-Space`/`Ctrl-s` to its action mappings in Insert mode. **Ctrl-s in Insert
mode shows parameter help instead of saving.** Use `:w`, Save All, or `Cmd-s` on
macOS to save. Other modes retain the configured IDE shortcut for `Ctrl-s`.

If a shortcut still invokes an IDE action, inspect **Settings > Editor > Vim**
and choose the Vim handler for that key/mode. On macOS, `Ctrl-Space` may be
captured by the input-source shortcut; change it in **System Settings > Keyboard
> Keyboard Shortcuts > Input Sources** if necessary.

`Ctrl-h/j/k/l` move between editor splits, not tool windows. Use the normal IDE
shortcut or click the editor to return from the terminal/project tree. `-` and
`Space pv/pb` reveal the current file in Project rather than reproducing Oil.

If an action ID is unavailable in your IDEA version, look it up with:

```vim
:actionlist intention
:actionlist hover
:actionlist split
```

You can also run **IdeaVim: track action IDs** from Search Everywhere, invoke the
native action, and use the reported ID in your mapping. Test the action directly
with `:action ShowIntentionActions` to distinguish a language/indexing problem
from a mapping conflict.

See [compatibility notes and smoke checks](../README.md#intentional-differences)
and the [IdeaVim documentation](https://github.com/JetBrains/ideavim).
