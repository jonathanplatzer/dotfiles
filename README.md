# dotfiles

This repo contains all my dotfiles. It is modeled after harfangk's excellent [blog post](https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html).

## Structure

The `master` branch only contains `README.md`, which is used for documentation purposes, and left out of the other branches.

The `base` branch contains all dotfiles which are used everywhere without any modifications on a per machine level, like my zsh or neovim configs.

Then there are branches for each host, containing configurations which differ from one machine to another.

## Usage

To use this repo, only a few commands are needed

```
echo 'alias dotfiles="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo ".dotfiles.git" >> .gitignore
git clone -b common --bare git@github.com:jonathanplatzer/dotfiles.git $HOME/.dotfiles.git
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

Now everything should work as expected and the `dotfiles` alias to add to this repo.
