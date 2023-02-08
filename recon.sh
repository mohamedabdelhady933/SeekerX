#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'

if [ $1 ]
then
        printf "
         ▄▄▄▄▄▄
         ██▀▀▀▀██
         ██    ██   ▄████▄    ▄█████▄   ▄████▄   ██▄████▄
         ███████   ██▄▄▄▄██  ██▀    ▀  ██▀  ▀██  ██▀   ██
         ██  ▀██▄  ██▀▀▀▀▀▀  ██        ██    ██  ██    ██
         ██    ██  ▀██▄▄▄▄█  ▀██▄▄▄▄█  ▀██▄▄██▀  ██    ██
         ▀▀    ▀▀▀   ▀▀▀▀▀     ▀▀▀▀▀     ▀▀▀▀    ▀▀    ▀▀
                        Mohamed Abdelhady       \n\n";
        printf "${YELLOW}[i]  The target is : $1\n\n";
        if [ -e ./Recon ]
        then
                printf "The Recon Folder is already created \n\n";
        else
                mkdir Recon;
        fi

        if [ -e ./Recon/$1 ]
        then
                printf "The $1 folder is already created \n\n";
        else
                mkdir Recon/$1;
        fi
        touch Recon/$1/js_files;
        touch Recon/$1/parameters.txt;
        touch Recon/$1/subdomains.txt;
        touch Recon/$1/tmp_for_subs.txt;
        touch Recon/$1/live-subs.txt;
        touch Recon/$1/urls.txt;
        # touch Recon/$1/ips.txt;
        if [ -x "$(command -v sublist3r)"  ]
        then
                printf "${GREEN}[+]  Sublist3r Started \n\n"
                sublist3r -d $1 | grep ".$1" 2>/dev/null  >> Recon/$1/tmp_for_subs.txt ;
        else
                printf "${RED}[-]----------Sublist3r Not Found----------[-]\n\n";
                printf "\n${WHITE} Download it from  https://github.com/aboul3la/Sublist3r  \n or you can  [ sudo apt install sublist3r ]\n\n";
                        #Install tool here
        fi


        printf "${GREEN}[+]  SubFinder Started\n\n";


        if [  -x "$(command -v subfinder)" ]
        then
                subfinder -d $1 >> Recon/$1/tmp_for_subs.txt  2>/dev/null;
        else
                printf "${RED}[-]----------Subfinder Not Found----------[-]\n\n";
                printf "\n${WHITE} Download it from  https://github.com/projectdiscovery/subfinder  \n or you can  [ sudo apt install subfinder ]\n\n";
        fi


        printf "${GREEN}[+]  AssetFinder Started \n\n";


        if [ -x "$(command -v assetfinder)" ]
        then
                assetfinder -subs-only $1 >> Recon/$1/tmp_for_subs.txt;
        else
                printf "${RED}[-]----------Assetfinder Not Found----------[-]\n\n";
                printf "\n${WHITE} Download it from  https://github.com/tomnomnom/assetfinder  \n or you can  [ sudo apt install assetfinder ]\n\n";
        fi


        printf "${GREEN}[+]  SubBrute Started \n\n";


        if [  -x "$(command -v subbrute)" ]
        then
                subbrute $1 >> Recon/$1/tmp_for_subs.txt;
        else
                printf "${RED}[-]----------Subbrute Not Found----------[-]\n\n";
                printf "\n${WHITE} Download it from  https://github.com/TheRook/subbrute \n\n";
        fi


        printf "${GREEN}[+]  Amass Started\n\n";


        if [ -x "$(command -v amass)" ]
        then
                amass enum -d $1 >> Recon/$1/tmp_for_subs.txt 2>/dev/null;
        else
                printf "${RED}[-]----------Amass Not Found----------[-]\n";
                printf "\n${WHITE} Download it go install -v github.com/OWASP/Amass/v3/...@master  \n or you can  [ sudo apt install amass ]\n\n";
        fi


        printf "${GREEN}[+]  Gobuster Started \n\n";


        if [ -x "$(command -v gobuster)" ]
        then
                mkdir /tmp/gobuster_$1;
                touch /tmp/gobuster_$1/output.txt;
                gobuster dns -d $1 -w $2 | grep "Found:" >> /tmp/gobuster_$1/output.txt;
                cat /tmp/gobuster_$1/output.txt | cut -d ' ' -f 2 >> Recon/$1/tmp_for_subs.txt;
                rm -fr /tmp/gobuster_$1;
        else
                printf "${RED}[-]----------Gobuster Not Found----------[-]\n\n";
                printf "\n${WHITE} Download it go install github.com/OJ/gobuster/v3@latest  \n or you can  [ sudo apt install gobuster ]\n\n";
        fi


        printf "${GREEN}[+]  Import from Crt.sh \n\n";


        curl -s https://crt.sh/?q=*.$1  | grep "$1" | grep -v "*.$1" | cut -d '>' -f 2 | cut -d '<' -f 1 | grep -v "*" | sort -u  >> Recon/$1/tmp_for_subs.txt;


        printf "${GREEN}[+]  Import from SecurityTrials\n\n";


        securitytrails_subs=`curl -s https://api.securitytrails.com/v1/domain/$1/subdomains?apikey=kvXsoQ6aj22Hhk4hav8bbW37CtaLeXha | cut -d '"' -f2 | sort -u | grep '.' | grep -v "]" | grep -v "}" | grep -v "{"`;

        for i in $securitytrails_subs:
        do
                echo "$i.$1" >> Recon/$1/tmp_for_subs.txt;
        done


