<h1 align="center">
  <img src="" alt="SeekerX" width="200px" style="background:linear-gradient(to right, #34e89e, #0f3443);color:black">
  <br>
</h1>
 <p align=""> Seekerx is a command-line tool that facilitates scanning of domain names for specified projects. It can be used to identify potential subdomains and gather information about them.. </p>

<p align="center">
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-_red.svg"></a>
<a href="https://github.com/mohamedabdelhady933/SeekerX/issues"><img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"></a>
<img src="https://img.shields.io/badge/BashScript-blue">
</p>
<p align="center">
  <a href="#installation">Installation</a> |
  <a href="#configuration">Configuration</a> |
  <a href="#usage">Usage</a> |
  <a href="#example-usage">Example Usage</a> 
</p>
<!----------------------------------------------------------About------------------------------------------------------------------>
# What SeekerX do

<p align=""> 1- Get Subdomains and Subs of Subdomains</p>
<p align=""> 2- Filter Live subdomains (may get admin panels) </p>
<p align=""> 3- Check Subdomain Takeover </p>
<p align=""> 4- Collect all URLs </p>
<p align=""> 5- Collect all endpoints </p>
<p align=""> 6- Collect all Javascript files </p>
<p align=""> 7- Collect all Parameters </p>
<p align=""> 8- Collect all wordpress subdomains </p>
<p align=""> 9- Collect all wordpress subdomains </p>
<p align=""> 10- Collect all package.json file to check Dependency confusion </p>
<p align=""> 11- Collect all Shodan IPs and Scan them </p>
<p align=""> 12- Collect other CMS (drupal , Joomla ,AEM) subdomains</p>
<p align=""> 13- Collect all Cpanel subdomains </p>
<p align=""> 14- Collect all Collect Jira subdomains </p>
<p align=""> 15- Collect all Grafana Subdomains</p>
<p align=""> 16- Scan For XSS </p>
<p align=""> 17- Scan Dependency confusion </p>
<p align=""> 18- Run Nuclei with Custom Nuclei Templates </p>
<p align=""> 19- Scan all wordpress subdomains using wpscan and custom wordpress scanner tool </p>
<p align=""> 20- Scan other CMS (drupal , Joomla ,AEM) subdomains </p>
<p align=""> 21- Scan JS files </p>
<p align=""> 22- Filter possible SSRF parameters </p>
<p align=""> 23- Google dorking </p>
<p align=""> 24- Github dorking </p>

<!------------------------------------------------------------------Installation---------------------------------------------------->




# Installation

```
git clone https://github.com/mohamedabdelhady933/SeekerX.git

cd SeekerX

chmod +x install.sh

./install.sh
```

<!--------------------------------------------------------------Configuration-------------------------------------------------------->

# Configuration

## File config.conf

* 1- Add Shodan API Key   (optional)
  
```
Set SHODAN_API_KEY=""
```

* 2- Just Check the following paths if they are right.

```
HOOK_HOME="/home/$USER/SeekerX/tools/hoOk"
SECLISTS="/usr/share/seclists"
Nuclei_Templates_Path="~/nuclei-templates"
```

* 3- Add Wordpress API key  (optional)
```
WordPress_Api=""
```

<!-------------------------------------------------------------------Usage------------------------------------------------------------->

# Usage 


```
chmod +x Seekerx.sh
```

List the help options

```
./Seekerx.sh --help

Usage: test.sh -p projectname -d domainfilepath [-o outputdir]
Options:
  -p | --projectname   : Specify the project name (Output Directory Name)
  -d | --domainfile    : Specify the path to the domain file (ex: domains.txt)
  -o | --outputdir     : Specify the path to the output directory (default is the current directory)
  -m | --mode          : The scan mode (either fast or deep). Default is fast.
  -c | --check         : Check if required tools are installed
  -h | --help          : Display this help message

```

Run 

```
SeekerX.sh -p projectname -d domainfilepath [-o outputdir] [-m mode] [-c] [-h]

```

<!------------------------------------------------------------------Example Usage---------------------------------------------------->
# Example Usage

To scan a project named "example" using a domain file "domains.txt" and store the output in the current directory, run the following command:

```
./SeekerX.sh -p example -d domains.txt
```

You can also specify an output directory using the -o option:

```
./SeekerX.sh -p example -d domains.txt -o /path/to/output/dir
```

To run a deep scan mode, use the -m option:

```
./SeekerX.sh -p example -d domains.txt -m deep
```

To check if the required tools are installed, use the -c option:

```
./SeekerX.sh -c
```


# License
Seekerx.sh is released under the MIT License. Please see the LICENSE file for more details.

# Disclaimer
This tool is provided as-is without any warranties. Use it at your own risk. The authors and contributors of Seekerx.sh shall not be held liable for any misuse or damages caused by this tool.



