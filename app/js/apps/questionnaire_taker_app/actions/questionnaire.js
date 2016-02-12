import { FETCH_QUESTIONNAIRE, UPDATE_RESPONSE } from '../constants'

import { AWAIT_MARKER } from 'redux-await'

//export function updateStory(url, data) {
//  return {
//    type: UPDATE_STORY,
//    AWAIT_MARKER,
//    payload: {
//      response: window.API.patch(url).send({ story: data })
//    }
//  }
//}

export function updateResponse(question_id, responses) {
  return {
    type: UPDATE_REPSONSE,
    payload: {
      question_id,
      responses
    },
    meta: {
      analytics: {
        type: 'questionnaire.update_response',
        payload: {
          question_id
        }
      }
    }
  }
}
