#!/bin/bash

source config.conf

function banner  {
  echo -e "${YELLOW}"
  cat << "EOF"
                                                                                         
         ad88888ba                           88                            8b        d8  
        d8"     "8b                          88                             Y8,    ,8P   
        Y8,                                  88                              `8b  d8'    
        `Y8aaaaa,     ,adPPYba,   ,adPPYba,  88   ,d8   ,adPPYba,  8b,dPPYba,  Y88P      
          `"""""8b,  a8P_____88  a8P_____88  88 ,a8"   a8P_____88  88P'   "Y8  d88b      
                `8b  8PP"""""""  8PP"""""""  8888[     8PP"""""""  88        ,8P  Y8,    
        Y8a     a8P  "8b,   ,aa  "8b,   ,aa  88`"Yba,  "8b,   ,aa  88       d8'    `8b   
         "Y88888P"    `"Ybbd8"'   `"Ybbd8"'  88   `Y8a  `"Ybbd8"'  88      8P        Y8 

EOF
  echo -e "                                         ${GREEN} SeekerX -  Reconnaissance tool by 0x41ly${NC}"
  echo ""
}

function usage {
  echo -e "${BLUE}${BOLD}Usage${NC}: ${GREEN}$0${NC} ${YELLOW}-p${NC} projectname ${YELLOW}-d${NC} domainfilepath [${YELLOW}-o${NC} outputdir]"
  echo -e "Options:"
  echo -e "  ${YELLOW}-p | --projectname  ${NC} : Specify the project name (Output Directory Name)"
  echo -e "  ${YELLOW}-d | --domainfile   ${NC} : Specify the path to the domain file (ex: domains.txt)"
  echo -e "  ${YELLOW}-o | --outputdir    ${NC} : Specify the path to the output directory (default is the current directory)"
  echo -e "  ${YELLOW}-m | --mode         ${NC} : The scan mode (either "fast" or "deep"). Default is "fast"."
  echo -e "  ${YELLOW}-c | --check        ${NC} : Check if required tools are installed"
  echo -e "  ${YELLOW}-h | --help         ${NC} : Display this help message"
  exit 1
}

function checkForTools {
  if ! [ -x "$(command -v $HOOK_HOME/hoOk.py)" ]
  then
    echo -e "${RED}[-]---------- hoOk not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it from https://github.com/mrxdevil404/hoOk.git${NC}"
    echo -e "${RED}[-] Make sure you define it path correctly in config.conf ${NC}"
  fi

  if ! [ -x "$(command -v subfinder)" ]
  then
    echo -e "${RED}[-]---------- subfinder not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest'${NC}"
  fi

  if ! [ -x "$(command -v sublist3r)" ]
  then
    echo -e "${RED}[-]---------- sublist3r not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'pip3 install sublist3r'${NC}"
  fi

  if ! [ -x "$(command -v assetfinder)" ]
  then
    echo -e "${RED}[-]---------- assetfinder not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/tomnomnom/assetfinder@latest'${NC}"
  fi

  # if ! [ -x "$(command -v amass)" ]
  #   then
  #     echo -e "${RED}[-]---------- amass not found ----------[-]"
  #     echo -e "${RED}[-] Download it with 'go install -v github.com/owasp-amass/amass/v3/...@master'${NC}"
  #   fi

  if ! [ -x "$(command -v gobuster)" ]
    then 
      echo -e "${RED}[-]---------- gobuster not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install github.com/OJ/gobuster/v3@latest'${NC}"
    fi

  if ! [ -d "$SECLISTS" ]
   then
    echo -e "${RED}[-]---------- seclists not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it from https://github.com/danielmiessler/SecLists${NC}"
    echo -e "${RED}[-] Add its path to the config file${NC}"
  fi

  if ! [ -x "$(command -v subzy)" ]
    then 
      echo -e "${RED}[-]---------- subzy not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install -v github.com/LukaSikic/subzy@latest'${NC}"
    fi

  if ! [ -x "$(command -v gau)" ]
    then 
      echo -e "${RED}[-]---------- gau not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install github.com/lc/gau/v2/cmd/gau@latest'${NC}"
    fi

  if ! [ -x "$(command -v waybackurls)" ]
    then 
      echo -e "${RED}[-]---------- waybackurls not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install -v github.com/tomnomnom/waybackurls@latest'${NC}"
    fi

  if ! [ -x "$(command -v httpx)" ]
    then 
      echo -e "${RED}[-]---------- httpx not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install github.com/projectdiscovery/httpx/cmd/httpx@latest'${NC}"
    fi

  if ! [ -x "$(command -v $SEEKERX_HOME/tools/DepFine/DepFine.py)" ]
    then 
      echo -e "${RED}[-]---------- DepFine not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'git clone https://github.com/M359AH/DepFine.git '${NC}"
    fi

  if ! [ -x "$(command -v nuclei)" ]
  then
    echo -e "${RED}[-]---------- nuclei not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest'${NC}"
  fi

  if ! [ -x "$(command -v $SEEKERX_HOME/tools/DNSaxfr/DNSaxfr.sh)" ]
    then
      echo -e "${RED}[-]---------- DNSaxfr not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it from 'https://github.com/cybernova/DNSaxfr'${NC}"
      echo -e "${RED}[-] Place it in the tools folder"
    fi

  if ! [ -x "$(command -v dirsearch)" ]
    then
      echo -e "${RED}[-]---------- dirsearch not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'pip3 install dirsearch'${NC}"
    fi

  if ! [ -x "$(command -v arjun)" ]
    then
      echo -e "${RED}[-]---------- arjun not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'pip3 install arjun'${NC}"
    fi

  if ! [ -f $SEEKERX_HOME/tools/wpconfig-checker.py ]
    then
      echo -e "${RED}[-]---------- wpconfig-checker not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'wget https://raw.githubusercontent.com/mohamedabdelhady933/Wordpress-Config-Enum/main/wpconfig-checker.py'${NC}"
      echo -e "${RED}[-] Place it in the tools folder"
    fi
    
  echo -e "${GREEN}[+] Done!!"
}

function subdomainsScan {

  mkdir -p $outputdir/$projectname/$1/recon/subdomains
  echo -e "${YELLOW}[+] Passive subdomains scanning for $1${NC}"

  #------------------------------------------ hoOk ----------------------------------------------#
  if [ -x "$(command -v $HOOK_HOME/hoOk.py)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.hook ]
  then
    echo -e "${GREEN}[+] hoOk Started on $1${NC}"
    currentplace="$(pwd)"
    cd $HOOK_HOME
    python3 hoOk.py -t $1 
    cd $currentplace
    mv $HOOK_HOME/${1}-subdomains.txt $outputdir/$projectname/$1/recon/subdomains/hoOk.txt
    cat $HOOK_HOME/censys_domains.txt | grep $1 >> $outputdir/$projectname/$1/recon/subdomains/censys_domains.txt
    touch $outputdir/$projectname/$1/.progress/.hook
  fi


  #------------------------------------------- sublist3r --------------------------------------------------#
  if [ -x "$(command -v sublist3r)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.sublist3r ]
  then
    echo -e "${GREEN}[+] sublist3r Started on $1${NC}"
    sublist3r -d $1 -o $outputdir/$projectname/$1/recon/subdomains/sublist3r.txt 
    touch $outputdir/$projectname/$1/.progress/.sublist3r
  fi

  #------------------------------------------- assetfinder --------------------------------------------------#
  if [ -x "$(command -v assetfinder)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.assetfinder ]
  then
    echo -e "${GREEN}[+] assetfinder Started on $1${NC}"
    assetfinder --subs-only $1 >> $outputdir/$projectname/$1/recon/subdomains/assetfinder.txt 
    touch $outputdir/$projectname/$1/.progress/.assetfinder
  fi

  #------------------------------------------- amass --------------------------------------------------#
  
  # if [ -x "$(command -v amass)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.amass ]
  # then
  #   echo -e "${GREEN}[+] amass Started on $1${NC}"
  #   amass intel -d $1 >> $outputdir/$projectname/$1/recon/subdomains/amass_intel.txt 2>/dev/null;

    # if [ "$mode" == "deep" ]
    # then
    #   amass enum -d $1 >> $outputdir/$projectname/$1/recon/subdomains/amass_enum.txt 2>/dev/null;
    # fi
    
  #   touch $outputdir/$projectname/$1/.progress/.amass
  # fi


  #------------------------------------------- gobuster -------------------------------------#
  if [ -x "$(command -v gobuster)" ] && [ -d "$SECLISTS" ] && [ "$mode" == "deep" ] && ! [ -f $outputdir/$projectname/$1/.progress/.gobuster ]
  then 
    echo -e "\n${GREEN}[+] gobuster Started on $1${NC}\n"
    gobuster vhost  -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt -u $1 -t 50 --append-domain  -o $outputdir/$projectname/$1/recon/subdomains/gobuster.txt 
    touch $outputdir/$projectname/$1/.progress/.gobuster
  fi 

  #------------------------------------------ Subfinder ----------------------------------------------#
  if [ -x "$(command -v subfinder)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.subfinder ]
  then
    echo -e "${GREEN}[+] subfinder Started on $1${NC}"
    subfinder -d $1 -o $outputdir/$projectname/$1/recon/subdomains/subfinder.txt 
    if [ "$mode" == "deep" ]
    then
      cat $outputdir/$projectname/$1/recon/subdomains/* | sort -u > $outputdir/$projectname/$1/recon/subdomains/tmp.txt
      subfinder -dL $outputdir/$projectname/$1/recon/subdomains/tmp.txt -silent -o $outputdir/$projectname/$1/recon/subdomains/subfinder_recursive.txt
      rm $outputdir/$projectname/$1/recon/subdomains/tmp.txt
    fi
    touch $outputdir/$projectname/$1/.progress/.subfinder
  fi

  endpointsScan $1

  #---------------------------------------------- collect all -----------------------------#
  
  cat $outputdir/$projectname/$1/recon/subdomains/* | sort -u > $outputdir/$projectname/$1/recon/subdomains/all_subs.txt
  echo -e "${GREEN}[+] Found $(wc -l $outputdir/$projectname/$1/recon/subdomains/all_subs.txt | cut -f 1 -d " " ) subdomains for $1 ${NC}"
  echo -e "${GREEN}[+] All subdomains can be found in $outputdir/$projectname/$1/recon/subdomains/all_subs.txt"

  #------------------------------------------- httpx --------------------------------------------------#
  
  if [ -x "$(command -v httpx)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.httpx ]
  then
    echo -e "${GREEN}[+] httpx Started on $1${NC}" 
    if [ "$mode" == "deep" ]
    then
      HTTP_PORTS=$DEEP_MODE_HTTP_PORTS
    fi
    cat $outputdir/$projectname/$1/recon/subdomains/all_subs.txt | httpx -silent -p $HTTP_PORTS -o $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt
    touch $outputdir/$projectname/$1/.progress/.httpx
  fi
}


function subdomainTakeoverScan {
  #------------------------------------------- subzy --------------------------------------------------#
  if [ -x "$(command -v subzy)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.subzy ]
  then
    mkdir -p $outputdir/$projectname/$1/vuln/takeover 
    echo -e "${GREEN}[+] subzy Started on $1${NC}"
    subzy run --hide_fails --vuln --targets $outputdir/$projectname/$1/recon/subdomains/all_subs.txt --output $outputdir/$projectname/$1/vuln/takeover/subzy.json
    touch $outputdir/$projectname/$1/.progress/.subzy
  fi
}

function endpointsScan {
  mkdir -p $outputdir/$projectname/$1/recon/endpoints 
  #------------------------------------------ gau ----------------------------------------------#
  if [ -x "$(command -v gau)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.gau ]
  then
    echo -e "${GREEN}[+] gau Started on $1${NC}"
    cat $outputdir/$projectname/$1/recon/subdomains/all_subs.txt | gau --providers gau,otx,urlscan --subs | sort -u > $outputdir/$projectname/$1/recon/endpoints/gau.txt
    touch $outputdir/$projectname/$1/.progress/.gau
  fi

  #------------------------------------------ waybackurls ----------------------------------------------#
  if [ -x "$(command -v waybackurls)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.waybackurls ]
  then
    echo -e "${GREEN}[+] gau Started on $1${NC}"
    cat $outputdir/$projectname/$1/recon/subdomains/* | sort -u | waybackurls > $outputdir/$projectname/$1/recon/endpoints/waybackurls.txt
    touch $outputdir/$projectname/$1/.progress/.waybackurls
  fi 

  cat $outputdir/$projectname/$1/recon/endpoints/* | cut -f3 -d / | sort -u > $outputdir/$projectname/$1/recon/subdomains/endpoints_subs.txt

}

function endpointsFuzzing {
  #------------------------------------------ Dirsearch ----------------------------------------------#
  
  if [ -x "$(command -v dirsearch)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.dirsearch ]
  then
    echo -e "${GREEN}[+] dirsearch Started on $1${NC}"
        if [ "$mode" == "deep" ]
          then
            dirsearch -l $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt -x 404 -w $SECLISTS/Discovery/Web-Content/directory-list-2.3-medium.txt  -o $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt
    else
        dirsearch -l $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt -x 404,500 -o $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt
      fi
    sed -i '1d' $outputdir/$projectname/$1/recon/endpoints/dirsearch
    cat $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt | cut -d " " -f7 | sort -u >>  $outputdir/$projectname/$1/recon/endpoints/dirsearch_endpoints.txt 
    cat $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt | cut -d " " -f16 | sort -u >>  $outputdir/$projectname/$1/recon/endpoints/dirsearch_endpoints.txt
    touch $outputdir/$projectname/$1/.progress/.dirsearch
  fi
 #------------------------------------------ Parameter scan ----------------------------------------------#
 
 cat $outputdir/$projectname/$1/recon/endpoints/*.txt | cut -d "?" -f1 | sort -u > $outputdir/$projectname/$1/recon/endpoints/all_endpoints.txt
 mkdir -p $outputdir/$projectname/$1/recon/endpoints/param_fuzzing
 if [ -x "$(command -v arjun)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.arjun ]
   then
   arjun -i  $outputdir/$projectname/$1/recon/endpoints/all_endpoints.txt -o $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/arjun.json
   touch $outputdir/$projectname/$1/.progress/.arjun
   fi
   
}

function checkForVulns {

#----------------------------------- ZoneTransfer ------------------------------------------------------#


  if [ -x "$(command -v $SEEKERX_HOME/tools/DNSaxfr/DNSaxfr.sh)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.zonetransfer ]
    then
      printf "${GREEN}[+]  Try ZoneTransfer on $1 ${NC}";
      $SEEKERX_HOME/tools/DNSaxfr/DNSaxfr.sh -r0 $1 >> $outputdir/$projectname/$1/vuln/zonetransfer.txt
      touch $outputdir/$projectname/$1/.progress/.zonetransfer
    fi


#-----------------------------------Get Package.json paths-------------------------------------------------------#


  if [ -x "$(command -v httpx)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.dependency_paths ]
    then
      printf "${GREEN}[+]  Try to find package.json ${NC}";
      cat $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt | httpx -silent -path /package.json -mc 200 -o $outputdir/$projectname/$1/recon/endpoints/dependency_paths.txt
      touch $outputdir/$projectname/$1/.progress/.dependency_paths
    fi

#-----------------------------------Check Dependency Confusion-------------------------------------------------------#

  if [ -s $outputdir/$projectname/$1/vuln/dependency_paths.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.dependency_confusion ]
    then
      if [ -x "$(command -v $SEEKERX_HOME/tools/DepFine/DepFine.py)" ]
        then
          mkdir $outputdir/$projectname/$1/vuln/dependency_confusion
            printf "\n${GREEN}[+]  Try to Confusion Dependencies  from collected package.json files ${NC}\n";
            dependency_paths=$(cat $outputdir/$projectname/$1/recon/endpoints/dependency_paths.txt);
            counter=1;
            for i in $dependency_paths
              do
                (( counter++ ));
                python3 $SEEKERX_HOME/tools/DepFine/DepFine.py $i >> $outputdir/$projectname/$1/vuln/dependency_confusion/$counter.txt ;
              done
        fi
      touch $outputdir/$projectname/$1/.progress/.dependency_confusion
    fi

#----------------------------------- nuclei -----------------------------------------------#

  if [ -x "$(command -v nuclei)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.nuclei ]
    then
      printf "\n${GREEN}[+]  nuclei Started ${NC}\n";
      cat $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt | nuclei -t $Nuclei_Templates_Path -o $outputdir/$projectname/$1/vuln/nuclei.txt
      touch $outputdir/$projectname/$1/.progress/.nuclei
    fi      

#----------------------------------- Detect Wordpress -----------------------------------------------#

  if [ -f $outputdir/$projectname/$1/vuln/nuclei.txt ]
  then
    mkdir $outputdir/$projectname/$1/recon/wordpress
    cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep "wordpress-detect" | cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt  
    
#----------------------------------- Scan Wordpress -----------------------------------------------#

  if [ -f $SEEKERX_HOME/tools/wpconfig-checker.py ] && [ -x "$(command -v wpscan)" ] && [ -x "$(command -v python)" ] && [-f $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt ]
  then
    python3 $SEEKERX_HOME/tools/wpconfig-checker.py -f $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt 
  fi
}
function scan {
  echo -e "${BLUE}${BOLD}[+] Scanning domain: ${GREEN}$1${NC}"
  # SubDomains Finding 
  mkdir -p $outputdir/$projectname/$1/.progress
  subdomainsScan $1
  endpointsFuzzing $1
  subdomainTakeoverScan $1
  checkForVulns $1 
   
}


# -----------------------------------------------------------------------------------
outputdir=$(pwd)
mode="fast"
HTTP_PORTS=$FAST_MODE_HTTP_PORTS
banner
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--projectname) projectname="$2"; shift ;;
        -d|--domainfile) domainfile="$2"; shift ;;
        -o|--outputdir) outputdir="$2"; shift ;;
        -h|--help) usage ;; 
        -m|--mode) mode="$2"; shift ;;
        -c|--check) checkForTools; exit 1 ;;
        *) echo -e "${RED}[-] Unknown parameter passed: $1"; usage; exit 1 ;;
    esac
    shift
done

if [ -z "$projectname" ] || [ -z "$domainfile" ]; then
  usage
fi


checkForTools

mkdir -p $outputdir/$projectname


while read -r domain; do
  scan "$domain"
done < $domainfile

