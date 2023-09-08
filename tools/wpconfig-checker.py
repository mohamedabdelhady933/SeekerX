import requests
import sys
import os
import colorama
import argparse
from colorama import Fore

cases={
    "/wp-config.php~",
    "/wp-config.PHP",
    "/*wp-config.php",
    "/wp-config.php.new",   
    "/wp-config.php.tmp",
    "/.wp-config.php.swp",
    "/wp-config-sample.php",
    "/wp-config.inc",
    "/wp-config.new",
    "/wp-config.old",
    "/wp-config.txt",
    "/wp-config.php.txt",
    "/wp-config.php.bak",
    "/wp-config.php.old",
    "/wp-config.php.dist",
    "/wp-config.php.inc",
    "/wp-config.php.swp",
    "/wp-config.php.html",
    "/wp-config.php.zip",
    "/wp-config-backup.txt",
    "/wp-config.php.save",
    "/wp-config.php-backup",
    "/wp-config.php.backup",
    "/wp-config.php.orig",
    "/wp-config.php_orig",
    "/ws-config.json",
    "/wp-config.php.original",
    "/_wpeprivate/config.json",
    "/.wp-config.php.swo",
    "/.wp-config.swp",  
    "/backup.wp-config.php",  
    "/wp-config",  
    "/wp-config - Copy.php",  
    "/wp-config copy.php", 
    "/wp-config_backup",  
    "/wp-config_good",  
    "/wp-config-backup",
    "/wp-config-backup.php",  
    "/wp-config-backup1.txt",  
    "/wp-config-good",  
    "/wp-config-sample.php.bak", 
    "/wp-config-sample.php~",  
    "/wp-config.backup",   
    "/wp-config.bak",   
    "/wp-config.bkp",  
    "/wp-config.cfg", 
    "/wp-config.conf", 
    "/wp-config.data", 
    "/wp-config.dump",  
    "/wp-config.good",  
    "/wp-config.htm",  
    "/wp-config.html", 
    "/wp-config.inc",  
    "/wp-config.local.php",  
    "/wp-config.old",  
    "/wp-config.old.old",  
    "/wp-config.ORG",   
    "/wp-config.orig",  
    "/wp-config.original",  
    "/wp-config.php",  
    "/wp-config.php_",  
    "/wp-config.php__",   
    "/wp-config.php______",  
    "/wp-config.php__olds", 
    "/wp-config.php_1", 
    "/wp-config.php_backup", 
    "/wp-config.php_bak", 
    "/wp-config.php_bk",  
    "/wp-config.php_new",   
    "/wp-config.php_old",  
    "/wp-config.php_old2017",
    "/wp-config.php_old2018", 
    "/wp-config.php_old2019",  
    "/wp-config.php_old2020",  
    "/wp-config.php_orig", 
    "/wp-config.php_original",   
    "/wp-config.php-",   
    "/wp-config.php-backup",   
    "/wp-config.php-bak",  
    "/wp-config.php-n",   
    "/wp-config.php-o",  
    "/wp-config.php-old",  
    "/wp-config.php-original", 
    "/wp-config.php-save",  
    "/wp-config.php-work",   
    "/wp-config.php.0",  
    "/wp-config.php.1",  
    "/wp-config.php.2",  
    "/wp-config.php.3",  
    "/wp-config.php.4",  
    "/wp-config.php.5",  
    "/wp-config.php.6",  
    "/wp-config.php.7",  
    "/wp-config.php.8",  
    "/wp-config.php.9",  
    "/wp-config.php.a",  
    "/wp-config.php.aws",
    "/wp-config.php.azure",  
    "/wp-config.php.b",   
    "/wp-config.php.backup.txt", 
    "/wp-config.php.bak1",   
    "/wp-config.php.bk",    
    "/wp-config.php.bkp",   
    "/wp-config.php.c",    
    "/wp-config.php.com",   
    "/wp-config.php.cust", 
    "/wp-config.php.dev",   
    "/wp-config.php.disabled", 
    "/wp-config.php.dist",  
    "/wp-config.php.dump",  
    "/wp-config.php.in",  
    "/wp-config.php.local",  
    "/wp-config.php.maj", 
    "/wp-config.php.new", 
    "/wp-config.php.org", 
    "/wp-config.php.php-bak",   
    "/wp-config.php.prod",   
    "/wp-config.php.production", 
    "/wp-config.php.sample",  
    "/wp-config.php.save.1",  
    "/wp-config.php.stage",  
    "/wp-config.php.staging",  
    "/wp-config.php.swn",  
    "/wp-config.php.swo",  
    "/wp-config.php.tar",  
    "/wp-config.php.temp", 
    "/wp-config.php.uk",  
    "/wp-config.php.us",  
    "/wp-config.php=",    
    "/wp-config.php~~~",  
    "/wp-config.php1",  
    "/wp-config.phpa",  
    "/wp-config.phpb",  
    "/wp-config.phpbak", 
    "/wp-config.phpc",  
    "/wp-config.phpd",  
    "/wp-config.phpn",   
    "/wp-config.phpnew",  
    "/wp-config.phpold", 
    "/wp-config.phporiginal", 
    "/wp-config.phptmp",   
    "/wp-config.prod.php.txt", 
    "/wp-config.save",   
    "/wp-config.tar",    
    "/wp-config.temp",  
    "/wp-config.txt",   
    "/wp-config.zip",  
    "/wp-config~",   
    "/wp-configbak"
    
}



