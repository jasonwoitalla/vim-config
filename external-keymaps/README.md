# Neovim-style bindings in other editors

These configurations mirror [`init.lua`](../init.lua) using Vim emulation for
editing and native editor commands for navigation, search, and language features.
They are standalone configurations, not automatically generated from `init.lua`.

| Editor | Setup guide | Configuration |
| --- | --- | --- |
| IntelliJ IDEA | [IdeaVim setup](intellij/README.md) | [ideavimrc](intellij/ideavimrc) |
| VS Code | [VSCodeVim setup](vscode/README.md) | [settings.json](vscode/settings.json), [keybindings.json](vscode/keybindings.json) |

## Shared bindings

`<leader>` is **Space**. Type sequences one key at a time: `<leader>ff` means
Space, f, f. Unless marked otherwise, bindings apply in Normal mode, with focus
in the code editor. They do not apply inside terminals, search boxes, or the
project tree.

| Binding | IntelliJ IDEA | VS Code |
| --- | --- | --- |
| `-`, `<leader>pv`, `<leader>pb` | Reveal current file in Project | Reveal current file in Explorer |
| `<leader>a` | Select entire buffer in Visual mode | Select entire buffer in Visual mode |
| `<leader>/` (Normal/Visual) | Toggle line comments | Toggle line comments |
| `<leader>t` | Activate Terminal tool window | Create a new integrated terminal |
| `Ctrl-h/j/k/l` | Focus left/down/up/right editor split | Focus left/down/up/right editor group |
| `H`, `L` | Previous/next editor tab | Previous/next tab in current group |
| `<leader>bd` | Close active editor tab | Close active editor tab |
| `<leader>sv`, `<leader>sh` | Split right / split below | Split right / split below |
| `<leader>ff` | Go to File | Quick Open |
| `<leader>fs` | Find in Files | Search across files |
| `<leader>F` | Reformat Code | Format Document |
| `>` / `L` (Visual) | Indent and reselect | Indent selected lines |
| `<` / `H` (Visual) | Outdent and reselect | Outdent selected lines |
| `J`, `K` (Visual) | Move selected lines down/up | Move selected lines down/up |
| `Ctrl-d`, `Ctrl-u` | Half-page scroll, then center | Half-page scroll, then center |
| `n`, `N` | Next/previous search result, center and unfold | Next/previous search result, center and unfold |
| `Esc` | Clear Vim search highlights | Clear Vim search highlights |
| `Ctrl-Space` (Insert) | Basic Completion | Trigger Suggest |

## Language navigation and actions

The `gr` bindings below mirror Neovim's built-in LSP defaults, even though they
are not explicitly declared in `init.lua`. No Neovim LSP server is used in either
IDE: IntelliJ uses its own language analysis; VS Code uses the installed language
providers. Features depend on the language, project configuration, and completed
indexing.

| Binding | Meaning | IntelliJ action | VS Code command |
| --- | --- | --- | --- |
| `gra` (Normal/Visual) | Code actions, including missing-import fixes | `ShowIntentionActions` | `editor.action.codeAction` |
| `gri` | Go to implementation | `GotoImplementation` | `editor.action.goToImplementation` |
| `grn` | Rename symbol | `RenameElement` | `editor.action.rename` |
| `grr` | Find references/usages | `FindUsages` | `editor.action.referenceSearch.trigger` |
| `grt` | Go to type definition | `GotoTypeDeclaration` | `editor.action.goToTypeDefinition` |
| `gO` | Document symbols / file outline | `FileStructurePopup` | `workbench.action.gotoSymbol` |
| `K` (Normal) | Hover documentation | `ShowHoverInfo` | `editor.action.showHover` |
| `Ctrl-s` (Insert) | Signature/parameter help | `ParameterInfo` | `editor.action.triggerParameterHints` |
| `[d`, `]d` | Previous/next diagnostic | `GotoPreviousError`, `GotoNextError` | `editor.action.marker.prev`, `editor.action.marker.next` |
| `gd` | Go to definition | `GotoDeclaration` | `editor.action.revealDefinition` |

`gd` is an explicit convenience addition, not a custom mapping in `init.lua`.
`[d` and `]d` mirror Neovim's diagnostic navigation. IntelliJ may prioritize
diagnostics according to its inspection/navigation settings rather than exactly
matching Neovim's severity ordering.

**Imports:** put the cursor on an unresolved symbol and press `gra`, then choose
the import fix. This opens the broader code-action menu, not a dedicated import
picker. To clean up existing imports, use IntelliJ's **Optimize Imports** or VS
Code's **Organize Imports** command. Neither config automatically organizes
imports on save.

## Intentional differences

- Oil is replaced with the native project/file tree. `-` reveals the current
  file; it does **not** open the parent directory as an editable buffer. Floating
  Oil windows and filesystem edits through Vim are not reproduced.
- FzfLua is replaced with native file search and project-wide text search.
- Buffers become editor tabs. Tab order is the IDE's order, and closing a tab
  follows the IDE's save/dirty-file behavior rather than `:bdelete`.
- Terminal placement follows the IDE's panel/tool-window layout rather than
  `:botright terminal`. Vim bindings resume when focus returns to the editor.
- Visual `J`/`K` use native line movement. Selection handling and indentation can
  differ from Neovim's `gv=gv`, especially for blockwise or partial-line
  selections. Use linewise Visual mode (`V`) for predictable block movement.
- IdeaVim preserves the count-sensitive `j`/`k` mappings. VSCodeVim does not
  support expression mappings here, so its default `j`/`k` are retained. With
  wrapping disabled they behave the same; use `gj`/`gk` if you enable wrapping.
- Native bracket/quote pairing replaces nvim-autopairs. Theme, statusline, winbar,
  persistent Vim undo, and Neovim-specific completion behavior are not ported.
  IntelliJ has native spelling inspections; VS Code has no equivalent built-in
  general-purpose spell checker, so no spelling extension is added.
- These configs cover the language shortcuts above, not every evolving Neovim
  default. Code lenses (`grx`) and LSP selection-range text objects are omitted.

## Quick smoke check after installation

Open an indexed source file and check `Space ff`, `Space fs`, `Space sv`, and
`Ctrl-h/l`. Select several lines with `V`, then try `>`, `<`, `J`, and `K`.
On a symbol, check `gd`, `gri`, `grr`, and `grn`; on an unresolved type, check
`gra` for an import fix. In Insert mode, try `Ctrl-Space` and `Ctrl-s`.
Finally, save a deliberately misformatted file to check format-on-save.

If a language action is missing, first run the native action from the IDE's
action/command search. If that also fails, the problem is language support or
project indexing rather than the Vim binding.

## References

- [IdeaVim configuration and IDE action mappings](https://github.com/JetBrains/ideavim#executing-ide-actions)
- [IdeaVim conflicting-key handlers](https://github.com/JetBrains/ideavim/blob/master/doc/sethandler.md)
- [VSCodeVim configuration and remapping](https://github.com/VSCodeVim/Vim#key-remapping)
- [VS Code native command IDs](https://code.visualstudio.com/docs/reference/default-keybindings)
- [Neovim LSP defaults](https://neovim.io/doc/user/lsp/#lsp-defaults)
