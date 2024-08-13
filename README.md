# dotfiles

**Required**

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
