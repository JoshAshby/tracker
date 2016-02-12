import { Component } from 'react'

import { WidgetWrapper, SubmitButton } from '../components'

import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'

import * as actionCreators from '../actions'

const mapStateToProps = (state) => ({
  questions_order: state.questionnaire.questions_order
})

export const IndexView = connect(mapStateToProps)((props) => {
  let widgets = props.questions_order.map((id, idx) => (
    <div key={ id }>
      <WidgetWrapper id={ id } />
      <hr />
    </div>
  ))

  return (
    <div>
      { widgets }
      <SubmitButton />
    </div>
  )
})
