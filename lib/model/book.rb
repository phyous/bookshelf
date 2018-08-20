class Book

  def initialize(data)
    book_data = data['book'][0]
    @title = extract(book_data['title'])
    @author = book_data['authors'][0]['author'][0]['name'][0]
    @isbn13 = extract(book_data['isbn13'])
    @id = book_data['id'][0]['content']

    @num_reviews = book_data['text_reviews_count'][0]['content']

    @num_pages = extract(book_data['num_pages'])
    @average_rating = extract(book_data['average_rating'])
    @goodreads_url = extract(book_data['link'])

    img_url = extract(book_data['image_url'])
    @images = generate_image_urls(@isbn13, img_url)
  end

  def to_json
    {
      'id' => @id,
      'title' => @title,
      'author' => @author,
      'average_rating' => @average_rating,
      'images' => @images
    }
  end

  # Book data values serialized as arrays
  # e.g: data['isbn13'] = ["9786073149891"]
  # nil values are Hash of `[{"nil"=>"true"}]`
  # This method facilitates value extraction from data hash
  def extract(payload)
    val = payload[0]
    val_present = val.class == String

    if val_present
        val
    else
        nil
    end
  end

  GR_ASSET_REGEX = /^(https:\/\/images.gr-assets.com\/books\/\d+)(.)(\S+)/

  def generate_image_urls(isbn13, gr_image_asset)
    url_small = gr_image_asset
    url_large = nil
    url_large_alt = nil

    gr_asset_parts = gr_image_asset.scan(GR_ASSET_REGEX)

    if gr_asset_parts.length == 1 and gr_asset_parts[0].length == 3
      p1 = gr_asset_parts[0][0]
      p2 = gr_asset_parts[0][2]
      url_large = "#{p1}l#{p2}"
    end

    unless isbn13.nil?
      url_large_alt = open_library_image_url(isbn13)
    end

    return {
      'url_small' => url_small,
      'url_large' => url_large,
      'url_large_alt' => url_large_alt
    }
  end

  def open_library_image_url(isbn13)
    "http://covers.openlibrary.org/b/isbn/#{isbn13}-L.jpg"
  end

end