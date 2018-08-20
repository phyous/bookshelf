import React from "react";
import {Component} from "react";

import './style/style.css'

export class Book extends Component {
  constructor(props) {
    super(props)
    this.state = {
      cover_image: this.props.cover_image,
      title: this.props.title
    }
  }

  render() {
    return (
      <div className="book-cover">
        <img src={this.state.cover_image} alt={this.state.title}/>
      </div>
    )
  }
}