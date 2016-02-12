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
    console.log(choice)
  }

  render() {
    let choices = props.question.choices.map((choice, idx) => (
      <button key={ idx } onClick={ this.handleClick.bind(choice) } className="button is-large is-outlined">
        { choice }
      </button>
    ))

    choices = _.flatten(_.zip(choices, _.fill(Array(choices.length), ' ')))

    return (
      <section>
        <p>
          <strong>Prompt:</strong> { props.question.prompt }
        </p>
        <div className="is-centered">
          { choices }
        </div>
      </section>
    )
  }
}
