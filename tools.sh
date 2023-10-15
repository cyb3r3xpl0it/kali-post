#!/bin/bash

#Variables
wordlists=/usr/share/wordlists
recon=/opt/recon
exploting=/opt/exploting
tools=/opt/tools

sudo chown -R $USER:$USER /opt

#Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No color

#Actualizar sistema
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get dist-upgrade -y

#Instalamos Paquetes
sudo apt-get install kali-linx-large -y
sudo apt-get install kali-tools-crypto-stego -y
sudo apt-get install kali-tools-windows-resources -y
sudo dpkg --add-architecture i386 
sudo apt update
sudo apt-get install wine32
sudo apt-get install gnome-terminal
sudo apt-get install terminator
sudo apt-get install golang
sudo apt-get install htop
sudo apt-get install neofetch
sudo apt-get install ranger
sudo apt-get install proxychains
sudo apt-get install tor
sudo apt-get install veil
sudo apt-get install bloodhound
sudo apt-get install neo4j
sudo apt-get install docker.io
sudo apt-get install xclip
sudo apt-get install scrub
sudo apt-get install feroxbuster
sudo apt-get install firejail
sudo apt-get install alacarte
sudo apt-get install dnstwist

sudo usermod -aG docker $USER

#Instalando Go
latest_version=$(curl -s https://api.github.com/repos/golang/go/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

arch=$(uname -m)
case $arch in
    x86_64) arch="amd64";;
    i686)   arch="386";;
    *)
        echo "Arquitectura $arch no soportada"
        exit 1
        ;;
esac

download_url="https://golang.org/dl/go${latest_version}.linux-${arch}.tar.gz"

if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
        case $choice in
                yes)

					echo "Descargando Go $latest_version..."
                    curl -O $download_url
                    sudo tar -C /opt -xzf go${latest_version}.linux-${arch}.tar.gz
                    # Actualizar las variables de entorno
                    echo "Actualizando variables de entorno..."
                    export PATH=$PATH:/usr/local/go/bin
                    export GOPATH=$HOME/go
                    export PATH=$PATH:$GOPATH/bin
                    echo '#GO Variables' >> ~/.zshrc
                    echo 'export GOROOT=/opt/go' >> ~/.zshrc
                    echo 'export GOPATH=$HOME/go' >> ~/.zshrc
                    echo '# Manual PATH' >> ~/.zshrc
                    echo 'PATH=$GOROOT/bin:$GOPATH/bin:$PATH' >> ~/.zshrc
                    # Limpiar archivos descargados
                    rm go${latest_version}.linux-${arch}.tar.gz
                    echo "¡Go $latest_version se ha instalado correctamente!"
                    source ~/.zshrc
					sleep 1
					break
					;;
				no)
					echo "Please install go and rerun this script"
					echo "Aborting installation..."
					exit 1
					;;
	esac	
done
fi

#Creamos carpetas
mkdir -v $recon $exploting $tools

#Clonamos Repos
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

#Instalamos herramientas GO
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