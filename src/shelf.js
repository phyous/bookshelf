
import React, {Component} from "react"

export class Shelf extends Component {
  constructor(props) {
    super(props);
    this.state = {
      title: null,
      author: null,
      rating: null,
    }
  }
}
