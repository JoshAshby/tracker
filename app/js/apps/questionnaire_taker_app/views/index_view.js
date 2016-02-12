import { Component } from 'react'

import { WidgetWrapper } from '../components'

import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'

import * as actionCreators from '../actions'

const mapStateToProps = (state) => ({
  questions_order: state.questionnaire.questions_order,
  questions: state.questionnaire.questions,
  responses: state.questionnaire.responses
})

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(actionCreators, dispatch)
})

@connect(mapStateToProps, mapDispatchToProps)
export class IndexView extends Component {
  render () {
    let widgets = this.props.questions_order.map((id, idx) => {
      let widgetProps = {
        question: this.props.questions[id],
        response: this.props.responses[id]
      }

      let extra

      if(idx != 0) {
        extra = ( <hr /> )
      }

      return (
        <div key={ id }>
          { extra }
          <WidgetWrapper { ...widgetProps } />
        </div>
      )
    })

    return (
      <div>
        { widgets }
      </div>
    )
  }
}
