return {
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  root_markers = {
    ".graphqlrc",
    ".graphqlrc.json",
    ".graphqlrc.yml",
    ".graphqlrc.yaml",
    "graphql.config.js",
    ".git",
  },
}
