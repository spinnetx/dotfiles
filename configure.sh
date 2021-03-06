# Set git configuration
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

# Put configuration files to the $HOME folder
git clone https://github.com/karlkorp/dotfiles.git
sh dotfiles/rtags_install.sh
cp dotfiles/.emacs             "$HOME"/
cp dotfiles/.vimrc             "$HOME"/
cp dotfiles/.bashrc            "$HOME"/
cp dotfiles/.octaverc          "$HOME"/
cp dotfiles/.emacs_packages.el "$HOME"/
sudo -H sh dotfiles/python_packages.sh
rm -rf dotfiles
