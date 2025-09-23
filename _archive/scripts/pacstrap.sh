#! /bin/bash
echo "Installing base packages"
pactrap /mnt \
    base base-devel intel-ucode networkmanger openconnect gnome-keyring libsecret sudo \

    # bluetooth
    bluez bluez-utils blueman pulseaudio-bluetooth \

    # xorg; TODO nvidia
    xorg xorg-server xf86-video-intel \

    # living in terminal
    zsh zsh-completions zsh-syntax-highlighting kitty termite-terminfo bat vifm ffmpegthumbnailer \
    git s3cmd aws-cli rsync tmux jq wget htop ripgrep \

    # fonts
    ttf-dejavu adobe-source-code-pro-fonts otf-font-awesome ttf-font-awesome imagemagick \

    # i3
    i3 compton dmenu rofi feh arandr lxappearance acpi pavucontrol playerctl maim redshift geoclue2 \ # redshift-gtk

    # coding
    neovim vim vim-spell-de vim-spell-en \
    nodejs npm typescript \ # prettier eslint
    rust rustup rust-racer gdb \
    go dep \
    jre-openjdk maven jre8-openjdk java-openjfx \ # jfx needed for MediathekView
    python-pip python2-pip python-jedi python2-jedi jupyter-notebook pylint flake8 autopep8 python2-autopep8 \
    code \

    # office
    mutt w3m pass pass-otp libreoffice-fresh libreoffice-fresh-de hunspell-de \
    docker docker-compose virtualbox \

    # gnome
    gnome gnome-software-packagekit-plugin gnome-tweak-tool \
    gdm gtk-engine-murrine gtk-engines arc-gtk-theme \
    hamster-time-tracker redshift-gtk \
    firefox browserpass chromium nextcloud vlc \
    gimp inkscape

echo "Generating fstab"
genfstab -U /mnt > /mnt/etc/fstab

echo "chroot now and run provision.sh"

# python deps
# vifm:
# - ueberzug

# pikaur
# - ttf-material-icons-git
