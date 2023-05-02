import os
import sys
import argparse
import requests
import jsbeautifier
import re
import json

# Parse command line arguments
parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", required=True, help="Input file containing list of URLs to download")
parser.add_argument("-o", "--output", required=True, help="Output directory for downloaded and beautified files")
args = parser.parse_args()

# Create the output directory and subdirectory if they don't exist
if not os.path.exists(args.output):
    os.makedirs(args.output)
if not os.path.exists(os.path.join(args.output, "js_files")):
    os.makedirs(os.path.join(args.output, "js_files"))

# Define the regex pattern to check for
pattern = re.compile(r"""
    (?:password|passwd|pass)\s*[:=]\s*(?P<password>['"\w]+)           # password
    |api\w*\s*[:=]\s*(?P<api_key>['"\w]+)                                # API key
    |aws(.{0,50})?(?P<aws_key_id>AKIA\w{16})                              # AWS access key ID
    |aws(.{0,50})?(?P<aws_secret_key>[A-Za-z0-9/+=]{40})                 # AWS secret access key
    |['"]?(?P<secret_key>[A-Za-z0-9]{32,})['"]?                            # secret key
    |(?P<oauth_key>oauth[_-]?(?:token|key))\s*[:=]\s*(?P<oauth_token>['"\w]+)  # OAuth token/key
    |(?:(?:(?:access|api)[_-]?)?token|jwt)\s*[:=]\s*(?P<token>['"\w]+\.[\w+=/]+\.[\w+=/]+)   # token/JWT
    |(?:(?:(?:access|api)[_-]?)?(?:secret[_-]?)?key|s3[_-]?key)\s*[:=]\s*(?P<aws_secret_key>[A-Za-z0-9/+=]+)    # AWS secret key
    |db[_-]?password\s*[:=]\s*(?P<db_password>['"\w]+)                   # database password
    |client[_-]?secret\s*[:=]\s*(?P<client_secret>['"\w]+)               # client secret
    |(?i)(?:(?:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9|Bearer)\.[\w-]+\.[\w-]+\.?[\w+/_-]{0,2}) # JWT tokens
    |['"]?(?P<apikey>[A-Za-z0-9_]{10,})['"]?\s*[:=]\s*['"]?(?P<apikey_value>[A-Za-z0-9_]+)['"]?   # generic API key
    |(?:(?:secret|private)[_-]?)?(?:key|token)\s*[:=]\s*(?P<secret_value>['"\w]+)   # generic secret key/token
    |(?:['"=\w]{4,}[\W_]{0,4}(?:access|api|auth|client|credential|db|key|oauth|pass|secret|token|pwd)[\W_]{0,2}(?:['"]?\s*[=:]\s*['"]?[\w+/=]{20,})?\b)  # other patterns
    |(sanity|password|token|api|hidden|secret|apikey|key|credentials|admin|MySQL|aws|OTP|oauth|config|DATABASE|\.bak|\.sql|\.old|\.txt|\.cnf|\.ini\s|\.save|\.swp|bucket|db_|firebase|@yopmail|@coffeetimer24|@chotunai|internal|backup|\.env|\.json|\.git|id_dsa|\.yaml|\.cfg)
    """, re.IGNORECASE | re.VERBOSE)

pattern = re.compile(r"(sanity|password|token|api|hidden|secret|apikey|key|credentials|admin|MySQL|aws|OTP|oauth|config|DATABASE|\.bak|\.sql|\.old|\.txt|\.cnf|\.ini\s|\.save|\.swp|bucket|db_|firebase|@yopmail|@coffeetimer24|@chotunai|internal|backup|\.env|\.json|\.git|id_dsa|\.yaml|\.cfg)", re.IGNORECASE)

# Process each URL in the input file
results = {}
with open(args.file, "r") as f:
    urls = f.readlines()
    for url in urls:
        # Strip whitespace and newlines from the URL
        url = url.strip()
        # Get the filename from the URL
        filename = os.path.join(args.output, "js_files", os.path.basename(url))
        # Download the file and save it to disk
        response = requests.get(url)
        content = response.content
        beautified = (jsbeautifier.beautify(content)).split("\n")
        for line in beautified:
            if pattern.search(line):
                if filename not in results:
                    results[filename] = []
                results[filename].append(line)
        with open(filename, "wb") as f:
            f.write('\n'.join(beautified).encode())
            
# Write results to JSON file
with open(os.path.join(args.output, "results.json"), "w") as f:
    json.dump(results, f, indent=4)
