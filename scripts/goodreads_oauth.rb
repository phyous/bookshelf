require 'rubygems'
require 'oauth'
require 'yaml'
require 'launchy'
require 'io/console'

API_FILE_PATH = '../data/api_keys.yaml'
OAUTH_FILE_PATH = '../data/oauth_keys.yaml'
API_FILE = File.join(__dir__, API_FILE_PATH)

# Instruction: https://github.com/sosedoff/goodreads/blob/master/examples/oauth.md
cnf = YAML::load_file(API_FILE)
consumer_key = cnf['consumer_key']
consumer_secret = cnf['consumer_secret']

request_token = OAuth::Consumer.new(
                  consumer_key,
                  consumer_secret,
                  :site => 'https://www.goodreads.com'
                ).get_request_token

Launchy.open(request_token.authorize_url)

def enter_to_continue
  print "press any key"
  STDIN.getch
  print "            \r" # extra space to overwrite in case next sentence is short
end

puts "Press ENTER once you've sucessfully authenticated in your browser"
enter_to_continue

access_token = request_token.get_access_token

auth = {
    'token' => access_token.token,
    'token_secret' =>  access_token.secret
}

File.open(OAUTH_FILE_PATH, "w") do |file|
  file.write auth.to_yaml
end

puts "saved credentials to #{OAUTH_FILE_PATH}"