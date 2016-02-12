export const MultipleChoiceWidget = (props) => {
  let choices = props.question.choices.map((choice, idx) => (
    <button key={ idx } className="button is-large is-outlined">
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
