import { UPDATE_RESPONSE } from '../constants'

import { createReducer } from '../../../reducers'

const initialState = {}

const rawReducer = createReducer(initialState, {
  [ UPDATE_RESPONSE ]: (state, payload) => {
    state.responses[payload.question_id] = payload.responses

    return {
      ...state
    }
  }
})

export default rawReducer
