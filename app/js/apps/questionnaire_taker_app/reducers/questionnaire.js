import { FETCH_QUESTIONNAIRE } from '../constants'

import { createReducer } from '../../../reducers/utils'

const initialState = {
  fetching: true,
  errors:   null,
  questionnaire: null
}

const rawReducer = createReducer(initialState, {
  [ FETCH_QUESTIONNAIRE ]: (state, payload) => {
    return {
      ...state,
      meta: {
        analytics: {
          type: 'questionnaire.fetch',
          payload: {
            id: payload.id
          }
        }
      }
    }
  }
})

export default rawReducer
