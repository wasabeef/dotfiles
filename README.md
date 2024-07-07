# dotfiles

**Required**  

- Brew
  - /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  - /opt/homebrew/bin/brew bundle --global
- chsh
  - vi /etc/shells
  - chsh -s /opt/homebrew/bin/zsh
- chezmoi
  - chezmoi init https://github.com/wasabeef/dotfiles.git
  - chezmoi apply
- asdf
  - asdf plugin add ***
  - asdf insatll
