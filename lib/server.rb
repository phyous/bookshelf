require 'sinatra'

# Hook it up to become a basic react app

get '/books' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  {
      books: [
          {
              "isbn" => "9781476733500",
              "title" => "foo",
              "cover_image" => "http://covers.openlibrary.org/b/isbn/9781476733500-L.jpg"
          }
      ]
  }.to_json
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