#!/bin/bash

# mkdir -p tools
cd tools
	# hoOk
	git clone https://github.com/mrxdevil404/hoOk.git
	pip3 install -r hoOk/requirements.txt 
	chmod +x hoOk/hoOk.py


# Git Dorks
  git clone https://github.com/damit5/gitdorks_go.git
  cd gitdorks_go
  bash build.sh
  cd ..

# axiom
  bash <(curl -s https://raw.githubusercontent.com/pry0cc/axiom/master/interact/axiom-configure)

	# DepFine
	git clone https://github.com/M359AH/DepFine
	chmod +x DepFine/DepFine.py
	pip3 install -r DepFine/requirements.txt 


  # joomla
  git clone https://github.com/OWASP/joomscan

  #droopscan
  git clone https://github.com/droope/droopescan.git
  pip install -r droopescan/requirements.txt
  # aem
  git clone https://github.com/0ang3el/aem-hacker/
  

git clone https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan.git
	# # ParamSpider
	# git clone https://github.com/devanshbatham/ParamSpider
	# pip3 install -r ParamSpider/requirements.txt 
	# chmod +x ParamSpider/paramspider.py

	# wpconfig-checker.py
	#wget https://raw.githubusercontent.com/mohamedabdelhady933/Wordpress-Config-Enum/main/wpconfig-checker.py
	# chmod +x wpconfig-checker.py

	# linkfinder
	git clone https://github.com/GerbenJavado/LinkFinder.git

	cd LinkFinder
		pip3 install -r requirements.txt
		python setup.py install
	cd ..

	git clone https://github.com/m4ll0k/SecretFinder.git 
	python -m pip install -r /SecretFinder/requirements.txt

cd ..
# subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# sublist3r
pip3 install sublist3r

# assetfinder
go install -v github.com/tomnomnom/assetfinder@latest

# amass
go install -v github.com/owasp-amass/amass/v3/...@master

# gobuster
go install github.com/OJ/gobuster/v3@latest

# subzy
go install -v github.com/LukaSikic/subzy@latest

# gau
go install github.com/lc/gau/v2/cmd/gau@latest

# waybackurls
go install -v github.com/tomnomnom/waybackurls@latest

# httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

#confused
go install -v github.com/visma-prodsec/confused@latest

# nuclei
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# gospider
go install -v github.com/jaeles-project/gospider@latest
#kxss
go install -v github.com/Emoe/kxss@latest
#gitdorks_go
go install -v github.com/damit5/gitdorks_go@latest

#dirsearch
pip3 install dirsearch
pip3 install arjun

# wpscan
gem install wpscan







echo "SEEKERX_HOME="$(pwd)" >> config.conf
