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
    \b(?:password|passwd|pass)\s*[:=]\s*(['"\w]+)  # password
    |\bapi\w*\s*[:=]\s*(['"\w]+)                    # API key
   """, re.IGNORECASE | re.VERBOSE)

# pattern = re.compile(r"(sanity|password|token|api|hidden|secret|apikey|key|credentials|admin|MySQL|aws_secret_token|OTP|oauth|config|DATABASE|\.bak|\.sql|\.old|\.txt|\.cnf|\.ini\s|\.save|\.swp|bucket|db_|firebase|@yopmail|@coffeetimer24|@chotunai|internal|backup|\.env|\.json|\.git|id_dsa|\.yaml|\.cfg)", re.IGNORECASE)

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
        content = response.content.decode('utf-8')  # Decode bytes to string
        beautified = (jsbeautifier.beautify(content)).split("\n")
        for line in beautified:
            if pattern.search(line):
                if filename not in results:
                    results[filename] = []
                results[filename].append(line)
        with open(filename, "w") as f:  # Open in text mode (w) instead of binary (wb)
            f.write('\n'.join(beautified))
            
# Write results to JSON file
with open(os.path.join(args.output, "results.json"), "w") as f:
    json.dump(results, f, indent=4)
