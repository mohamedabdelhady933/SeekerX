<h1 align="center">
  <img src="" alt="SeekerX" width="200px" style="background:linear-gradient(to right, #34e89e, #0f3443);color:black">
  <br>
</h1>
 <p align="center"> Seekerx is a command-line tool that facilitates scanning of domain names for specified projects. It can be used to identify potential subdomains and gather information about them.. </p>

<p align="center">
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-_red.svg"></a>
<a href="https://github.com/mohamedabdelhady933/SeekerX/issues"><img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"></a>
<img src="https://img.shields.io/badge/BashScript-blue">
</p>

<!------------------------------------------------------------------Installation---------------------------------------------------->
<p align="center">
  <a href="#installation">Installation</a> |
  <a href="#configuration">Configuration</a> |
  <a href="#usage">Usage</a> |
  <a href="#running-in-the-background">Running in the Background</a> |
  <a href="#references">References</a>
</p>



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

* 1- Add Shodan API Key
  
```
Set SHODAN_API_KEY=""
```

* 2- Just Check the following paths if they are right.

```
HOOK_HOME="/home/$USER/SeekerX/tools/hoOk"
SECLISTS="/usr/share/seclists"
Nuclei_Templates_Path="~/nuclei-templates"
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

---

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









<!--

#Recon

![reconBanner](https://user-images.githubusercontent.com/73122852/192073934-85a127ea-55f2-473c-a1b8-09c0f3e2892f.png)


<p align="center">
  <a href="https://github.com/mohamedabdelhady933/MyRecon/releases/tag/v1.0">
    <img src="https://img.shields.io/badge/release-v2.6-green">
  </a>
   </a>
  <a href="https://www.gnu.org/licenses/gpl-3.0.en.html">
      <img src="https://img.shields.io/badge/license-GPL3-_red.svg">
  </a>
<!--     <a href="https://github.com/mohamedabdelhady933/MyRecon/issues?q=is%3Aissue+is%3Aclosed">
    <img src="https://img.shields.io/github/issues-closed-raw/six2dez/reconftw.svg">
  </a> -->
<!--   <a href="https://github.com/mohamedabdelhady933/MyRecon/wiki">
    <img src="https://img.shields.io/badge/doc-wiki-blue.svg">
  </a> -->
<!--   <a href="https://t.me/joinchat/H5bAaw3YbzzmI5co">
    <img src="https://img.shields.io/badge/telegram-@ReconFTW-blue.svg">
  </a> -->
<!--   <a href="https://discord.gg/R5DdXVEdTy">
    <img src="https://img.shields.io/discord/1048623782912340038.svg?logo=discord">
  </a> 
</p>

<br><br><br><br><br><br><br><br><br><br>
## Overview
### MyRecon tool collects 

1-Subdomains [ "Sublist3r" , "Subfinder" , "Subbrute" , "Amass" , "AssetFinder" , "Gobuster" ,"Crt.sh" , "SecurityTrails"]

2-Get Subdomains of subdomains

3-Live Subdomains on different ports [80,443,8080,8443,9443,9080,8888,3000,81,30001,9000,10000,2222]  & Test Subdomains TakeOver

4-Get URLs 

5-Get Package.json file for check [ Dependency Confusion ]

6-Check Dependency Confusion

7-Collect JS Files

8-IPs & IP Range  (Optional)

9-ASN Numbers   (Optional)

10-Get Parameters then test SSRF and XSS payload

11-Tring some XSS

12-Scan & Footprinting & Discovering the target using Nuclei with some nuclei custom templates

13-Get Some relevant IPs from shodan and scan them


# Gitmind 

### Gitmind file  [MyRecon on Gitmind](https://gitmind.com/app/doc/ho6538w5jw).


# Installation

 ```
 git clone https://github.com/mohamedabdelhady933/MyRecon.git
 ```
 # Usage
 
 ```
 cd MyRecon
 ```
 ```

 chmod +x recon.sh
 ```
 ```
 ./recon.sh domain.com subdomains-wordlist.txt
```

