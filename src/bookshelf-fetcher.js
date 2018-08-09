import React, {Component} from "react";
import {Book} from "./book";

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
        //{return (<Book url={book.url} name={book.name}>)})
        let books = data["books"].map((book) => {
          return (<Book key={book.isbn} url={book.url} name={book.name}/>)
        })

        this.setState({books: books})
      })
      .catch(function (error) {
        console.error('Request failed', error)
      });
  }

  render() {
    return (
      <div>
        {this.state.books}
      </div>
    )
  }

}