import { combineReducers } from 'redux'
import { routeReducer } from 'react-router-redux'
import { reducer as formReducer } from 'redux-form'
import { reducer as awaitReducer } from 'redux-await'

import questionnaire from './questionnaire'

export default combineReducers({
  questionnaire: questionnaire,
  form: formReducer,
  await: awaitReducer,
  routing: routeReducer
})
