require 'yaml'
require 'oauth'
require 'xmlsimple'

API_FILE_PATH = '../data/api_keys.yaml'
OAUTH_FILE_PATH = '../data/oauth_keys.yaml'
BOOK_DATA_FILE_PATH = '../data/book_data.yaml'
API_FILE = File.join(__dir__, API_FILE_PATH)

# pass in your developer key and secret
api_cnf = YAML::load_file(File.join(__dir__, API_FILE_PATH))
consumer_key = api_cnf['consumer_key']
consumer_secret = api_cnf['consumer_secret']
oauth_cnf = YAML::load_file(File.join(__dir__, OAUTH_FILE_PATH))
token = oauth_cnf['token']
token_secret = oauth_cnf['token_secret']

consumer = OAuth::Consumer.new(consumer_key,
                               consumer_secret,
                               :site => 'https://www.goodreads.com')

access_token = OAuth::AccessToken.new(consumer, token, token_secret)

# Get User Id
ret = access_token.get('/api/auth_user')
hash = XmlSimple.xml_in(ret.body)
user_id = hash['user'][0]['id']

# Get the books on a members shelf
ret = access_token.get("/review/list?format=xml&v=2&id=#{user_id}&per_page=200")
hash = XmlSimple.xml_in(ret.body)
reviews = hash['reviews'][0]['review']

puts "Found #{reviews.length} reviews"

# Filter out books without isbn13 (we need this to look up book cover images)
reviews.keep_if do |review|
  review['book'][0].key?('isbn13') && review['book'][0]['isbn13'][0].is_a?(String)
end

puts "Found #{reviews.length} reviews with associated isbn13"

# Save data to yaml file
File.open(BOOK_DATA_FILE_PATH, "w") do |file|
  file.write(reviews.to_yaml)
end

