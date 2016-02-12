import { TextWidget, SingleChoiceWidget, MultipleChoiceWidget } from './index'

import { connect } from 'react-redux'

const mapStoreToProps = (store, props) => ({
  prompt:    store.questionnaire.questions[props.id].prompt,
  type:      store.questionnaire.questions[props.id].type,
  choices:   store.questionnaire.questions[props.id].choices,
  responses: store.questionnaire.responses[props.id] || []
})

export const WidgetWrapper = connect(mapStoreToProps)((props) => {
  switch(props.type) {
    default:
      return ( <TextWidget { ...props } /> )
      break;
    case 'single_choice':
      return ( <SingleChoiceWidget { ...props } /> )
      break;
    case 'multiple_choice':
      return ( <MultipleChoiceWidget { ...props } /> )
      break;
  }
})
