#!/bin/bash
function welcome {
    clear
    echo "              #################################################"
    echo "              #                HyprMin Dotfiles               #"
    echo "              #                GitHub: edwinxecc              #"
    echo "              #            https://github.com/edwinxecc       #"
    echo "              #################################################"
    echo ""
    echo "              El siguiente script configurara e instalara [yay, hyprland, waybar, wofi]"
    echo "              Puede saltar este paso si ya tiene instalado lo siguiente:"
    echo ""
    echo -e "              \e[32m[yay]\e[0m"
    echo -e "              \e[32m[hyprland]\e[0m"
    echo -e "              \e[32m[thunar]\e[0m"
    echo -e "              \e[32m[alacritty]\e[0m"
    echo -e "              \e[32m[wofi]\e[0m"
    echo -e "              \e[32m[wlogout]\e[0m"
    echo -e "              \e[32m[waybar]\e[0m"
    echo ""
    echo "                !RECUERDA QUE EL SCRIPT DEBE SER EJECUTADO EN HYPRLAND YA INCIADO!"
}

function continue_install {
    echo "              Este script instalara lo descrito. ¿Deseas continuar? (s/n): ";read respuesta

    if [ "$respuesta" = "s" ]; then
        clear
        echo "              ..."
        # yay 
        install_yay
        #wofi, waybar, wlogout
        sudo pacman -S wofi waybar thunar alacritty hyprpaper viewnior dunst --noconfirm
        yay -S wlogout --noconfirm
        #copiar configuración

    elif [ "$respuesta" = "n" ]; then
        echo "              Instalación cancelada."
    else
        echo "              Respuesta no válida. Por favor, responde 's' o 'n'."
        continue_install
    fi
}

function install_yay {
    clear
    echo "              [yay] Install"
    git clone https://aur.archlinux.org/yay.git
    cd yay/
    makepkg -si
}

function copy_dotfiles {
    clear
    echo "#################################################"
    echo "#                HyprMin Dotfiles               #"
    echo "#                Copiando Dotfiles              #"
    echo "#################################################"
    echo ""
    echo -e "               \e[32mCreando Directorios necesarios\e[0m"
    cd $HOME 
    mkdir Escritorio; mkdir Escritorio/Capturas
    mkdir $HOME/Fondos
    mkdir $HOME/.config/waybar
    mkdir $HOME/.config/fastfetch
    mkdir $HOME/.config/wofi
    mkdir $HOME/.config/alacritty

    cd HyprMin
    echo -e "\e[32mOK\e[0m"
    #Hyprland
    echo -e "              \e[32mCopiando hypr en .cofig/hypr...\e[0m"
    cp -r .config/hypr/* $HOME/.config/hypr/
    echo -e "\e[32mOK\e[0m"
    #Waybar
    echo -e "              \e[32mCopiando waybar en .cofig/waybar...\e[0m"
    cp -r .config/waybar/* $HOME/.config/waybar/
    echo -e "\e[32mOK\e[0m"
    #Wofi
    echo -e "              \e[32mCopiando wofi en .cofig/wofi...\e[0m"
    cp -r .config/wofi/* $HOME/.config/wofi/
    echo -e "\e[32mOK\e[0m"
    #Fastfetch
    echo -e "              \e[32mCopiando fastfetch en .cofig/fastfetch...\e[0m"
    cp -r .config/fastfetch/* $HOME/.config/fastfetch/
    echo -e "\e[32mOK\e[0m"
    #Alacritty
    echo -e "              \e[32mCopiando alacritty en .cofig/alacritty...\e[0m"
    cp -r .config/alacritty/* $HOME/.config/alacritty
    echo -e "\e[32mOK\e[0m"
    #Dunst
    echo -e "              \e[32mCopiando dunstrc en .cofig/dunst...\e[0m"
    cp -r .config/dunst/* $HOME/.config/dunst
    echo -e "\e[32mOK\e[0m"


    echo -e "              \e[32mCopiando fondo en Fondos...\e[0m"
    cp -r Fondos/* $HOME/Fondos/
    echo "\e[32m[*] Proceso Completado con exito.\e[0m"
    notify-send "HyprMin Instalado Correctamente"
}

function main {

    welcome
    continue_install
    clear
    echo "¿Desea instalar la configuración de HyprMin? ![Dotfile]! (s/n):";read respuesta2

    if [ "$respuesta2" = "s" ]; then
        copy_dotfiles
    elif [ "$respuesta2" = "n" ]; then
        echo "Instalacion de Dotfile cancelada."
    else
        echo "Respuesta no válida. Por favor, responde 's' o 'n'."
    fi
    
}


if [ $(whoami) != 'root' ]; then
    main
else
    echo '[*] Error, el script no debe ser ejecutado como root.'
    exit 0
fi
