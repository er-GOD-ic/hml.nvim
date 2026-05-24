# hml.nvim

Minimal H / M / L viewport markers for Neovim.

`hml.nvim` places lightweight line markers for:

* **H** → upper viewport position
* **M** → middle viewport position
* **L** → lower viewport position

The markers follow scrolling in real time and can be customized with native Neovim highlight definitions.

---

## Features

* Minimal and lightweight
* Native sign + numhl based rendering
* Real-time viewport tracking
* Colorscheme friendly
* Fully configurable highlights
* Lazy.nvim compatible
* No external dependencies

---

## Preview

```text
 120 │ function setup()
 121 │ local state = {}
 122 │
 123 │ function M.update()
 124 │ end
 125 │
 126 │ return M
     ▲ H

 140 │ local mid = math.floor(...)
     ■ M

 162 │ vim.api.nvim_create_autocmd(...)
     ▼ L
```

---

# Installation

## lazy.nvim

```lua
{
    "er-GOD-ic/hml.nvim",

    opts = {},
}
```

---

# Configuration

All highlight definitions use native `vim.api.nvim_set_hl()` specs.

## Default configuration

```lua
{
    highlights = {
        HmlNumH = {
            link = "Directory",
        },

        HmlNumM = {
            link = "Directory",
        },

        HmlNumL = {
            link = "Directory",
        },
    },

    signs = {
        HmlSignH = {
            text = "",
            texthl = "",
            numhl = "HmlNumH",
        },

        HmlSignM = {
            text = "",
            texthl = "",
            numhl = "HmlNumM",
        },

        HmlSignL = {
            text = "",
            texthl = "",
            numhl = "HmlNumL",
```
