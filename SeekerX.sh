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
  echo -e "${GREEN} SeekerX -  Reconnaissance & Scanning tool by Aly Khaled (0x41ly) & Mohamed Abdelhady${NC}"
  echo ""
  sleep 5
}

function usage {
  echo -e "\n${BLUE}${BOLD}Usage${NC}: ${GREEN}$0${NC} ${YELLOW}-p${NC} projectname ${YELLOW}-d${NC} domainfilepath [${YELLOW}-o${NC} outputdir]\n"
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
  if ! [ -f $HOOK_HOME/hoOk.py ]
  then
    echo -e "\n${RED}[-]---------- hoOk not found ----------[-]${NC}\n"
    echo -e "${RED}[-] Download it from https://github.com/mrxdevil404/hoOk.git${NC}"
    echo -e "${RED}[-] Make sure you define it path correctly in config.conf ${NC}\n"
  fi

  if ! [ -x "$(command -v subfinder)" ]
  then
    echo -e "\n${RED}[-]---------- subfinder not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest'${NC}\n"
  fi

  # if ! [ -x "$(command -v sublist3r)" ]
  # then
  #   echo -e "${RED}[-]---------- sublist3r not found ----------[-]${NC}"
  #   echo -e "${RED}[-] Download it with 'pip3 install sublist3r'${NC}"
  # fi

  if ! [ -x "$(command -v assetfinder)" ]
  then
    echo -e "\n${RED}[-]---------- assetfinder not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/tomnomnom/assetfinder@latest'${NC}\n"
  fi

  # if ! [ -x "$(command -v amass)" ]
  #   then
  #     echo -e "${RED}[-]---------- amass not found ----------[-]"
  #     echo -e "${RED}[-] Download it with 'go install -v github.com/owasp-amass/amass/v3/...@master'${NC}"
  #   fi

  if ! [ -x "$(command -v gobuster)" ]
    then 
      echo -e "\n${RED}[-]---------- gobuster not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install github.com/OJ/gobuster/v3@latest'${NC}\n"
    fi

  if ! [ -d "$SECLISTS" ]
   then
    echo -e "\n${RED}[-]---------- seclists not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it from https://github.com/danielmiessler/SecLists${NC}"
    echo -e "${RED}[-] Add its path to the config file${NC}\n"
  fi

  if ! [ -x "$(command -v subzy)" ]
    then 
      echo -e "\n${RED}[-]---------- subzy not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install -v github.com/LukaSikic/subzy@latest'${NC}\n"
    fi

  if ! [ -x "$(command -v gau)" ]
    then 
      echo -e "\n${RED}[-]---------- gau not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install github.com/lc/gau/v2/cmd/gau@latest'${NC}\n"
    fi

  # if ! [ -x "$(command -v waybackurls)" ]
  #   then 
  #     echo -e "\n${RED}[-]---------- waybackurls not found ----------[-]${NC}"
  #     echo -e "${RED}[-] Download it with 'go install -v github.com/tomnomnom/waybackurls@latest'${NC}\n"
  #   fi

  if ! [ -x "$(command -v httpx)" ]
    then 
      echo -e "\n${RED}[-]---------- httpx not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it with 'go install github.com/projectdiscovery/httpx/cmd/httpx@latest'${NC}\n"
    fi

  # if ! [ -f $SEEKERX_HOME/tools/DepFine/DepFine.py ]
  #   then 
  #     echo -e "\n${RED}[-]---------- DepFine not found ----------[-]${NC}"
  #     echo -e "${RED}[-] Download it with 'git clone https://github.com/M359AH/DepFine.git '${NC}\n"
  #   fi

    if ! [ -x "$(command -v confused)" ]
  then
    echo -e "\n${RED}[-]---------- confused not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/visma-prodsec/confused@latest'${NC}\n"
  fi
  

  if ! [ -x "$(command -v nuclei)" ]
  then
    echo -e "\n${RED}[-]---------- nuclei not found ----------[-]${NC}"
    echo -e "${RED}[-] Download it with 'go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest'${NC}\n"
  fi


  # if ! [ -x "$(command -v dirsearch)" ]
  #   then
  #     echo -e "${RED}[-]---------- dirsearch not found ----------[-]${NC}"
  #     echo -e "${RED}[-] Download it by 'pip3 install dirsearch'${NC}"
  #   fi

  # if ! [ -x "$(command -v arjun)" ]
  #   then
  #     echo -e "\n${RED}[-]---------- arjun not found ----------[-]${NC}"
  #     echo -e "${RED}[-] Download it by 'pip3 install arjun'${NC}\n"
  #   fi

  if ! [ -f $SEEKERX_HOME/tools/wpconfig-checker.py ]
    then
      echo -e "\n${RED}[-]---------- wpconfig-checker not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'wget https://raw.githubusercontent.com/mohamedabdelhady933/Wordpress-Config-Enum/main/wpconfig-checker.py'${NC}"
      echo -e "${RED}[-] Place it in the tools folder\n"
    fi

    if ! [ -x "$(command -v wpscan)" ]
    then
      echo -e "\n${RED}[-]---------- wpscan not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'gem install wpscan'${NC}\n"
    fi
    
    if ! [ -x "$(command -v gospider)" ]
    then
      echo -e "\n${RED}[-]---------- gospider not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'go install -v github.com/jaeles-project/gospider@latest'${NC}\n"
    fi

    if ! [ -x "$(command -v kxss)" ]
    then
      echo -e "\n${RED}[-]---------- kxss not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'go install -v github.com/Emoe/kxss@latest'${NC}\n"
    fi
    
    if ! [ -x "$(command -v gf)" ]
    then
      echo -e "\n${RED}[-]---------- gf not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it by 'go get -u github.com/tomnomnom/gf'${NC}\n"
    fi

    if ! [ -x "$(command -v gitdorks_go)" ] 
    then
      echo -e "\n${RED}[-]---------- gitdorks_go not found ----------[-]${NC}"
      echo -e "${RED}[-] Download it from 'https://github.com/damit5/gitdorks_go' and place it in the tools dir and build it${NC}\n"
    fi 
  echo -e "\n${GREEN}[+] Tools Check Done!!\n"

  
  
}

