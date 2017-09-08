#!/bin/bash
exec 2>&1
export PATH

LSB_NAME=`lsb_release -sc`
USER=`logname`

echo "--> running provision script for user: $USER"

if [ $LSB_NAME != "xenial" ]
then
    echo -e "--> Stopping: Not a xenial host"
    exit 1
fi

DE_LOCALE=`sed -n /de_DE.UTF-8/p /etc/locale.gen`
if [[ $DE_LOCALE != "# de_DE"* ]]
then
    echo "--> locale already set; skipping"
else
    echo "--> Generating DE locale"
    sed -i "s/# de_DE/de_DE/" /etc/locale.gen
    locale-gen
fi

# dpkg-reconfigure keyboard-layout
# dpkg-reconfigure console-setup


echo "--> adding neovim ppa"
apt-get install software-properties-common
add-apt-repository -y ppa:neovim-ppa/stable

echo "--> installing base packages"
apt-get update
apt-get install -y \
    build-essential \
    apt-transport-https \
    ca-certificates \
    snapd \
    snap-confine \
    mlocate \
    zsh \
    htop \
    curl \
    wget \
    jq \
    imagemagick \
    git \
    virtualenvwrapper \
    tmux \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    python-jedi \
    python3-jedi \
    vim-python-jedi \
    neovim \
    #

echo "--> running updatedb"
updatedb

echo "--> installing kubectl"
snap install kubectl --classic

echo "--> installing latest docker version"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $LSB_NAME stable"
apt-get update
# apt-cache policy docker-ce
apt-get install -y docker-ce

echo "--> adding user $USER to the docker group"
usermod -aG docker $USER

echo "--> adding git shortcuts"
sudo -u $USER git config --global user.name "Sebastian Kriems"
sudo -u $USER git config --global push.default simple
sudo -u $USER git config --global push.followTags true
sudo -u $USER git config --global alias.co checkout
sudo -u $USER git config --global alias.br branch
sudo -u $USER git config --global alias.ci commit
sudo -u $USER git config --global alias.st status
sudo -u $USER git config --global alias.l 'log --pretty=format:"%C(auto)%h %Cgreen(%p)%Creset %cn (%ad) %C(auto)%d%Creset%n  %s"'
sudo -u $USER git config --global alias.ll 'log --pretty=format:"%C(auto)%h %Cgreen(%p)%Creset %cn (%ad) %C(auto)%d%Creset%n  %s" --stat'
sudo -u $USER git config --global alias.lg 'log --pretty=format:"%C(auto)%h %Cgreen(%p)%Creset %cn (%ad) %C(auto)%d%Creset%n  %s" --graph'
# sudo -u $USER git config --global alias.tia 'tag -a $(python setup.py --version) -m $(git log -1 --pretty=%B)'

echo "--> configuring neovim as default editor"
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --skip-auto --config vi
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --skip-auto --config vim
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
update-alternatives --skip-auto --config editor

echo "--> cloning https://github.com/skriems/dotfiles.git into ~/repos/misc/dotfiles"
sudo -u $USER mkdir -p repos/yg
sudo -u $USER mkdir -p repos/misc
sudo -u $USER git clone https://github.com/skriems/dotfiles.git repos/misc/dotfiles

echo "--> configuring vim"
sudo -u $USER cp -R repos/misc/dotfiles/vim .vim
sudo -u $USER cp .vim/vimrc .vimrc

echo "...installing vim-plug for vim"
sudo -u $USER curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "--> configuring neovim"
sudo -u $USER mkdir -p .config/nvim
sudo -u $USER ln -s ~/repos/misc/dotfiles/config/nvim/init.vim .config/nvim/init.vim

echo "...installing vim-plug for neovim"
sudo -u $USER curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "--> changing shell for user $USER to `which zsh`"
chsh $USER -s `which zsh`

echo "--> installing oh-my-zsh"
sudo -u $USER curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo -u $USER sh

echo "--> copying existing .zshrc"
rm .zshrc
sudo -u $USER ln -s repos/misc/dotfiles/zshrc .zshrc

cat <<EOF
PROVISIONING DONE!

TODO:
    - create two virtualenvs: nvim2 / nvim3 (with --python=`which python3`)
    - 'pip install neovim' in both
    - launch neovim
        - :PlugInstall
        - :UpdateRemotePlugins

HAVE FUN!
EOF
