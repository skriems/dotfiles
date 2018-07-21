#! /bin/bash
echo "Needed Information:\n"
echo -n "hostname:"
read hostname
echo -n "locale (i.e. de_DE): "
read locale
echo -n "username: "
read username
echo -n "password: "
read -s password
echo -n "timezone (i.e Europe/Berlin): "
read timezone
read -s password
echo -n "dm_crypt device: "
read cryptdev
echo -m "root device: "
read rootdev

userhome="/home/$username"

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Configuring..."
exit 1
echo "  -> users"
# root password"
passwd

echo "  -> adding user $username; adding to wheel group"
useradd -mG wheel "$username" -s /bin/zsh
echo "$username:$password" | chpasswd

echo "  -> adding wheel group to sudoers"
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo "  -> timezone"
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
echo "  -> hwclock"
hwclock --systohc

echo "  -> locale"
cp /etc/locale.gen /etc/locale.gen.bkp
sed s/#$locale/$locale/ /etc/locale.gen.bkp | grep "$locale" > /etc/locale.gen
locale-gen
echo "LANG=$locale.UTF-8" > /etc/locale.conf

echo "  -> console keymap"
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

echo "  -> hostname and hosts"
echo "$hostname" > /etc/hostname
cat > /etc/hosts <<EOF
127.0.0.1   $hostname
::1         $hostname
127.0.1.1   $hostname.localdomain   $hostname
EOF

echo "  -> systemd-boot"
bootctl --path=/boot install
echo "  -> boot menu entry"
cat > /boot/loader/entries/arch.conf <<EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options cryptdevice=$(blkid -s UUID -o value $cryptdev):crypt root=$rootdev
EOF

# ---- NetworkManager
echo "  -> NetworkManager"
systemctl start NetworkManager
systemctl enable NetworkManager

# ---- DisplayManager
echo "  -> GDM"
systemctl enable gdm

# ---- Files
if [ -e "dotfiles" ]; then
    echo 'Copying files...'
    echo '  -> dotfiles'
    sudo -su $username mkdir -p $userhome/repos/
    cp -R dotfiles $userhome/repos/
fi
if [ -e "dotfiles/vim" ]; then
    echo '  -> .vim'
    cp -R dotfiles/vim $userhome/.vim
fi
if [ -e 'dotfiles/ssh' ]; then
    echo '  -> .ssh'
    cp -R ssh $userhome/.ssh
fi

if [ -e "dotfiles/config" ]; then
    echo '  -> .config'
    cp -R config $userhome/
fi

if [ -e "dotfiles/kube" ]; then
    echo '  -> .kube'
    cp -R kube $userhome/
fi

echo "Fixing permissions..."
chown -R $username:$username $userhome
chmod 755 $(find $userhome -type d)
chmod 644 $(find $userhome -type f)

if [ -e $userhome/.ssh ]; then
    chmod 700 $userhome/.ssh
    chmod 644 $userhome/.ssh/id_rsa.pub
    chmod 600 $userhome/.ssh/id_rsa
fi

echo "Creating symlinks.."
sudo -su $username ln -s $userhome/repos/dotfiles/zshrc $userhome/.zshrc
sudo -su $username ln -s $userhome/repos/dotfiles/vim/vimrc $userhome/.vimrc
sudo -su $username ln -s $userhome/repos/dotfiles/termux/tmux.cof $userhome/.tmux.conf
sudo -su $username ln -s $userhome/repos/dotfiles/config/nvim/init.vim $userhome/.config/nvim/init.vim
sudo -su $username ln -s $userhome/repos/dotfiles/config/i3/config.base $userhome/.config/i3/config.base
sudo -su $username ln -s $userhome/repos/dotfiles/config/i3/i3blocks.conf $userhome/.config/i3/i3blocks.conf
sudo -su $username ln -s $userhome/repos/dotfiles/config/i3/rofi.conf $userhome/.config/i3/rofi.conf

echo 'Virtualenvwrapper in .bashrc'
cat >> $userhome/.bashrc <<EOF
export WORKON_HOME=$userhome/.virtualenvs
source /usr/bin/virtualenvwrapper_lazy.sh
EOF

echo ".gitconfig"
cat > $userhome/.gitconfig <<EOF
[user]
    name = Sebastian Kriems
    email = sebastian.kriems@yougov.de
[alias]
    co = checkout
    br = branch
    ci = commit
    st = status
    l = log --pretty=format:\"%C(auto)%h %Cgreen(%p)%Creset %cn (%ad) %C(auto)%d%Creset%n  %s\"
    ll = log --pretty=format:\"%C(auto)%h %Cgreen(%p)%Creset %cn (%ad) %C(auto)%d%Creset%n  %s\" --stat
    lg = log --pretty=format:\"%C(auto)%h %Cgreen(%p)%Creset %cn (%ad) %C(auto)%d%Creset%n  %s\" --graph
    tia = !sh -c \"git tag -a $(python setup.py --version) -m $(git log -1 --pretty=%B)\"
[push]
    followTags = true
EOF

# ---- AUR
echo 'installing packer and AUR packages'
mkdir $userhome/aurbuild
cd $userhome/aurbuild
wget -O PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
makepkg
pacman -U packer-*.xz --noconfirm
cd $userhome

packer -S \
    gnome-terminal-transparency \
    materia-theme \
    kubectl-bin \
    kubernetes-helm \
    gitflow-avh-git \
    gitflow-zshcompletion-avh \
    nvm \
    j4-make-config-git \
    slack-desktop \
    spotify \
    virtualbox-ext-oracle

echo 'source nvm'
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc

echo '~./npmrc'
cat >> ~./npmrc <<EOF
npm config set init.author.name "Sebastian Kriems"
npm config set init.author.email "bastobuntu@gmail.com"
npm config set init.license "MIT"
npm config set init.version "0.0.1"
EOF

echo "
ToDo:
- check /boot/loader/entries/arch.conf
- add dm_snapshots, dm_crypt, lvm2 to mkinitcpio.conf and run it

- check /etc/vconsole.conf
- create X11 config files for keyboard and touchpad in /etc/X11/xorg.conf.d/
- create virtualenvs for neovim and `pip install neovim jedi flake8 pyflakes`
- install vimplug and plugins
"