def check_wordpress(url, api_key=None):
    if requests.get(url):
        print(Fore.GREEN, "\n [+] Starting Check Wordpress For : {}".format(url))
        print(Fore.GREEN, "\n [+] Check Config file For : {} ".format(url))
        counter = 0
        try:
            for i in cases:
                URL = url + i
                
                response = requests.get(URL)
                if("define" in response.text ) and ( response.status_code != 403) and ( response.status_code != 404):
                    print(Fore.GREEN, "\n [+] The Following URL works : " + URL)
                    counter += 1
            if(counter == 0):
                print(Fore.RED, "\n [-] No Result Found")
                print("-" * 50)
        except:
            print(Fore.RED, "\n [-] Failed To Enum Comfig File Due to Connection Failed with this Host "+ URL)
        print(Fore.GREEN, "\n [+] Starting check registration enabled For : {}".format(url))
        res = requests.get(url + "/wp-register.php", allow_redirects=False)
        if ("User registration is currently not allowed" in res.text) or (res.status_code == 302) or (res.status_code == 404) or (res.status_code == 301) or (res.status_code != 200):
            print(Fore.RED, "\n [-] Registration Not Enabled For : {}".format(url))
            print("-" * 50)
        else:
            print(Fore.GREEN, "\n [+] Registration Enabled For : {}".format(url))
            print("-" * 50)
        
    else:
        print(Fore.RED, "\n [-] Connection Failed for enumerating config file for Host : {}".format(url))
        print("-" * 50)
        
    print(Fore.GREEN, "\n [+] Starting Scan Wordpress For : {} ".format(url))
    if api_key:
        os.system("wpscan --url {} -e --random-user-agent --ignore-main-redirect --no-update --api-token {} ".format(url, api_key))
    else:
        os.system("wpscan --url {} -e --random-user-agent --ignore-main-redirect --no-update ".format(url))

    


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Scan Wordpress for vulnerabilities")
    parser.add_argument("-u", "--url",type=str, help="The URL of the Wordpress site to scan")
    parser.add_argument("-a", "--apiKey", type=str, help="The API key to use with wpscan")
    parser.add_argument("-f", "--file", type=str, help="A file containing URLs to scan")
    args = parser.parse_args()

    if args.url:
        url = url = args.url[:-1] if args.url.endswith('/') else args.url
        check_wordpress(url,args.apiKey)
    elif args.file:
        with open(args.file, 'r') as f:
            urls = f.readlines()
        for url in urls:
            url = url.strip()[:-1] if url.strip().endswith('/') else url.strip()
            check_wordpress(url.strip(),args.apiKey)
