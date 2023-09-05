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
    "/_wpeprivate/config.json"
}



def check_wordpress(url, api_key=None):
    if requests.get(url):
        print(Fore.GREEN, "\n [+] Starting Check Wordpress For : {}".format(url))
        print(Fore.GREEN, "\n [+] Check Config file For : {} ".format(url))
        counter = 0
        for i in cases:
            URL = url + i
            response = requests.get(URL)
            if("define" in response.text ) and ( response.status_code != 403) and ( response.status_code != 404):
                print(Fore.GREEN, "\n [+] The Following URL works : " + URL)
                counter += 1
        if(counter == 0):
            print(Fore.RED, "\n [-] No Result Found")
            print("-" * 50)

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
        os.system("wpscan --url {} -e --random-user-agent --no-update --api-token {} ".format(url, api_key))
    else:
        os.system("wpscan --url {} -e --random-user-agent --no-update ".format(url))

    


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
