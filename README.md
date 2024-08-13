# dotfiles
<a href="https://dotfyle.com/wasabeef/dotfiles-dotconfig-nvim"><img src="https://dotfyle.com/wasabeef/dotfiles-dotconfig-nvim/badges/plugins?style=flat" /></a>

<p align="center">
  <img width="720" alt="Screenshot" src="https://github.com/user-attachments/assets/1babc926-b6ee-4450-96c1-025635292e24">
</p>
<p align="center">
  <img width="720" alt="Screenshot" src="https://github.com/user-attachments/assets/2dd7a07e-9449-4602-820f-29497add09cf">
</p>

## Main Features
- Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim).
- File tree explorer via [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
- Fizzy finder  via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Code, snippet, word auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
- Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).

## Setup
- Brew
  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
  export
  ```sh
  brew bundle dump --global --force
  ```
  import
  ```sh
  /opt/homebrew/bin/brew bundle --global
  ```
- chsh
  ```sh
  vi /etc/shells
  ```
  ```sh
  chsh -s /opt/homebrew/bin/zsh
  ```
- chezmoi
  ```sh
  chezmoi init https://github.com/wasabeef/dotfiles.git
  ```
  ```sh
  chezmoi apply
  ```
- asdf
  ```sh
  awk '{print $1}' .tool-versions | xargs -I {} asdf plugin add {}
  ```
