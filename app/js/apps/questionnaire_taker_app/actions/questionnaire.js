import { SUBMIT_QUESTIONNAIRE, UPDATE_RESPONSE } from '../constants'

import { AWAIT_MARKER } from 'redux-await'

import request from 'superagent'

export function submitQuestionnaire(questionnaire) {
  return {
    type: SUBMIT_QUESTIONNAIRE,
    AWAIT_MARKER,
    payload: {
      response: request.post( window.location.pathname ).withCredentials().send( { questionnaire: questionnaire } )
    }
  }
}

export function updateResponse(question_id, responses) {
  return {
    type: UPDATE_RESPONSE,
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
