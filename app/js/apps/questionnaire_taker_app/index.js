import { Component } from 'react'

import configureStore from '../../store'
import { Root } from './containers'
import reducer from './reducers'

export class QuestionnaireTakerApp extends Component {
  @autobind
  componentWillMount() {
    this.store = configureStore(reducer, {
      questionnaire: window.AppData.QuestionnaireTakerApp.questionnaire
    })
  }

  render() {
    return ( <Root store={ this.store } /> )
  }
}
