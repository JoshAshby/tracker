import { Component } from 'react'

import { WidgetWrapper } from '../components'

import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'

import * as actionCreators from '../actions'

const mapStateToProps = (state) => ({
  questions_order: state.questionnaire.questions_order
})

@connect(mapStateToProps)
export class IndexView extends Component {
  render () {
    let widgets = this.props.questions_order.map((id, idx) => {
      let extra

      if(idx != 0) {
        extra = ( <hr /> )
      }

      return (
        <div key={ id }>
          { extra }
          <WidgetWrapper id={ id } />
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
