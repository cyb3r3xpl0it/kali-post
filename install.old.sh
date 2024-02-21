#!/bin/bash

#Colores
RST='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MORADO='\033[1;35m'

#Variables
recon=/opt/recon
exploting=/opt/exploting
wordlists=/usr/share/wordlists
fonts=/usr/local/share/fonts

#Funciones
go_install(){
    go_dir="/opt/go"
    go_arch="$(uname -m)"
    go_type="$(uname -s | tr '[:upper:]' '[:lower:]')"

    case $go_arch in
        x86_64) go_arch="amd64";;
        i868)   go_arch="386";;
        *)
            echo "Arquitectura $go_arch no soportada"
            exit 1
            ;;
    esac

    #Obtenemos la última versión de go
    go_latest_version="https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -o 'go[0-9]\+\(\.[0-9]\+\)*' | head -n 1)".${go_type}-${go_arch}.tar.gz

    echo "Descargando la última versión de Go..."
    wget $go_latest_version

    echo "Extrayendo Archivos..."
    tar -C /opt/ -xzf "$(basename ${go_latest_version})"
    rm "$(basename ${go_latest_version})"
    echo "Go se ha instalado correctamente en ${go_dir}"
}

custom(){
    #Obtenemos la última versión de Hack-Font
    hack_latest_version="https://github.com/ryanoasis/nerd-fonts/releases/download/$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep -o 'v[0-9]\+\(\.[0-9]\+\)*' | head -n 1)"/Hack.zip
    unzip $(basename ${hack_latest_version}) -d $fonts
    sudo rm $(basename ${hack_latst_version}) $fonts/LICENSE.md $fonts/readme.md
    #PowerLevel10k
    echo '' >> ~/.zshrc
    echo '#Manual Config' >> ~/.zshrc
    echo '' >> ~/.zshrc
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
    echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.'
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
    #FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    #Ohmytmux
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    ln -s -f ~/.tmux/.tmux.conf ~
    cp ~/.tmux/.tmux.conf.local ~
    sed -i "1iexport _JAVA_AWT_WM_NONREPARENTING=1\n" ~/.zshrc
    sed -i "1i# Fix the Java Problem"   ~/.zshrc
    #Obtenemos la ultima Versión Bat
    #Obtenemos la ultima version lsd
    #Obtenermos la ultima version de fd

}

go_tools(){
    go install -v github.com/ipinfo/cli/ipinfo@latest
    go install -v github.com/tomnomnom/qsreplace@latest
    go install -v github.com/tomnomnom/unfurl@latest
    go install -v github.com/tomnomnom/assetfinder@latest
    go install -v github.com/tomnomnom/httprobe@latest
    go install -v github.com/tomnomnom/waybackurls@latest
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    go install -v github.com/lukasikic/subzy@latest
    go install -v github.com/dwisiswant0/cf-check@latest
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    go install -v github.com/tomnomnom/hacks/filter-resolved@latest
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
    go install -v github.com/haccer/subjack@latest
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
    go install -v github.com/tomnomnom/blocksort@latest
    go install -v github.com/tomnomnom/fff@latest
    go install -v github.com/tomnomnom/dnsgrep@latest
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
}

