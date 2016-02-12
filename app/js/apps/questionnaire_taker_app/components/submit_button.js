import { Component } from 'react'
import { connect } from 'react-redux'

import { bindActionCreators } from 'redux'

import * as actionCreators from '../actions'

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(actionCreators, dispatch)
})

const mapStateToProps = (state) => ({
  questionnaire: state.questionnaire
})

@connect(mapStateToProps, mapDispatchToProps)
export class SubmitButton extends Component {
  @autobind
  submitQuestionnaire() {
    let questionnaire = _.omit(this.props.questionnaire, 'questions_order', 'questions')
    this.props.actions.submitQuestionnaire(questionnaire)
  }

  render () {
    return (
      <button className='button is-large is-success' onClick={ this.submitQuestionnaire }>Done!</button>
    )
  }
}
