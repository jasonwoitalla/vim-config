# VS Code + VSCodeVim

Install **Vim** by **vscodevim** (`vscodevim.vim`) from Extensions, or use:

```sh
code --install-extension vscodevim.vim
```

If `code` is not on your PATH on macOS, run **Shell Command: Install 'code'
command in PATH** from the Command Palette, or install the extension through the
UI. Do not enable VSCodeVim alongside vscode-neovim or another Vim emulator.
This setup needs neither a Neovim process nor VSCodeVim's experimental Neovim
integration.

## Merge the configuration

1. Run **Preferences: Open User Settings (JSON)** from the Command Palette.
   Merge the properties from [`settings.json`](settings.json) into that object.
2. Run **Preferences: Open Keyboard Shortcuts (JSON)**.
   Append the entries from [`keybindings.json`](keybindings.json) to the existing
   array, after any conflicting entries.
3. Run **Developer: Reload Window** if the extension has not picked up changes.

Back up existing settings first. Do not replace unrelated settings or paste a
second top-level JSON object/array. If you already have
`vim.normalModeKeyBindingsNonRecursive` or `vim.visualModeKeyBindingsNonRecursive`,
merge their arrays, removing conflicting `before` sequences. Also check the
recursive `vim.*ModeKeyBindings` arrays for old mappings of the same keys.
Merge `vim.handleKeys` rather than duplicating that property.

Use **user/profile settings**, not a project's `.vscode` folder, if you want
these bindings across projects. Workspace and language-specific settings can
override user settings. Keyboard shortcuts belong to user/profile
`keybindings.json`, not workspace settings. The files in this repository are
templates: VS Code does not automatically read them from here.

Most sequences live in VSCodeVim settings. The two native keyboard shortcuts
are deliberately scoped to Insert mode in an active Vim editor so they do not
intercept typing in terminals or search fields.

## Native settings and language support

The settings enable absolute line numbers, two-space indentation, no wrapping,
system clipboard, four lines of cursor context, native bracket/quote pairing,
automatic suggestions, and whole-file format-on-save. File previews are disabled
so opened files remain tabs, more like Neovim buffers.

Search remains case-sensitive to match `init.lua`'s default `ignorecase=false`.
Although `smartcase` is enabled in both configs, it only takes effect if you
choose to enable `ignorecase`.

VSCodeVim supplies editing, not language intelligence:

| Language | Provider |
| --- | --- |
| JavaScript/TypeScript | Built-in VS Code support |
| Java | **Language Support for Java by Red Hat** (`redhat.java`); alternatively Microsoft's **Extension Pack for Java** (`vscjava.vscode-java-pack`) for debugging/testing/build tools too |
| Rust | **rust-analyzer** (`rust-lang.rust-analyzer`) |
| Lua | **Lua** (`sumneko.lua`) |
| Kotlin/other languages | Install an appropriate language provider if needed; IntelliJ remains the native JVM-first option |

For Java, install a supported JDK and open/import the project root so the provider
can load Maven/Gradle metadata and finish indexing. The bindings use VS Code's
standard language commands; no Java-specific keymap is needed.

For formatting, run **Format Document With... > Configure Default Formatter**
for each language where multiple formatters are installed. A language without a
formatter will not gain one from `editor.formatOnSave`. Project formatter rules
and language-specific settings may use a different indentation width from the
two-space editor default.

Import organization on save is not added. Existing
`editor.codeActionsOnSave` settings remain your choice.

## Language shortcuts

See the [shared reference](../README.md#language-navigation-and-actions) for all
bindings. `gra` opens the native code-action menu, including import fixes on
unresolved symbols; `gri`, `grr`, `grn`, and `grt` invoke implementation,
references, rename, and type definition. `gO` opens document symbols, and `K`
shows hover information.

The `gra` command requests all action kinds and always shows the picker rather
than automatically applying a lone action. In Visual mode, the selected range
is passed to the language provider. Import fixes and refactorings appear only
when the provider offers them.

In Insert mode, `Ctrl-Space` triggers suggestions and `Ctrl-s` shows signature
help. **Ctrl-s no longer saves while in Insert mode.** Use `:w`, `Cmd-s` on macOS,
or leave Insert mode before pressing `Ctrl-s` on Windows/Linux.

## macOS and shortcut conflicts

For holding `h/j/k/l` to repeat instead of showing the accent picker, optionally
run:

```sh
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

Log out and back in, then restart VS Code. To undo this app-specific preference:

```sh
defaults delete com.microsoft.VSCode ApplePressAndHoldEnabled
```

If macOS captures `Ctrl-Space` for switching input sources, change that shortcut
in **System Settings > Keyboard > Keyboard Shortcuts > Input Sources**.
`Ctrl` here really means Control, not Command.

For editor conflicts, run **Developer: Toggle Keyboard Shortcuts Troubleshooting**
and press the key to see which command receives it. Check for later user
shortcuts that override these entries, and confirm that `vim.handleKeys` routes
`Ctrl-h/j/k/l/d/u` to Vim. These keys navigate editor groups in Normal mode;
they leave terminal shortcuts alone.

For a missing Vim sequence, set the Vim log level to Debug with
**Developer: Set Log Level**, reload the window, and inspect **Output > Vim**.
If a language action is unavailable, try it from the Command Palette before
debugging the mapping.

See [compatibility notes and smoke checks](../README.md#intentional-differences),
[VSCodeVim's documentation](https://github.com/VSCodeVim/Vim), and
[VS Code's Java setup guide](https://code.visualstudio.com/docs/languages/java).
