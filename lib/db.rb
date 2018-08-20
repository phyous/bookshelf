require 'singleton'
require 'yaml'
require_relative 'model/book'

module DB

  class Books
    include Singleton
    BOOK_DATA_FILE_PATH = './data/book_data.yaml'

    def initialize
      @data = YAML::load_file(BOOK_DATA_FILE_PATH)
      @books = @data.map{|b| Book.new(b)}
    end

    def raw_data
      @data
    end

    def books
      @books
    end
  end
end