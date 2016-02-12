import { TextWidget, SingleChoiceWidget, MultipleChoiceWidget } from './index'

export const WidgetWrapper = (props) => {
  switch(props.question.type) {
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
}
