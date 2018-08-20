import React, {Component} from "react"
//import 'react-skeleton-css/styles/skeleton.2.0.4.css'
//import 'react-skeleton-css/styles/normalize.3.0.2.css'

import 'skeleton-css/css/skeleton.css'
import 'skeleton-css/css/normalize.css'
import './style/style.css'

export class BookMetadata extends Component {

  constructor(props) {
    super(props);
    this.state = {
      title: props.title,
      author: props.author,
      averageRating: props.averageRating
    }
  }

  // Example: https://crobinson42.github.io/react-skeleton-css
  // http://getskeleton.com/
  render() {
    return (
      <div className="container">
        <div className="row">
          <h4>{this.state.title}</h4>
        </div>
        <div className="row">
          <div className="eight columns">
            <h5>{this.state.author}</h5>
          </div>
          <div className="four columns">
            <h5>Rating: {this.state.averageRating}/5</h5>
          </div>
        </div>
      </div>
    )
  }

}