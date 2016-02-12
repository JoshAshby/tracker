export const TextWidget = (props) => (
  <section>
    <p>
      <strong>Prompt:</strong> { props.prompt }
    </p>
    <div className="control">
      <textarea className="textarea"></textarea>
    </div>
  </section>
)
