#!/bin/bash

# mkdir -p tools
cd tools
	# hoOk
	git clone https://github.com/mrxdevil404/hoOk.git
	pip3 install -r hoOk/requirements.txt 
	chmod +x hoOk/hoOk.py



  # joomla
  git clone https://github.com/OWASP/joomscan.git
  

  #droopscan
  git clone https://github.com/droope/droopescan.git
  pip install -r droopescan/requirements.txt
  
  # aem
  git clone https://github.com/0ang3el/aem-hacker.git
  pip install -r aem-hacker/requirements.txt
  

git clone https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan.git
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


# subfinder
if  [ -x "$(command -v subfinder)" ]
then

else 
	go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
 	cp /root/go/bin/subfinder /user/local/bin/
fi

# sublist3r

if  [ -x "$(command -v sublist3r)" ]
then

else 
	pip3 install sublist3r
fi

# assetfinder

if  [ -x "$(command -v assetfinder)" ]
then

else 
	go install -v github.com/tomnomnom/assetfinder@latest
	cp /root/go/bin/assetfinder /user/local/bin/
fi

# amass

# if  [ -x "$(command -v amass)" ]
# then

# else 
# 	go install -v github.com/owasp-amass/amass/v3/...@master
# 	cp /root/go/bin/amass /user/local/bin/
# fi

# gobuster

if  [ -x "$(command -v gobuster)" ]
then

else 
	go install github.com/OJ/gobuster/v3@latest
	cp /root/go/bin/gobuster /user/local/bin/
fi


# subzy

if  [ -x "$(command -v subzy)" ]
then

else 
	go install -v github.com/LukaSikic/subzy@latest
	cp /root/go/bin/subzy /user/local/bin/
fi

# gau

if  [ -x "$(command -v gau)" ]
then

else 
	go install github.com/lc/gau/v2/cmd/gau@latest
	cp /root/go/bin/gau /user/local/bin/
fi

# waybackurls

if  [ -x "$(command -v waybackurls)" ]
then

else 
	go install -v github.com/tomnomnom/waybackurls@latest
	cp /root/go/bin/waybackurls /user/local/bin/
fi


# httpx

if  [ -x "$(command -v httpx)" ]
then

else 
	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
	cp /root/go/bin/httpx /user/local/bin/
fi


#confused
# if  [ -x "$(command -v confused)" ]
# then

# else 
# 	go install -v github.com/visma-prodsec/confused@latest
# 	cp /root/go/bin/confused /user/local/bin/
# fi


# nuclei

if  [ -x "$(command -v nuclei)" ]
then

else 
	go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
	cp /root/go/bin/nuclei /user/local/bin/
fi

# gospider

if  [ -x "$(command -v gospider)" ]
then

else 
	go install -v github.com/jaeles-project/gospider@latest
	cp /root/go/bin/gospider /user/local/bin/
fi

#kxss

if  [ -x "$(command -v kxss)" ]
then

else 
	go install -v github.com/Emoe/kxss@latest
	cp /root/go/bin/kxss /user/local/bin/
fi

#gitdorks_go

if  [ -x "$(command -v gitdorks_go)" ]
then

else 
	go install -v github.com/damit5/gitdorks_go@latest
	cp /root/go/bin/gitdorks_go /user/local/bin/
fi

#dirsearch

if  [ -x "$(command -v dirsearch)" ]
then

else 
	pip3 install dirsearch
fi

#arjun
if  [ -x "$(command -v arjun)" ]
then

else 
	pip3 install arjun
fi


# wpscan

if  [ -x "$(command -v wpscan)" ]
then

else 
	gem install wpscan
 	apt install wpscan
fi






echo "SEEKERX_HOME="$(pwd)" >> config.conf
