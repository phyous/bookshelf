import React from "react";
import {Component} from "react";


export class Book extends Component {
  constructor(props) {
    super(props)
    this.state = {
      url: "http://covers.openlibrary.org/b/isbn/9781476733500-L.jpg",
      name: "Some Book"
    }
  }

  render() {
    return (
      <div className="book-cover">
        <img src={this.state.url} alt={this.state.name}/>
      </div>
    )
  }
}