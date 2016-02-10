import { Provider, connect } from 'react-redux'
import { Router } from 'react-router'

import { Routes } from '../routes'
import history from '../../../history'

export const Root = connect()((props) => (
  <Provider store={ props.store }>
    <Router history={ history }>
      { Routes }
    </Router>
  </Provider>
))
