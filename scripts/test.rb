require 'goodreads'
require 'yaml'

API_FILE_PATH = '../data/api_keys.yaml'
OAUTH_FILE_PATH = '../data/oauth_keys.yaml'
API_FILE = File.join(__dir__, API_FILE_PATH)

# pass in your developer key and secret
api_cnf = YAML::load_file(File.join(__dir__, API_FILE_PATH))
consumer_key = api_cnf['consumer_key']
consumer_secret = api_cnf['consumer_secret']
api_cnf = YAML::load_file(File.join(__dir__, OAUTH_FILE_PATH))
token = api_cnf[:token]
token_secret = api_cnf[:token_secret]


client = Goodreads::Client.new(api_key: consumer_key, api_secret: consumer_secret, oauth_token: token)

puts client.user_id
