require 'sinatra'
require 'yaml'
require_relative 'db'

get '/books' do
  response.headers['Access-Control-Allow-Origin'] = '*'

  random_book = DB::Books.instance.books.sample

  json = {
      books: [
          random_book.to_json
      ]
  }.to_json

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