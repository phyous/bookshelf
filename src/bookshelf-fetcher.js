import React, {Component} from "react";
import {Book} from "./book";
import {BookMetadata} from "./book-metadata";

import './style/style.css'

export class BookshelfFetcher extends Component {

  constructor(props) {
    super(props);
    this.state = {
      books: []
    }
  }

  componentDidMount() {
    // TODO: Clean up url
    fetch('http://localhost:4567/books')
      .then(results => {
        return results.json()
      })
      .then(data => {
        let books = data["books"].map((book) => {
          return this.renderBook(book)
        })

        this.setState({books: books})
      })
      .catch(function (error) {
        console.error('Request failed', error)
      });
  }

  renderBook(book) {
    return (
      <div className="row">
        <div className="six columns">
          <Book key={book.id} cover_image={book.images.url_large} title={book.title}/>
        </div>
        <div className="three columns">
          <BookMetadata key={book.id+1} author={book.author} title={book.title} averageRating={book.average_rating}/>
        </div>
      </div>
    )
  }

  render() {
    return (
      <div>
        {this.state.books}
      </div>
    )
  }

}