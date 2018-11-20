#! /bin/bash
echo "Installing base packages"
pactrap /mnt \
    base base-devel intel-ucode networkmanger openconnect gnome-keyring libsecret sudo archey3 \
    mutt w3m pass pass-otp \
    xorg xorg-server xf86-video-intel \
    zsh zsh-completions termite termite-terminfo \
    vim vim-spell-de vim-spell-en neovim typescript prettier \
    i3 compton dmenu rofi feh arandr lxappearance acpi pavucontrol playerctl maim \
    gdm gtk-engine-murrine gtk-engines arc-gtk-theme \
    ttf-dejavu adobe-source-code-pro-fonts otf-font-awesome imagemagick \
    hamster-time-tracker virtualbox git s3cmd aws-cli mlocate rsync tmux jq wget htop \
    python-pip python2-pip python-jedi python2-jedi jupyter-notebook \
    pylint flake8 autopep8 python2-autopep8 eslint \
    docker docker-compose \
    nodejs npm \
    rust rustup rust-racer \
    go dep \
    jdk-openjdk \
    jre8-openjdk java-openjfx \ # needed for MediathekView
    # gnome gnome-software-packagekit-plugin gnome-tweak-tool \
    chromium owncloud-client vlc libreoffice-fresh \
    gimp inkscape

echo "Generating fstab"
genfstab -U /mnt > /mnt/etc/fstab

echo "chroot now and run provision.sh"
