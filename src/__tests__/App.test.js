import React from 'react'
import { render, screen, cleanup, fireEvent, waitForElementToBeRemoved } from '@testing-library/react'
import { createStore } from 'redux'
import { Provider } from 'react-redux'
// import renderer from 'react-test-renderer'
import App from '../App'

const initialState = {
  token: 'testing'
}
function reducer (state = initialState, action) {
  switch (action.type) {
    default:
      return state
  }
}
const store = createStore(reducer)

afterEach(() => {
  cleanup()
})

test('should render title bar', () => {
  render(
    <Provider store={store}>
        <App />
    </Provider>
  )
  expect(screen.getByText('CO2 Monitor Control Panel')).toBeInTheDocument()
})

test('open and close add room dialog', async () => {
  render(
    <Provider store={store}>
        <App />
    </Provider>
  )
  const addRoom = screen.getByTestId('add-room-button')
  expect(addRoom).toBeInTheDocument()

  // open dialog
  fireEvent.click(addRoom)
  const title = screen.getByText('Add Room')
  expect(title).toBeInTheDocument()
  const cancel = screen.getByText('Cancel')
  expect(cancel).toBeInTheDocument()

  // close dialog
  fireEvent.click(screen.getByTestId('cancel-add-room'))
  await waitForElementToBeRemoved(() => screen.getByText(/Cancel/i))
  expect(title).not.toBeInTheDocument()
  expect(cancel).not.toBeInTheDocument()
})