# --------------------------------------Get Subs of Subdomains----------------------------------

        if [ -x "$(command -v subfinder)" ]
        then
                printf "${GREEN}[+]  Enum more subdomains of Subdomains \n\n";

                touch Recon/$1/subs_of_subs.txt;
                touch Recon/$1/filter_subs.txt;
                subfinder -dL Recon/$1/tmp_for_subs.txt -silent >>  Recon/$1/subs_of_subs.txt;
                cat Recon/$1/subs_of_subs.txt >> Recon/$1/tmp_for_subs.txt;
                rm Recon/$1/subs_of_subs.txt;
                cat Recon/$1/tmp_for_subs.txt | sort -u >> Recon/$1/filter_subs.txt;
                rm Recon/$1/tmp_for_subs.txt;
                cat Recon/$1/filter_subs.txt >> Recon/$1/tmp_for_subs.txt;
                
                
        else
                printf "${RED}[-]----------Subfinder tool Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  https://github.com/projectdiscovery/subfinder \n\n";
        fi



#----------------------------------Subdomain TakeOver-------------------------------------------------------

        printf "${GREEN}[+]  Check Subdomains TakeOver \n\n";
        if [  -x "$(command -v subzy)" ]
        then

                subzy --hide_fails -targets Recon/$1/tmp_for_subs.txt;
                printf "\n\n";
                
        else
                printf "${RED}[-]----------Sybzy Not Found-----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ go install -v github.com/lukasikic/subzy@latest ]\n\n";
        fi

#--------------------------------------Get Live Subdomains-------------------------------


        if [ -x "$(command -v httpx)" ]
        then
        printf "${GREEN}[+]  Geting live Subdomains \n\n";

        cat Recon/$1/tmp_for_subs.txt | httpx -silent -ports 80,443,8080,8443,9443,9080,8888,3000,81,30001,9000,10000,2222 | cut -d '/' -f 3 | sort -u >> Recon/$1/live-subs.txt;
        cat Recon/$1/tmp_for_subs.txt | grep $1 | grep -v "Enumerating" |  sort -u  >> Recon/$1/subdomains.txt;
        
        else
                printf "${RED}[-]----------httpx tool Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest ]\n\n";
        fi

# -------------------------------------Get URLs ------------------------------------------------------------------

        if [ -x "$(command -v waybackurls)" ] &&  [ -x "$(command -v gau)"]
        then
        printf "${GREEN}[+]  Geting  Subdomains' URLs \n\n";
                touch Recon/$1/tmp_for_urls.txt;
                cat Recon/$1/live-subs.txt | waybackurls >> Recon/$1/tmp_for_urls.txt;
                cat Recon/$1/live-subs.txt | gau >> Recon/$1/tmp_for_urls.txt;
                cat Recon/$1/tmp_for_urls.txt | sort -u  >> Recon/$1/urls.txt;
                rm  Recon/$1/tmp_for_urls.txt
        else
                printf "${RED}[-]----------waybackurls or gau tool Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ go install -v go install github.com/tomnomnom/waybackurls@latest ]\n\n";
        fi

#-----------------------------------Get Package.json paths-------------------------------------------------------


        if [ -x "$(command -v httpx)" ]
        then
        printf "${GREEN}[+]  Try to find package.json \n\n";
        cat Recon/$1/live-subs.txt | httpx -silent -path /package.json >> Recon/$1/dependency_paths.txt;
        else
                printf "${RED}[-]----------httpx tool Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest ]\n\n";
        fi



