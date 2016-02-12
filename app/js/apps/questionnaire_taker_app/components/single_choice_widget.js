import { Component } from 'react'

import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'

import * as actionCreators from '../actions'

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(actionCreators, dispatch)
})

@connect(null, mapDispatchToProps)
export class SingleChoiceWidget extends Component {
  @autobind
  handleClick(choice) {
    this.props.actions.updateResponse(this.props.id, [ choice ])
  }

  render() {
    let choices = this.props.choices.map((choice, idx) => {
      let className = [ 'button', 'is-large' ]

      if(this.props.responses.includes(choice)) {
        className.push('is-info')
      } else {
        className.push('is-outlined')
      }

      return (
        <button key={ idx } onClick={ this.handleClick.bind(this, choice) } className={ className.join(' ') }>
          { choice }
        </button>
      )
    })

    choices = _.flatten(_.zip(choices, _.fill(Array(choices.length), ' ')))

    return (
      <section>
        <p>
          <strong>Prompt:</strong> { this.props.prompt }
        </p>
        <div className="is-centered">
          { choices }
        </div>
      </section>
    )
  }
}
