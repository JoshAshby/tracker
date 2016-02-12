import { FETCH_QUESTIONNAIRE, UPDATE_RESPONSE } from '../constants'

import { createReducer } from '../../../reducers/utils'

const initialState = {
  fetching: true,
  errors:   null,
  questionnaire: null
}

const rawReducer = createReducer(initialState, {
  [ FETCH_QUESTIONNAIRE ]: (state, payload) => {
    return {
      ...state
    }
  },
  [ UPDATE_RESPONSE ]: (state, payload) => {
    state.questionnaire.responses[payload.question_id] = payload.responses

    return {
      ...state
    }
  }
})

export default rawReducer
