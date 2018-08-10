require 'sinatra'
require 'yaml'

BOOK_DATA_FILE_PATH = './data/book_data.yaml'
book_data = YAML::load_file(BOOK_DATA_FILE_PATH)

get '/books' do
  response.headers['Access-Control-Allow-Origin'] = '*'

  random_book = book_data.sample["book"][0]
  isbn13 = random_book["isbn13"][0]
  title = random_book["title"][0]
  cover_image = "http://covers.openlibrary.org/b/isbn/#{isbn13}-L.jpg"

  json = {
      books: [
          {
              "isbn" => isbn13,
              "title" => title,
              "cover_image" => cover_image
          }
      ]
  }.to_json

  puts json

  return json
end

get '/' do
  File.read(File.join('dist', 'index.html'))
end

get '/*' do |sub_path|
  if sub_path.end_with? '.js'
    # Incorrect mime type on javascript will prevent it from executing on modern browsers
    content_type 'text/javascript'
  end
  File.read(File.join('dist', sub_path))
end