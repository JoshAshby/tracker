import { Component } from 'react'

import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'

import * as actionCreators from '../actions'

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(actionCreators, dispatch)
})

@connect(null, mapDispatchToProps)
export class TextWidget extends Component {
  @autobind
  handleChange(event) {
    this.props.actions.updateResponse(this.props.id, [ event.target.value ])
  }

  render() {
    return (
      <section>
        <p>
          <strong>Prompt:</strong> { this.props.prompt }
        </p>
        <div className="control">
          <textarea value={ this.props.responses[0] } onChange={ this.handleChange } className="textarea"></textarea>
        </div>
      </section>
    )
  }
}