#-----------------------------------Check Dependency Confusion-------------------------------------------------------

        if [ ! -s ./Recon/$1/dependency_paths.txt ]
        then
                if [ -x "$(command -v confused)" ]
                then
                        printf "${GREEN}[+]  Try to Confusion Dependencies  from collected package.json files \n\n";
                        mkdir /tmp/PackageDotJson
                        dependency_paths=$(cat Recon/$1/dependency_paths.txt);
                        counter=1;
                        for i in $dependency_paths
                        do
                                counter++;
                                wget --quiet $i --output-file=/tmp/PackageDotJson/$counter.txt;
                                confused -l npm /tmp/PackageDotJson/$counter.txt;
                        done
                        
                else
                        printf "${RED}[-]----------confused tool Not Found----------[-]\n\n";
                        printf "\n${WHITE} You can Download it  [ go install -v github.com/visma-prodsec/confused@latest ]\n\n";
                fi
        fi



#-----------------------------Get JS Files-------------------------------------------------------------------------------



        printf "${GREEN}[+]  Get JS Files \n\n";
        if [ -x "$(command -v gau)" ]
        then
                subsforjs=$(cat Recon/$1/live-subs.txt);
                for i in $subsforjs
                do
                echo $i | gau | grep "\.js$" >> Recon/$1/js_files;
                done
        else
                printf "${RED}[-]----------Gau Tool Not Found----------[-]\n\n";
                 printf "\n${WHITE} You can Download it  [ go install github.com/lc/gau/v2/cmd/gau@latest ]\n\n";
        fi



        curl -sk "http://web.archive.org/cdx/search/cdx?url=*.$1&output=txt&fl=original&collapse=urlkey&page=" | grep '\.js$' >> Recon/$1/js_files;

        if [ -x "$(command -v waybackurls)" ]
        then
                waybackurls $1 | grep '\.js' | uniq | sort >> Recon/$1/js_files;
        else
                printf "${RED}[-]----------Waybackurls Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ go install github.com/tomnomnom/waybackurls@latest ]\n\n";
        fi

        if [ -x "$(command -v gospider)" ]
        then
                gospider -s https://$1 | grep "\.js$" | awk -F"http" '{print "http"$2}' >> Recon/$1/js_files;
        else
                printf "\n${RED}[-]----------Gospider Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ sudo apt install gospider ] \n or you can install it using go [ go install github.com/jaeles-project/gospider@latest ]\n\n";
        fi

        touch Recon/$1/js-files.txt;
        cat Recon/$1/js_files | sort -u >> Recon/$1/js-files.txt;
        rm Recon/$1/js_files;

#----------------------------------Get Ips------------------------------------------------



        # printf "${GREEN}[+]  Getting IPs and IP range\n\n";
        # subs=`cat Recon/$1/subdomains.txt`;

        # for i in $subs
                # do
                # host $i | grep "has address" | awk '{print $4}' >> Recon/$1/ips.txt;
                # done
        # if [ -x "$(command -v amass)" ]
        # then
                # mkdir /tmp/amass_$1;
                # touch /tmp/amass_$1/output.txt;
                # amass enum  -d $1 >>/dev/null  2>/tmp/amass_$1/output.txt;
                # cat /tmp/amass_$1/output.txt | grep "Subdomain Name(s)" | cut -d ' ' -f 1 | awk -F" " '{print $1}' >> Recon/$1/ip_range.txt;
                # rm -fr /tmp/amass_$1;
        # else
                # printf "\n${RED}[-]----------Amass Not Found----------[-]\n\n";
                # printf "\n${WHITE} Download it go install -v github.com/OWASP/Amass/v3/...@master  \n or you can  [ sudo apt install amass ]\n\n";
        # fi



        # curl -s https://api.securitytrails.com/v1/history/$1/dns/a?apikey=kvXsoQ6aj22Hhk4hav8bbW37CtaLeXha | grep '"ip"' | awk -F" " '{print $2}' | cut -d '"' -f 2 | sort -u>> Recon/$1/ips.txt;

        # if [ -x "$(command -v subfinder)" ]
        # then
                # subfinder -d $1 -silent | httpx  -silent -asn | cut -d ' ' -f 5 | cut -d ']' -f 1 | sort -u >> Recon/$1/ip_range.txt;
        # else
                # printf "${RED}[-]----------Subfinder Not Found----------[-]\n\n";
                # printf "\n${WHITE} Download it from  https://github.com/projectdiscovery/subfinder  \n or you can  [ sudo apt install subfinder ]\n\n";
        # fi
