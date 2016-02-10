import React from 'react'
import { Route, IndexRoute } from 'react-router'

import { MainApp } from '../containers'
import {
  IndexView
} from '../views'

export const Routes = (
  <Route path='/' component={ MainApp } >
    <IndexRoute component={ IndexView } />
  </Route>
)
