#!/bin/bash


echo "SEEKERX_HOME="$(pwd) >> config.conf

# For Tool requirements
pip3 install -r requirements.txt


# mkdir -p tools
cd tools
	# hoOk
	git clone https://github.com/mrxdevil404/hoOk.git
	pip3 install -r hoOk/requirements.txt 
	chmod +x hoOk/hoOk.py
 	echo HOOK_HOME="$(pwd)/hoOk" >> ../config.conf

#  NipeJS
	if  [ -x "$(command -v nipejs)" ]
	then
		if [ -f regex.txt ]
 		then
			echo "[+] nipejs already installed";
  		else
   			wget https://raw.githubusercontent.com/i5nipe/nipejs/master/files/regex.txt
			
     		fi
       	elif   [ -f /root/go/bin/nipejs ]
	then
 		cp /root/go/bin/nipejs /usr/local/bin/
   		wget https://raw.githubusercontent.com/i5nipe/nipejs/master/files/regex.txt
	else 
		go install github.com/i5nipe/nipejs@latest
  		wget https://raw.githubusercontent.com/i5nipe/nipejs/master/files/regex.txt
	fi
	 	
	
  
  # joomla
 	 git clone https://github.com/OWASP/joomscan.git
  

  #droopscan
	  git clone https://github.com/droope/droopescan.git
 	 cd droopescan/
 	 pip3 install -r requirements.txt 2>/dev/null
 	 cd ..
  
  # aem
	  git clone https://github.com/0ang3el/aem-hacker.git
 	 pip3 install -r aem-hacker/requirements.txt
  
# Google Dorks
	git clone https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan.git
	chmod +x Fast-Google-Dorks-Scan/FGDS.sh

# Seclist

if  [ -d "/usr/share/seclists" ]
then
	echo "[+] Seclists already installed";
else 
	git clone https://github.com/danielmiessler/SecLists.git
 	mv SecLists /usr/share/seclists
fi

#gitdorks_go

if  [ -x "$(command -v gitdorks_go)" ]
then
	if [ -d gitdorks_go ]
 	then
		echo "[+] gitdorks_go already installed";
  	else
   		git clone https://github.com/damit5/gitdorks_go.git
     	fi
else 
	git clone https://github.com/damit5/gitdorks_go.git
	go install -v github.com/damit5/gitdorks_go@latest
	cp /root/go/bin/gitdorks_go /usr/local/bin/
fi



	# # ParamSpider
	# git clone https://github.com/devanshbatham/ParamSpider
	# pip3 install -r ParamSpider/requirements.txt 
	# chmod +x ParamSpider/paramspider.py

	# wpconfig-checker.py
	#wget https://raw.githubusercontent.com/mohamedabdelhady933/Wordpress-Config-Enum/main/wpconfig-checker.py
	# chmod +x wpconfig-checker.py

	# linkfinder
	# git clone https://github.com/GerbenJavado/LinkFinder.git
	# cd LinkFinder
	# pip3 install -r requirements.txt
	# python setup.py install
	# cd ..

	# git clone https://github.com/m4ll0k/SecretFinder.git 
	# python -m pip install -r /SecretFinder/requirements.txt

cd ..
# subfinder
if  [ -x "$(command -v subfinder)" ]
then
	echo "[+] subfinder already installed";
else 
	go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
 	cp /root/go/bin/subfinder /usr/local/bin/
fi

# sublist3r

if  [ -x "$(command -v sublist3r)" ]
then
	echo "[+] sublist3r already installed";
else 
	pip3 install sublist3r
fi

# assetfinder

if  [ -x "$(command -v assetfinder)" ]
then
	echo "[+] assetfinder already installed";
else 
	go install -v github.com/tomnomnom/assetfinder@latest
	cp /root/go/bin/assetfinder /usr/local/bin/
fi

# amass

# if  [ -x "$(command -v amass)" ]
# then

# else 
# 	go install -v github.com/owasp-amass/amass/v3/...@master
# 	cp /root/go/bin/amass /usr/local/bin/
# fi

# gobuster

if  [ -x "$(command -v gobuster)" ]
then
	echo "[+] gobuster already installed";
else 
	go install github.com/OJ/gobuster/v3@latest
	cp /root/go/bin/gobuster /usr/local/bin/
fi


# subzy

if  [ -x "$(command -v subzy)" ]
then
	echo "[+] subzy already installed";
else 
	go install -v github.com/LukaSikic/subzy@latest
	cp /root/go/bin/subzy /usr/local/bin/
fi

# gau

if  [ -x "$(command -v gau)" ]
then
	echo "[+] gau already installed";
else 
	go install github.com/lc/gau/v2/cmd/gau@latest
	cp /root/go/bin/gau /usr/local/bin/
fi

# waybackurls

if  [ -x "$(command -v waybackurls)" ]
then
	echo "[+] waybackurls already installed";
else 
	go install -v github.com/tomnomnom/waybackurls@latest
	cp /root/go/bin/waybackurls /usr/local/bin/
fi


# httpx

if  [ -x "$(command -v httpx)" ]
then
	echo "[+] httpx already installed";
else 
	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
	cp /root/go/bin/httpx /usr/local/bin/
fi


# Gf-Patterns

if  [ -d "~/.gf" ]
then
	echo "[+] Gf-Patterns already installed";
else 
	git clone https://github.com/1ndianl33t/Gf-Patterns
 	mkdir  ~/.gf
	mv Gf-Patterns/*.json ~/.gf
 	rm -fr Gf-Patterns/
fi



if  [ -x "$(command -v confused)" ]
then
	echo "[+] Gf-Patterns already installed";
else 
	go install -v github.com/visma-prodsec/confused@latest
	cp /root/go/bin/confused /usr/local/bin/
fi


# nuclei

if  [ -x "$(command -v nuclei)" ]
then
	echo "[+] nuclei already installed";
else 
	go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
	cp /root/go/bin/nuclei /usr/local/bin/
 	nuclei
  	mv ./CustomNucleiTemplates ~/nuclei-templates
  	
fi

# gospider

if  [ -x "$(command -v gospider)" ]
then
	echo "[+] gospider already installed";
else 
	go install -v github.com/jaeles-project/gospider@latest
	cp /root/go/bin/gospider /usr/local/bin/
fi

#kxss

if  [ -x "$(command -v kxss)" ]
then
	echo "[+] kxss already installed";
else 
	go install -v github.com/Emoe/kxss@latest
	cp /root/go/bin/kxss /usr/local/bin/
fi



#dirsearch

if  [ -x "$(command -v dirsearch)" ]
then
	echo "[+] dirsearch already installed";
else 
	pip3 install dirsearch
fi

#arjun
if  [ -x "$(command -v arjun)" ]
then
	echo "[+] arjun already installed";
else 
	pip3 install arjun
fi


# wpscan

if  [ -x "$(command -v wpscan)" ]
then
	echo "[+] wpscan already installed";
else 
	gem install wpscan
 	apt install wpscan
fi

if  [ -x "$(command -v gf)" ]
then
	echo "[+] gf already installed";
else 
	go install -v github.com/tomnomnom/gf@latest
	cp /root/go/bin/gf /usr/local/bin/
fi





awk '!seen[$0]++' config.conf > tmp
mv tmp config.conf




