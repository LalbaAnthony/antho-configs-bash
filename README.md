# Configs Bash

Useful bash aliases and functions to boost your productivity in the terminal.

## 🚀 Install

```sh
curl -fsSL https://raw.githubusercontent.com/LalbaAnthony/antho-configs-bash/main/src/bash_aliases.sh -o ~/.bash_aliases && grep -qxF '[ -f ~/.bash_aliases ] && . ~/.bash_aliases' ~/.bashrc || echo '[ -f ~/.bash_aliases ] && . ~/.bash_aliases' >> ~/.bashrc && source ~/.bashrc && echo "Bash aliases installed successfully!"
```