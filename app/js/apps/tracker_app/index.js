import { Component } from 'react'

import configureStore from '../../store'
import { Root } from './containers'
import reducer from './reducers'

export class TrackerApp extends Component {
  @autobind
  componentWillMount() {
    this.store = configureStore(reducer, {})
  }

  render() {
    return ( <Root store={ this.store } /> )
  }
}