#----------------------------------Get ASN Number-------------------------------------------------------


        # printf "\n${GREEN}[+]  Getting ASN Number \n\n";


        # if [ -x "$(command -v amass)" ]
        # then
                # mkdir /tmp/amass_$1;
                # touch /tmp/amass_$1/output.txt;
                # amass enum  -d $1 >>/dev/null 2>/tmp/amass_$1/output.txt;
                # cat /tmp/amass_$1/output.txt | grep "ASN" | cut -d '-' -f 1 | cut -d ' ' -f 2 | awk '{print "AS"$0}'  >> Recon/$1/asn.txt;
                # rm -fr /tmp/amass_$1;
        # else
                # printf "${RED}[-]----------Amass Not Found----------[-]\n\n";
                # printf "\n${WHITE} Download it go install -v github.com/OWASP/Amass/v3/...@master  \n or you can  [ sudo apt install amass ]\n\n";
        # fi

        # if [ -x "$(command -v subfinder)" ]
        # then
                # asns=$(subfinder -d $1 -silent | httpx -silent -asn | grep "$1" | awk -F"AS" '{print $2}' | cut -d ',' -f 1);
                # for i in $asns
                # do
                        # echo "AS$i" >> Recon/$1/asn.txt;
                # done
        # else
                # printf "${RED}[-]----------Subfinder Not Found----------[-]\n\n":
                # printf "\n${WHITE} Download it from  https://github.com/projectdiscovery/subfinder  \n or you can  [ sudo apt install subfinder ]\n\n";
        # fi




#-----------------------------------Get Parameters------------------------------------------------------------------------

        printf "\n\n${GREEN}[+]  Get Parameters\n\n";

        if [ -x "$(command -v waybackurls)" ]
        then
                cat Recon/$1/live-subs.txt | waybackurls | sed -e 's/:80//' | grep "?[a-z0-9]*=" | sort -u >> /tmp/tmpforparameters.txt;

        else
                printf "${RED}[-]----------Waybackurls Not Found----------[-]\n\n";
                printf "\n${WHITE} You can Download it  [ go install github.com/tomnomnom/waybackurls@latest ]\n\n";
        fi

        if [ ! -e ./Recon/.ParamSpider/paramspider.py ]
        then
                
                git clone https://github.com/devanshbatham/ParamSpider Recon/.ParamSpider/;
                pip3 install -r Recon/.ParamSpider/requirements.txt;
                touch /tmp/tmpforparameters.txt;
                forparameters=$(cat Recon/$1/live-subs.txt);
                for i in $forparameters
                do
                        python3 Recon/.ParamSpider/paramspider.py --domain $i | grep -v '.js\|.css\|.woff\|.svg\|.txt' >> /tmp/tmpforparameters.txt; 
                        cat /tmp/tmpforparameters.txt | sort -u >> Recon/$1/parameters.txt;
                        rm /tmp/tmpforparameters.txt;
                done
                


                
        else
                touch /tmp/tmpforparameters.txt;
                forparameters=$(cat Recon/$1/live-subs.txt);
                for i in $forparameters
                do
                        python3 Recon/.ParamSpider/paramspider.py --domain $i | grep -v '.js\|.css\|.woff\|.svg\|.txt' >> /tmp/tmpforparameters.txt; 
                        cat /tmp/tmpforparameters.txt | sort -u >> Recon/$1/parameters.txt;
                        rm /tmp/tmpforparameters.txt;
                done
        fi

#---------------------------------Trying XSS------------------------------------------------------------------------------------------

        if [ -x "$(command -v kxss)" ]
        then
                printf "${GREEN}[+]  Getting some XSS\n\n";
                cat Recon/$1/parameters.txt | kxss;
        else
                printf "${RED}[-]----------KXSS Tool Not Found----------[+]\n\n";
                printf "${WHITE} Download it using go [ go get github.com/Emoe/kxss ] \n\n"
        fi

# ----------------------------------Nuclei Custom templates------------------------------------------------------
        
        if [ -x "$(command -v nuclei)" ]
        then
                printf "${GREEN}[+]  Start Nuclei Scanning with Custom nuclei templates \n\n";
                cat Recon/$1/subdomains.txt | nuclei -t CustomNucleiTemplates/;
        else
                printf "${RED}[-]----------Nuclei Tool Not Found----------[+]\n\n";
                printf "${WHITE} Download it using  apt install nuclei \n\n";
        fi

# ----------------------------------Get Shodan Vulns------------------------------------------------------
        
        if [ -x "$(command -v uncover)" ]
        then
                printf "${GREEN}[+]  Getting some Vulns from Shodan \n\n";
                export SHODAN_API_KEY=5Tv7G1tX14X18zjpgp0d8vNKlimqkjMd;
                echo "SSL:$1" | uncover -e shodan | nuclei -t CustomNucleiTemplates/;
        else
                printf "${RED}[-]----------uncover Tool Not Found----------[+]\n\n";
                printf "${WHITE} Download it using  apt install uncover \n\n";
        fi
        

        rm  Recon/$1/tmp_for_subs.txt;

        printf "\n\n${GREEN} You can find files in ./Recon/$1 \n\n";

else
printf "${YELLOW} [i] Enter a target\n";
printf "${YELLOW} [i] Syntax  ./recon.sh domain.com  subdomains-wordlist.txt"
fi