function subdomainsScan {
  echo -e "\n${YELLOW}[+] The Project saved in $outputdir/$projectname/$1 \n"
  mkdir -p $outputdir/$projectname/$1/recon/subdomains
  echo -e "${YELLOW}[+] Passive subdomains scanning for $1${NC}\n"

  #------------------------------------------ hoOk ----------------------------------------------#
  if [ -f $HOOK_HOME/hoOk.py ] && ! [ -f $outputdir/$projectname/$1/.progress/.hook ]
  then
    echo -e "\n${GREEN}[+] hoOk Started on $1${NC}\n"
    currentplace="$(pwd)"
    cd $HOOK_HOME
    python3 hoOk.py -t $1 
    cd $currentplace
    mv $HOOK_HOME/${1}-subdomains.txt $outputdir/$projectname/$1/recon/subdomains/hoOk.txt
    cat $HOOK_HOME/censys_domains.txt | grep $1 >> $outputdir/$projectname/$1/recon/subdomains/censys_domains.txt
    touch $outputdir/$projectname/$1/.progress/.hook
  else
     echo -e "\n${RED}[-] hoOk doesn't work ${NC}\n"
  fi


  #------------------------------------------- sublist3r --------------------------------------------------#
  
  # if [ -x "$(command -v sublist3r)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.sublist3r ]
  # then
  #   echo -e "${GREEN}[+] sublist3r Started on $1${NC}"
  #   sublist3r -d $1 -o $outputdir/$projectname/$1/recon/subdomains/sublist3r.txt 
  #   touch $outputdir/$projectname/$1/.progress/.sublist3r
  # fi

  #------------------------------------------- assetfinder --------------------------------------------------#
  if [ -x "$(command -v assetfinder)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.assetfinder ]
  then
    echo -e "\n${GREEN}[+] assetfinder Started on $1${NC}\n"
    assetfinder --subs-only $1 >> $outputdir/$projectname/$1/recon/subdomains/assetfinder.txt 
    touch $outputdir/$projectname/$1/.progress/.assetfinder
  else
     echo -e "\n${RED}[-] assetfinder doesn't work ${NC}\n"
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
  else
     echo -e "\n${RED}[-] gobuster doesn't work ${NC}\n"
  fi 

  #------------------------------------------ Subfinder ----------------------------------------------#
  if [ -x "$(command -v subfinder)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.subfinder ]
  then
    echo -e "\n${GREEN}[+] subfinder Started on $1${NC}\n"

    check_all_option=$(subfinder -all 2>&1)
    if [[ $check_all_option == *"flag provided but not defined: -all"* ]]
    then
    	subfinder -silent -d $1  -o $outputdir/$projectname/$1/recon/subdomains/subfinder.txt
     else
    	subfinder -silent -d $1 -all -o $outputdir/$projectname/$1/recon/subdomains/subfinder.txt 
     fi

    touch $outputdir/$projectname/$1/.progress/.subfinder
  else
     echo -e "\n${RED}[-] subfinder doesn't work ${NC}\n"
  fi

  # -----------------------------Collect Subdomains of Subdomains------------------------------------------------------------
if [ -x "$(command -v subfinder)" ] 
then
	echo -e "\n${GREEN}[+] Subfinder Collecting Subdomains of Subdomains on $1${NC}\n"
	subfinder -silent -dL $outputdir/$projectname/$1/recon/subdomains/*.txt -o $outputdir/$projectname/$1/recon/subdomains/subs_of_subs_subfinder.txt
else
        echo -e "\n${RED}[-] subfinder doesn't work ${NC}\n"
 	
fi

#Need to edit
# if [ -x "$(command -v ffuf)" ] 
# then
# 	echo -e "\n${GREEN}[+] FFUF Collecting Subdomains of Subdomains on $1${NC}\n"
#  	for i in $(cat $outputdir/$projectname/$1/recon/subdomains/*.txt)
#   	do
#    		ffuf -u https://FUZZ.$i -w  $SECLISTS/Discovery/Web-Content/raft-small-directories.txt >> $outputdir/$projectname/$1/recon/subdomains/subs_of_subs_ffuf_tmp.txt
#  		cat $outputdir/$projectname/$1/recon/subdomains/subs_of_subs_ffuf_tmp.txt | grep  "FUZZ" | cut -d ' ' -f7 | sort -u 
# fi



  
  clear
  banner
  endpointsScan $1

  #---------------------------------------------- collect all -----------------------------#
  
  cat $outputdir/$projectname/$1/recon/subdomains/*.txt | sort -u > $outputdir/$projectname/$1/recon/subdomains/all_subs.txt
  echo -e "\n${GREEN}[+] Found $(wc -l $outputdir/$projectname/$1/recon/subdomains/all_subs.txt | cut -f 1 -d " " ) subdomains for $1 ${NC}\n"
  echo -e "\n${GREEN}[+] All subdomains can be found in $outputdir/$projectname/$1/recon/subdomains/all_subs.txt \n"
  sleep 3
  clear

  #------------------------------------------- httpx --------------------------------------------------#
  
  if [ -x "$(command -v httpx)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.httpx ]
  then
    echo -e "\n${GREEN}[+] httpx Started on $1${NC}\n" 
    if [ "$mode" == "deep" ]
    then
      HTTP_PORTS=$DEEP_MODE_HTTP_PORTS
    fi
    cat $outputdir/$projectname/$1/recon/subdomains/all_subs.txt | httpx -silent -p $HTTP_PORTS -o $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt
    touch $outputdir/$projectname/$1/.progress/.httpx
  else
     echo -e "\n${RED}[-] httpx doesn't work ${NC}\n"
  fi
}


function subdomainTakeoverScan {
  #------------------------------------------- subzy --------------------------------------------------#
  if [ -x "$(command -v subzy)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.subzy ]
  then
    mkdir -p $outputdir/$projectname/$1/vuln/takeover 
    echo -e "\n${GREEN}[+] Subzy Started on $1${NC}\n"
    subzy run --hide_fails --vuln --targets $outputdir/$projectname/$1/recon/subdomains/all_subs.txt --output $outputdir/$projectname/$1/vuln/takeover/subzy.json
    touch $outputdir/$projectname/$1/.progress/.subzy
  else
     echo -e "\n${RED}[-] subzy doesn't work ${NC}\n"
  fi
}

function endpointsScan {
   
  #------------------------------------------ gau ----------------------------------------------#
  if [ -x "$(command -v gau)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.gau ]
  then
    mkdir -p $outputdir/$projectname/$1/recon/endpoints
    echo -e "\n${GREEN}[+] gau Started on $1${NC}\n"
    cat $outputdir/$projectname/$1/recon/subdomains/*.txt | sort -u | gau --providers gau,otx,urlscan --subs | sort -u > $outputdir/$projectname/$1/recon/endpoints/gau.txt
    touch $outputdir/$projectname/$1/.progress/.gau
  else
     echo -e "\n${RED}[-] gau doesn't work ${NC}\n"
  fi

  #------------------------------------------ waybackurls ----------------------------------------------#
  # if [ -x "$(command -v waybackurls)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.waybackurls ]
  # then
  #   echo -e "${GREEN}[+] wayabackurls Started on $1${NC}"
  #   cat $outputdir/$projectname/$1/recon/subdomains/*.txt | sort -u | waybackurls > $outputdir/$projectname/$1/recon/endpoints/waybackurls.txt
  #   touch $outputdir/$projectname/$1/.progress/.waybackurls
  # fi 

  cat $outputdir/$projectname/$1/recon/endpoints/*.txt | cut -f3 -d / | sort -u > $outputdir/$projectname/$1/recon/subdomains/endpoints_subs.txt

}

function endpointsFuzzing {
  #------------------------------------------ Dirsearch ----------------------------------------------#
  
  # if [ -x "$(command -v dirsearch)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.dirsearch ]
  # then
  #   echo -e "${GREEN}[+] dirsearch Started on $1${NC}"
  #       if [ "$mode" == "deep" ]
  #         then
  #           dirsearch -l $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt -x 404 -w $SECLISTS/Discovery/Web-Content/directory-list-2.3-medium.txt  -o $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt
  #   else
  #       dirsearch -l $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt -x 404,500 -o $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt
  #     fi
  #   sed -i '1d' $outputdir/$projectname/$1/recon/endpoints/dirsearch
  #   cat $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt | cut -d " " -f7 | sort -u >>  $outputdir/$projectname/$1/recon/endpoints/dirsearch_endpoints.txt 
  #   cat $outputdir/$projectname/$1/recon/endpoints/dirsearch.txt | cut -d " " -f16 | sort -u >>  $outputdir/$projectname/$1/recon/endpoints/dirsearch_endpoints.txt
  #   touch $outputdir/$projectname/$1/.progress/.dirsearch
  # fi

#------------------------------------------ js collect ----------------------------------------------#

 if [ -f "$outputdir/$projectname/$1/recon/endpoints/gau.txt" ]
 then
    
    echo -e "\n${GREEN}[+] Start Collect Javascript files${NC}\n"
    mkdir -p $outputdir/$projectname/$1/recon/endpoints/js
    # if get an error edit it to cat $outputdir/$projectname/$1/recon/endpoints/*.txt
    cat $outputdir/$projectname/$1/recon/endpoints/*.txt | grep "\.js$"| cut -d '?' -f 1 >> $outputdir/$projectname/$1/recon/endpoints/js/endpoints_js.txt
else
     echo -e "\n${RED}[-] js collecting doesn't work ${NC}\n"
fi

if [ -x "$(command -v gospider)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.gospider ]
then       
 	gospider -s https://$1 | grep $1 | grep "\.js$" | cut -d '?' -f 1 | awk -F"http" '{print "http"$2}' >> $outputdir/$projectname/$1/recon/endpoints/js/gospider.txt
	touch $outputdir/$projectname/$1/.progress/.gospider
else
        echo -e "\n${RED}[-] gospider doesn't work ${NC}\n"
fi

cat $outputdir/$projectname/$1/recon/endpoints/js/* | sort -u | httpx -silent -mc 200  >> $outputdir/$projectname/$1/recon/endpoints/js/all_js.txt

  #------------------------------------------ JS leaks Scan  ------------------------------------------------------
  
if [ -x "$(command -v nipejs)" ] &&  [ -f $SEEKERX_HOME/tools/regex.txt ] &&  [ -f $outputdir/$projectname/$1/recon/endpoints/js/all_js.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.js_leak ]
then
    	echo -e "\n${GREEN}[+] Start Search in Javascript files ${NC}\n"
    	mkdir -p $outputdir/$projectname/$1/vuln/javascript/
     	touch $outputdir/$projectname/$1/vuln/javascript/javascript_leaks.txt
   	cat $outputdir/$projectname/$1/recon/endpoints/js/all_js.txt | nipejs -r $SEEKERX_HOME/tools/regex.txt >> $outputdir/$projectname/$1/vuln/javascript/javascript_leaks.txt
    
    # python3 $SEEKERX_HOME/tools/JS-Leaks.py -f $outputdir/$projectname/$1/recon/endpoints/js/all_js.txt -o $outputdir/$projectname/$1/vuln/javascript/ 2>/dev/null
    # mv $outputdir/$projectname/$1/vuln/js_endpoinnts.txt $outputdir/$projectname/$1/recon/endpoints/
    #  if [ -x "$(command -v httpx)" ] && [ -f $outputdir/$projectname/$1/recon/endpoints/js_endpoinnts.txt ]
    # then
    #   cat $outputdir/$projectname/$1/recon/endpoints/js_endpoinnts.txt | httpx -silent  -mc 200 -o $outputdir/$projectname/$1/recon/endpoints/js_endpoinnts_live.txt
    #   rm $outputdir/$projectname/$1/recon/endpoints/js_endpoinnts.txt
    # fi
    	touch $outputdir/$projectname/$1/.progress/.js_leak
else
     echo -e "\n${RED}[-] nipejs doesn't work ${NC}\n"
fi
  
  
 #------------------------------------------ Parameter scan ----------------------------------------------#
 
 echo -e "\n${GREEN}[+] Start parameters Collecting ${NC}\n"
 

 mkdir -p $outputdir/$projectname/$1/recon/endpoints/param_fuzzing
cat $outputdir/$projectname/$1/recon/endpoints/*.txt | sort -u | grep "?" > $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/static_params.txt

if [ -x "$(command -v gospider)" ] &&  [ -f $outputdir/$projectname/$1/recon/subdomains/all_subs.txt ]
    then       
      gospider -S $outputdir/$projectname/$1/recon/subdomains/all_subs.txt | grep $1 | grep "?" >> $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/gospider_params.txt
    fi

# Arjun Tooooooo slow

 # if [ -x "$(command -v arjun)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.arjun ]
 #   then
 #   arjun -i  $outputdir/$projectname/$1/recon/endpoints/all_endpoints.txt -o $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/arjun.json
   
 #   touch $outputdir/$projectname/$1/.progress/.arjun
 #   fi

 #----------------------------------- XSS Scan--------------------------------------------#
 
if [ -x "$(command -v kxss)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.kxss ]
then
      	mkdir -p $outputdir/$projectname/$1/vuln/
	echo -e "\n${GREEN}[+] Collect possible XSS ${NC}\n"
      	cat $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/*.txt | kxss >> $outputdir/$projectname/$1/vuln/kxss.txt
      	touch $outputdir/$projectname/$1/.progress/.kxss
else
     echo -e "\n${RED}[-] kxss doesn't work ${NC}\n"
fi
#----------------------------------- SSRF Scan--------------------------------------#
  
  if [ -x "$(command -v gf)" ] && [ -x "$(command -v gau)" ] && [ -d ~/.gf ] && ! [ -f $outputdir/$projectname/$1/.progress/.ssrf-possible ]
  then
    echo -e "\n${GREEN}[+] Collect possible SSRF${NC}\n"
    
    cat $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/*.txt | sort -u  | gf ssrf | tee -a $outputdir/$projectname/$1/vuln/ssrf-possible.txt
    touch $outputdir/$projectname/$1/.progress/.ssrf-possible
else
     echo -e "\n${RED}[-] gf doesn't work ${NC}\n"
  fi

#-------------------------------------------- LFI Scan------------------------------------------#
  
  if [ -x "$(command -v gf)" ] && [ -d ~/.gf ] && ! [ -f $outputdir/$projectname/$1/.progress/.lfi-possible ]
  then
    echo -e "\n${GREEN}[+] Collect possible LFI${NC}\n"
    cat $outputdir/$projectname/$1/recon/endpoints/param_fuzzing/*.txt | sort -u  | gf lfi | tee -a $outputdir/$projectname/$1/vuln/lfi-possible.txt
    touch $outputdir/$projectname/$1/.progress/.lfi-possible
  else
     echo -e "\n${RED}[-] gf doesn't work ${NC}\n" 
  fi
  
  #----------------------------------- Google Dorks-----------------------------------------------#
  
  if [ -f $SEEKERX_HOME/tools/Fast-Google-Dorks-Scan/FGDS.sh ] && ! [ -f $outputdir/$projectname/$1/.progress/.google-dorks ]
  then 
    echo -e "\n${GREEN}[+] Scan for Google Dorks ${NC}\n"
    mkdir -p $outputdir/$projectname/$1/recon/Dorks
    bash $SEEKERX_HOME/tools/Fast-Google-Dorks-Scan/FGDS.sh $1 >> $outputdir/$projectname/$1/recon/Dorks/google_dorks.txt
    rm -fr $SEEKERX_HOME/outputs
    touch $outputdir/$projectname/$1/.progress/.google-dorks
  else
     echo -e "\n${RED}[-] Fast-Google-Dorks-Scan doesn't work ${NC}\n"
  fi

  #----------------------------------- Github Dorks-----------------------------------------------#

  if [ -x "$(command -v gitdorks_go)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.git-dorks ] && ! [ $GITHUB_TOKENS == "" ]
  then
        echo -e "\n${GREEN}[+] Scan for Github Dorks ${NC}\n"
	gitdorks_go -gd $SEEKERX_HOME/tools/gitdorks_go/Dorks/smalldorks.txt -nws 25 -target $1 -token $GITHUB_TOKENS -ew 5 >> $outputdir/$projectname/$1/recon/Dorks/git_dorks.txt
   	touch $outputdir/$projectname/$1/.progress/.git-dorks
  else
     echo -e "\n${RED}[-] gitdorks_go doesn't work ${NC}\n"
  fi

  
}







function checkForVulns {


#-----------------------------------Get Package.json paths-------------------------------------------------------#


  if [ -x "$(command -v httpx)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.dependency_paths ]
    then
      printf "\n${GREEN}[+]  Try to find package.json ${NC}\n";
      
      cat $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt | httpx -silent -path /package.json -mc 200 -ms dependencies -ms version -ms devDependencies -o $outputdir/$projectname/$1/recon/endpoints/dependency_paths.txt
      touch $outputdir/$projectname/$1/.progress/.dependency_paths
    else
     echo -e "\n${RED}[-] httpx doesn't work ${NC}\n"
    fi

#-----------------------------------Check Dependency Confusion-------------------------------------------------------#

  if [ -s $outputdir/$projectname/$1/vuln/dependency_paths.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.dependency_confusion ] && [ -x "$(command -v confused)" ]
    then
          mkdir $outputdir/$projectname/$1/vuln/dependency_confusion
          printf "\n${GREEN}[+]  Try to Confusion Dependencies  from collected package.json files ${NC}\n\n";
          dependency_paths=$(cat $outputdir/$projectname/$1/recon/endpoints/dependency_paths.txt);
            counter=0;
            for i in $dependency_paths
              do
	      	depDmain=$(echo $i |cut -d '/' -f 3);
                (( counter++ ));
		wget $i -q -O $counter.json ;
                confused $counter.json >> $depDmain.txt ;
        	rm $counter.json;
              done
      touch $outputdir/$projectname/$1/.progress/.dependency_confusion
   else
     echo -e "\n${RED}[-] confused doesn't work ${NC}\n"
    fi
#----------------------------------- Shodan IPs -----------------------------------------------#
  if [ -x "$(command -v uncover)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.uncover ] &&  [ "$SHODAN_API_KEY" != "" ]
  then
    echo -e "${GREEN}[+] Start Shodan Scanning ${NC}"
    export SHODAN_API_KEY=$SHODAN_API_KEY
    echo "ssl:$1" | uncover -e shodan >> $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt
    touch $outputdir/$projectname/$1/.progress/.uncover
  else
     echo -e "\n${RED}[-] uncover doesn't work ${NC}\n"
fi

  
#----------------------------------- nuclei -----------------------------------------------#

  if [ -x "$(command -v nuclei)" ] && ! [ -f $outputdir/$projectname/$1/.progress/.nuclei ]
  then
      printf "\n${GREEN}[+]  Nuclei Scanning ${NC}\n";
      cat $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt | nuclei -silent -eid missing-csp,detect-dns-over-https,ssrf-by-proxy,insecure-cipher-suite-detect,dns-saas-service-detection,mx-service-detector,dnssec-detection,dmarc-detect,tls-sni-proxy,robots-txt-endpoint,robots-txt-endpoint,dns-waf-detect,http-missing-security-headers,httponly-cookie-detect,revoked-ssl-certificate,untrusted-root-certificate,weak-cipher-suites,ssl-dns-names,deprecated-tls,expired-ssl,kubernetes-fake-certificate,self-signed-ssl,ssl-dns-names,mismatched-ssl-certificate,httponly-cookie-detect,xss-deprecated-header,tls-version,caa-fingerprint,cname-fingerprint,mx-fingerprint,nameserver-fingerprint,ptr-fingerprint,txt-fingerprint  -t $Nuclei_Templates_Path -o $outputdir/$projectname/$1/vuln/nuclei.txt
      touch $outputdir/$projectname/$1/.progress/.nuclei
  else
     echo -e "\n${RED}[-] nuclei doesn't work ${NC}\n"
  fi      

#----------------------------------- Detect Wordpress -----------------------------------------------#

  if [ -s $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.wordpress_detect ] 
  then
    echo -e "${GREEN}[+] Start Collect Wordpress Subdomains ${NC}"
    mkdir $outputdir/$projectname/$1/recon/wordpress
    cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep -iE "(\[wordpress|wordpress-detect)" | cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt  
    touch $outputdir/$projectname/$1/.progress/.wordpress_detect
  else
     echo -e "\n${RED}[-] couldn't detect wordpress subdomains from nuclei file ${NC}\n"
  fi
#----------------------------------- Scan Wordpress -----------------------------------------------#

  if [ -f $SEEKERX_HOME/tools/wpconfig-checker.py ] && [ -x "$(command -v wpscan)" ] && [ -x "$(command -v python3)" ]  &&  [ -f $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt ] && [ -s "$outputdir/$projectname/$1/vuln/nuclei.txt" ] && ! [ -f $outputdir/$projectname/$1/.progress/.wordpress_scan ]
  then
    echo -e "${GREEN}[+] Scanning Wordpress Subdomains ${NC}"

    if  [ "$WordPress_Api" != "" ]
    then
      python3 $SEEKERX_HOME/tools/wpconfig-checker.py  -a $WordPress_Api -f $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt >> $outputdir/$projectname/$1/vuln/wordpress.txt
    else
      python3 $SEEKERX_HOME/tools/wpconfig-checker.py -f $outputdir/$projectname/$1/recon/wordpress/wordpress-subdomains.txt >> $outputdir/$projectname/$1/vuln/wordpress.txt
    fi
    touch $outputdir/$projectname/$1/.progress/.wordpress_scan
  else
     echo -e "\n${RED}[-] wpconfig-checker.py doesn't work ${NC}\n"
  fi
#-----------------------------------drupal Detect-----------------------------------------------#

if [ -s $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.drupal_detect ]
then
  echo -e "${GREEN}[+] Start Collect Drupal Subdomains ${NC}"
  mkdir $outputdir/$projectname/$1/recon/drupal
    cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep -iE "(\[drupal|drupal-detect)"| cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/drupal/drupal-subdomains.txt  
 touch $outputdir/$projectname/$1/.progress/.drupal_detect
 else
     echo -e "\n${RED}[-] couldn't detect drupal subdomains in nuclei file ${NC}\n"
 fi
#-----------------------------------drupal scan-----------------------------------------------#

if [ -s  $outputdir/$projectname/$1/recon/drupal/drupal-subdomains.txt ]  && ! [ -f $outputdir/$projectname/$1/.progress/.drupal_scan ] && [  -s "$outputdir/$projectname/$1/vuln/nuclei.txt" ]
then
  echo -e "${GREEN}[+] Scanning drupal Subdomains ${NC}"
  current_dir=$(pwd)
  cd $SEEKERX_HOME/tools/droopescan
  python3 droopescan scan drupal -U $outputdir/$projectname/$1/recon/drupal/drupal-subdomains.txt -t 32 -e a >> $outputdir/$projectname/$1/vuln/drupal.txt 
  cd $current_dir  
  touch $outputdir/$projectname/$1/.progress/.drupal_scan
else
  echo -e "\n${RED}[-] droopescan doesn't work ${NC}\n"
fi

#-----------------------------------joomla Detect-----------------------------------------------#
if [ -s $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.joomla_detect ]  && ! [ -f $outputdir/$projectname/$1/.progress/.drupal_scan ]
then
  echo -e "${GREEN}[+] Start Collect Joomla Subdomains ${NC}"
  mkdir $outputdir/$projectname/$1/recon/joomla
  cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep -iE "(\[joomla|joomla-detect)"| cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/joomla/joomla-subdomains.txt  
 touch $outputdir/$projectname/$1/.progress/.joomla_detect
 else
     echo -e "\n${RED}[-] couldn't detect joomla subdomains in nuclei file ${NC}\n"
 fi
#-----------------------------------joomla scan-----------------------------------------------#

if [ -s  $outputdir/$projectname/$1/recon/joomla/joomla-subdomains.txt ]  && ! [ -f $outputdir/$projectname/$1/.progress/.joomla_scan ] && [ -f $SEEKERX_HOME/tools/joomscan/joomscan.pl ]  
then
  echo -e "${GREEN}[+] Scanning Joomla Subdomains ${NC}"
  current_dir=$(pwd)
  cd $SEEKERX_HOME/tools/joomscan
  perl joomscan.pl -m $outputdir/$projectname/$1/recon/joomla/joomla-subdomains.txt -ec
  if [ -d "./reports" ]
  then
  mkdir $outputdir/$projectname/$1/vuln/joomla
  #edit done
  mv ./reports/*$1/*.txt $outputdir/$projectname/$1/vuln/joomla
  fi
  cd $current_dir
  touch $outputdir/$projectname/$1/.progress/.joomla_scan
else
     echo -e "\n${RED}[-] joomscan doesn't work ${NC}\n"
fi
#-----------------------------------AEM Detect-----------------------------------------------#

if  [ -s $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.aem_detect ] && [ -f $SEEKERX_HOME/tools/aem-hacker/aem_discoverer.py ]
then
  echo -e "${GREEN}[+] Start Collect AEM adobe Subdomains ${NC}"
  mkdir $outputdir/$projectname/$1/recon/AEM
  python3 $SEEKERX_HOME/tools/aem-hacker/aem_discoverer.py --file $outputdir/$projectname/$1/recon/subdomains/live_hosts.txt >> $outputdir/$projectname/$1/recon/AEM/aem_subdomains.txt
 touch $outputdir/$projectname/$1/.progress/.aem_detect
else
     echo -e "\n${RED}[-] aem_discover.py doesn't work ${NC}\n"
 fi
#-----------------------------------AEM scan-----------------------------------------------#

if [ -s  $outputdir/$projectname/$1/recon/AEM/aem_subdomains.txt ]  && ! [ -f $outputdir/$projectname/$1/.progress/.aem_scan ] && [ -f $SEEKERX_HOME/tools/aem-hacker/aem_hacker.py ] 
then
  echo -e "${GREEN}[+] Scanning AEM Subdomains ${NC}"
  if [ $BURPCOLLAP_OR_ANY_IP_YOU_CONTROL == ""]
    then
      BURPCOLLAP_OR_ANY_IP_YOU_CONTROL="dummy.domain"
    fi
  mkdir $outputdir/$projectname/$1/vuln/aem 
  counter=1;
  for url in $(cat $outputdir/$projectname/$1/recon/AEM/aem_subdomains.txt);
    do
    ((counter++))
    python3 $SEEKERX_HOME/tools/aem-hacker/aem_hacker.py -u $url --host $BURPCOLLAP_OR_ANY_IP_YOU_CONTROL >>  $outputdir/$projectname/$1/vuln/aem/$counter
    done

  touch $outputdir/$projectname/$1/.progress/.aem_scan
else
     echo -e "\n${RED}[-] aem_hacker.py doesn't work ${NC}\n"
fi
#-----------------------------------Cpanel Detect-----------------------------------------------#

if [ -s $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.Cpanel_detect ]  
then
  echo -e "${GREEN}[+] Collect Cpanel Subdomains ${NC}"
  
  mkdir $outputdir/$projectname/$1/recon/Cpanel
    cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep -iE "(\[cpanel|cpanel-detect)" | cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/Cpanel/Cpanel-subdomains.txt  
 touch $outputdir/$projectname/$1/.progress/.Cpanel_detect
else
     echo -e "\n${RED}[-] couldn't detect cpanel subdomains in nuclei file ${NC}\n"
 fi
 #-----------------------------------Cpanel scan-----------------------------------------------#


# Just nuclei till now , Maybe add more next version




# ------------------------------------Jira Detect-----------------------------------------------------
if [ -s $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.Jira_detect ]
then
  echo -e "${GREEN}[+] Collect Jira Subdomains ${NC}"
  mkdir $outputdir/$projectname/$1/recon/Jira
  cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep -iE "(\[jira|jira-detect)" | cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/Jira/Jira-subdomains.txt
  touch $outputdir/$projectname/$1/.progress/.Jira_detect
else
     echo -e "\n${RED}[-] couldn't detect jira subdomains in nuclei file ${NC}\n"
fi

# ------------------------------------Jira Scan-----------------------------------------------------

# Just nuclei scan and maybe add more next version

# if [ -f  $outputdir/$projectname/$1/recon/Jira/Jira-subdomains.txt ]  && ! [ -f $outputdir/$projectname/$1/.progress/.Jira_scan ] 
# then
#   mkdir $outputdir/$projectname/$1/vuln/Jira
#   cat $outputdir/$projectname/$1/vuln/nuclei.txt |  grep  "jira-detect"| cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/vuln/Jira/Jira.txt
  
#   touch $outputdir/$projectname/$1/.progress/.Jira_scan
# fi




# ------------------------------------Grafana Detect-----------------------------------------------------
if [ -s $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.Grafana_detect ] 
then
  echo -e "${GREEN}[+] Collect Grafana Subdomains ${NC}"
  mkdir $outputdir/$projectname/$1/recon/Grafana
  cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep -iE "(\[grafana|grafana-detect)" | cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/recon/Grafana/Grafana-subdomains.txt
  touch $outputdir/$projectname/$1/.progress/.Grafana_detect
else
     echo -e "\n${RED}[-] couldn't detect grafana subdomains in nuclei file ${NC}\n"
fi


# ------------------------------------Grafana Scan-----------------------------------------------------

# Just nuclei scan and maybe add more next version

 # if [ -f $outputdir/$projectname/$1/vuln/nuclei.txt ] && ! [ -f $outputdir/$projectname/$1/.progress/.Grafana_scan ]
 # then
 #   mkdir $outputdir/$projectname/$1/vuln/Grafana
 #   cat $outputdir/$projectname/$1/vuln/nuclei.txt | grep "[*grafana*]" | grep -v "grafana-detect" | cut -d " " -f4 | sort -u | cut -f1,2,3 -d "/" | sort | uniq >> $outputdir/$projectname/$1/vuln/Grafana/Grafana.txt

 #   touch $outputdir/$projectname/$1/.progress/.Grafana_scan
 # fi

# ------------------------------------------------------------------------------------------------------------









 
}
function scan {
  echo -e "${BLUE}${BOLD}[+] Scanning domain: ${GREEN}$1${NC}"
  # SubDomains Finding 
  mkdir -p $outputdir/$projectname/$1/.progress
  subdomainsScan $1
  clear
  endpointsFuzzing $1
  clear
  subdomainTakeoverScan $1
  clear
  checkForVulns $1 
  clear
   
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

find $outputdir/$projectname/*/recon -type f -empty -delete 2>/dev/null
find $outputdir/$projectname/*/vuln -type f -empty -delete 2>/dev/null
find $outputdir/$projectname/*/vuln -type d -empty -exec rmdir {} \; 2>/dev/null
find $outputdir/$projectname/*/recon -type d -empty -exec rmdir {} \; 2>/dev/null
