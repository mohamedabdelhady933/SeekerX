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
    (?:password|passwd|pass)\s*[:=]\s*(?P<password>['"\w]+)  # password
    |api\w*\s*[:=]\s*(?P<api_key>['"\w]+)                      # API key
    |aws.*?(?P<aws_key_id>AKIA\w{16})                          # AWS access key ID
    |['"]?(?P<secret_key>[A-Za-z0-9]{32,})['"]?                # secret key
    |(?P<oauth_key>oauth[_-]?(?:token|key))\s*[:=]\s*(?P<oauth_token>['"\w]+)  # OAuth token/key
    |(?:(?:(?:access|api)[_-]?)?token|jwt)\s*[:=]\s*(?P<token>['"\w]+\.[\w+=/]+\.[\w+=/]+)   # token/JWT
    |(?:(?:(?:access|api)[_-]?)?(?:secret[_-]?)?key|s3[_-]?key)\s*[:=]\s*(?P<aws_secret_key>[A-Za-z0-9/+=]+)    # AWS secret key
    |db[_-]?password\s*[:=]\s*(?P<db_password>['"\w]+)       # database password
    |client[_-]?secret\s*[:=]\s*(?P<client_secret>['"\w]+)   # client secret
    |(?i)(?:(?:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9|Bearer)\.[\w-]+\.[\w-]+\.?[\w+/_-]{0,2}) # JWT tokens
    |['"]?(?P<apikey>[A-Za-z0-9_]{10,})['"]?\s*[:=]\s*['"]?(?P<apikey_value>[A-Za-z0-9_]+)['"]?   # generic API key
    |(?:(?:secret|private)[_-]?)?(?:key|token)\s*[:=]\s*(?P<secret_value>['"\w]+)   # generic secret key/token
    |(?:\b(?:access|api|auth|client|credential|db|key|oauth|pass|secret|token|pwd)[_\w]*\b.*?['"]?\s*[:=]\s*['"]?[\w+/=]{20,})  # other patterns
    |(?:['"=\w]{4,}.*?(?:access|api|auth|client|credential|db|key|oauth|pass|secret|token|pwd)[_\w]*\b.*?['"]?\s*[:=]\s*['"]?[\w+/=]{20,})  # other patterns
    |(sanity|MySQL|OTP|config|access_key|access_token|accessKey|accessToken|SessionStorage\.aspx|account_sid|accountsid|admin_pass|admin_user|api_key|api_secret|apikey|app_key|app_secret|app_url|application_id|aws_secret_token|authsecret|aws_access|aws_access_key_id|aws_bucket|aws_config|aws_default_region|aws_key|aws_secret|aws_secret_access_key|aws_secret_key|aws_token|bucket_password|client_secret|cloudinary_api_key|cloudinary_api_secret|cloudinary_name|connectionstring|consumer_secret|database_dialect|database_host|database_logging|database_password|database_schema|database_schema_test|database_url|database_username|db_connection|db_database|db_dialect|db_host|db_password|db_port|db_server|db_username|dbpasswd|dbpassword|dbuser|django_password|elastica_host|elastica_port|elastica_prefix|email_host_password|facebook_app_secret|facebook_secret|fb_app_secret|fb_id|fb_secret|gatsby_wordpress_base_url|gatsby_wordpress_client_id|gatsby_wordpress_client_secret|gatsby_wordpress_password|gatsby_wordpress_protocol|gatsby_wordpress_user|github_id|github_secret|google_id|google_oauth|google_oauth_client_id|google_oauth_client_secret|google_oauth_secret|google_secret|google_server_key|gsecr|heroku_api_key|heroku_key|heroku_oauth|heroku_oauth_secret|heroku_oauth_token|heroku_secret|heroku_secret_token|htaccess_pass|htaccess_user|incident_bot_name|incident_channel_name|jwt_passphrase|jwt_password|jwt_public_key|jwt_secret|jwt_secret_key|jwt_secret_token|jwt_token|jwt_user|keyPassword|mail_driver|mail_encryption|mail_from_address|mail_from_name|mail_host|mail_password|mail_port|mail_username|mailgun_key|mailgun_secret|maps_api_key|mix_pusher_app_cluster|mix_pusher_app_key|mysql_password|oauth_discord_id|oauth_discord_secret|oauth_key|oauth_token|oauth2_secret|password:|paypal_identity_token|paypal_sandbox|paypal_secret|paypal_token|playbooks_url|postgres_password|private_key|pusher_app_cluster|pusher_app_id|pusher_app_key|pusher_app_secret|queue_driver|redis_host|redis_password|redis_port|response_auth_jwt_secret|response_data_secret|response_data_url|root_password|sa_password|secret|secret_access_key|secret_bearer|secret_key|secret_token|secretKey|security_credentials|send_keys|sentry_dsn|session_driver|session_lifetime|sf_username|sid twilio|sid_token|sid_twilio|slack_channel|slack_incoming_webhook|slack_key|slack_outgoing_token|slack_secret|slack_signing_secret|slack_token|slack_url|slack_webhook|slack_webhook_url|square_access_token|square_apikey|square_app|square_app_id|square_appid|square_secret|square_token|squareSecret|squareToken|ssh2_auth_password|sshkey|storePassword|strip_key|strip_secret|strip_secret_token|strip_token|stripe_key|stripe_secret|stripe_secret_token|stripe_token|stripSecret|stripToken|stripe_publishable_key|token_twilio|trusted_hosts|twi_auth|twi_sid|twilio_account_id|twilio_account_secret|twilio_account_sid|twilio_accountsid|twilio_api|twilio_api_auth|twilio_api_key|twilio_api_secret|twilio_api_sid|twilio_api_token|twilio_auth|twilio_auth_token|twilio_secret|twilio_secret_token|twilio_sid|twilio_token|twilioapiauth|twilioapisecret|twilioapisid|twilioapitoken|TwilioAuthKey|TwilioAuthSid|twilioauthtoken|TwilioKey|twiliosecret|TwilioSID|twiliotoken|twitter_api_secret|twitter_consumer_key|twitter_consumer_secret|twitter_key|twitter_secret|twitter_token|twitterKey|twitterSecret|wordpress_password|zen_key|zen_tkn|zen_token|zendesk_api_token|zendesk_key|zendesk_token|zendesk_url|zendesk_username|zendesk_password|DATABASE|\.bak|\.sql|\.old|\.txt|\.cnf|\.ini\s|\.save|\.swp|bucket|db_|firebase|@yopmail|@coffeetimer24|@chotunai|internal|backup|\.env|\.json|\.git|id_dsa|\.yaml|\.cfg)
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