repos(){
    #RECON
    git clone -v -4 https://github.com/nahamsec/JSParser.git $recon/JSParser
    git clone -v -4 https://github.com/maurosoria/dirsearch.git $recon/dirsearch
    git clone -v -4 https://github.com/nahamsec/lazys3.git $recon/lazys3
    git clone -v -4 https://github.com/tomdev/teh_s3_bucketeers.git $recon/teh_s3_bucketeers
    git clone -v -4 https://github.com/jobertabma/virtual-host-discovery.git $recon/virtual-host-discovery
    git clone -v -4 https://github.com/nahamsec/lazyrecon.git $recon/lazyrecon
    git clone -v -4 https://github.com/blechschmidt/massdns.git $recon/massdns
    git clone -v -4 https://github.com/yassineaboukir/asnlookup.git $recon/asnlookup
    git clone -v -4 https://github.com/nahamsec/crtndstry.git $recon/crtndstry
    git clone -v -4 https://github.com/nahamsec/bbht.git $recon/bbht
    git clone -v -4 https://github.com/guelfoweb/knock.git $recon/knock-dns
    git clone -v -4 https://github.com/carlospolop/legion.git $recon/legion
    git clone -v -4 https://github.com/SecHackLabs/webhackshl.git $recon/webhackshl
    git clone -v -4 https://github.com/aboul3la/Sublist3r.git $recon/Sublist3r
    git clone -v -4 https://github.com/antichown/subdomain-takeover.git $recon/subdomain-takeover
    git clone -v -4 https://github.com/devanshbatham/ParamSpider.git $recon/ParamSpider
    git clone -v -4 https://github.com/Edd13Mora/Subdominator $recon/Subdominator
    git clone -v -4 https://github.com/knownsec/ksubdomain $recon/ksubdomain
    git clone -v -4 https://github.com/a0rtega/pafish $recon/pafish
    git clone -v -4 https://github.com/elceef/dnstwist $recon/dnstwist
    git clone -v -4 https://github.com/americo/sqlifinder $recon/sqlifinder

    #Exploting
    git clone -v -4 https://github.com/codingo/NoSQLMap.git $exploting/NoSQLMap
    git clone -v -4 https://github.com/iphelix/pack.git $exploting/Cracking-Pack-Toolkit
    git clone -v -4 https://github.com/elceef/dnstwist.git $exploting/dnstwist
    git clone -v -4 https://github.com/M4sc3r4n0/Evil-Droid.git $exploting/Evil-Droid
    git clone -v -4 https://github.com/s0md3v/Hash-Buster.git $exploting/Hash-Buster
    git clone -v -4 https://github.com/hashcat/hashcat-utils.git $exploting/Hashcat-Utils
    git clone -v -4 https://github.com/magnumripper/JohnTheRipper.git $exploting/JohnTheRipper
    git clone -v -4 https://github.com/AlessandroZ/LaZagne.git $exploting/laZagne
    git clone -v -4 https://github.com/AlessandroZ/LaZagneForensic.git $exploting/laZagneForensic
    git clone -v -4 https://github.com/ZettaHack/PasteZort.git $exploting/PasteZort
    git clone -v -4 https://github.com/carlospolop/PEASS-ng.git $exploting/PEASS-ng
    git clone -v -4 https://github.com/Screetsec/TheFatRat.git $exploting/TheFatRat
    git clone -v -4 https://github.com/HackingEnVivo/WaterDoS.git $exploting/WaterDoS
    git clone -v -4 https://github.com/WhiteWinterWolf/wwwolf-php-webshell.git $exploting/wwwolf-php-webshell
    git clone -v -4 https://github.com/GinjaChris/pentmenu.git $exploting/pentmenu
    wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -O $exploting/PEASS-ng/linpeas.sh

    #Wordlists
    sudo wget https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt -O $wordlists/all.txt
    sudo git clone -4 -v https://github.com/danielmiessler/SecLists.git $wordlists/seclists
    sudo git clone -4 -v https://github.com/fuzzdb-project/fuzzdb.git $wordlists/fuzzdb
    sudo git clone -4 -v https://github.com/swisskyrepo/PayloadsAllTheThings.git $wordlists/PayloadsAllTheThings
    sudo git clone -4 -v https://github.com/Bo0oM/fuzz.txt.git $wordlists/fuzz
    sudo git clone -4 -v https://github.com/duyet/bruteforce-database.git $wordlists/bruteforce-database 
    sudo git clone -4 -v https://github.com/berzerk0/Probable-Wordlists.git $wordlists/Probable-Wordlists
    sudo git clone -4 -v https://github.com/Cryilllic/Active-Directory-Wordlists.git $wordlists/Active-Directory-Wordlists
    sudo git clone -4 -v https://github.com/Karanxa/Bug-Bounty-Wordlists.git $wordlists/Bug-Bounty-Wordlists
    sudo git clone -4 -v https://github.com/fuzzdb-project/fuzzdb.git $wordlists/fuzzdb
    sudo git clone -4 -v https://github.com/kaimi-io/web-fuzz-wordlists.git $wordlists/web-fuzz-wordlists
    sudo git clone -4 -v https://github.com/p0dalirius/webapp-wordlists.git $wordlists/webapp-wordlists
    sudo git clone -4 -v https://github.com/kkrypt0nn/wordlists.git $wordlists/wordlists
    sudo git clone -4 -v https://github.com/xajkep/wordlists.git $wordlists/wordlists-1
    sudo git clone -4 -v https://github.com/orwagodfather/WordList.git $wordlists/WordList
}

update(){
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y full-upgrade
    sudo apt-get -y dist-upgrade
}

install(){
    sudo apt-get install -y kali-linux-large
    sudo apt-get install -y kali-tools-crypto-stego
    sudo apt-get install -y kali-tools-windows-resources
    sudo dpkg --add-architecture
    sudo apt-get update
    sudo apt-get install -y wine32
    sudo apt-get install -y gnome-terminal
    sudo apt-get install -y terminator
    sudo apt-get install -y htop
    sudo apt-get install -y neofetch
    sudo apt-get install -y ranger
    sudo apt-get install -y proxychains
    sudo apt-get install -y tor
    sudo apt-get install -y veil
    sudo apt-get install -y bloodhound
    sudo apt-get install -y neo4j
    sudo apt-get install -y docker.io
    sudo apt-get install -y xclip
    sudo apt-get install -y scrub
    sudo apt-get install -y feroxbuster
    sudo apt-get install -y firejail
    sudo apt-get install -y alacarte
    sudo apt-get install -y dnstwist
    sudo usermod -aG docker $USER
}

#Cambiamos el Propietario de /opt
sudo chown -R $USER:$USER /opt

#Creamos carpeta para herramientas
mkdir -v $recon $exploting

#Validamos si Go esta Instalado
if command -v go &> /dev/null; then
    echo "Go esta instalado. Versión $(go version)"
else
    echo "Go no esta instalado en este sistema:"
    read -p "¿Desea instalar Go ahora? [y/n]" answer

    case $answer in
        [yY])
            echo "Instalando Go..."
            go
            ;;
        [nN])
            echo "Saliendo..."
            exit 1
            ;;
        *)
            echo "Respuesta no valida"
            ;;
    esac
fi

#Configuramos el zshrc
if [ -f $zsh]; then
    
    echo "Lnea Agregada con exito"
else
    echo "El archivo no existe"
fi
