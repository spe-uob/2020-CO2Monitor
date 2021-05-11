import React from 'react'
import { render, screen, cleanup, fireEvent, waitForElementToBeRemoved } from '@testing-library/react'
import { createStore } from 'redux'
import { Provider } from 'react-redux'
// import renderer from 'react-test-renderer'
import App from '../App'

const initialState = {
  token: ''
}
function reducer (state = initialState, action) {
  switch (action.type) {
    case 'SET':
      return {
        token: action.payload
      }
    default:
      return state
  }
}
const store = createStore(reducer)

afterEach(() => {
  cleanup()
})

test('add room', async () => {
  jest.setTimeout(12000)

  render(
    <Provider store={store}>
        <App />
    </Provider>
  )

  // log in
  const username = screen.getByTestId('username')
  fireEvent.change(username, { target: { value: 'foo' } })
  const password = screen.getByTestId('password')
  fireEvent.change(password, { target: { value: 'bar' } })
  fireEvent.click(screen.getAllByText('Log in')[1])
  await screen.findByText('CO2 Monitor Control Panel', undefined, { timeout: 3000 })

  const addRoom = screen.getByTestId('add-room-button')
  expect(addRoom).toBeInTheDocument()

  // open add room dialog
  fireEvent.click(addRoom)
  const title = screen.getByText('Add Room')
  expect(title).toBeInTheDocument()

  // enter info and add room
  const room = screen.getByTestId('room_name')
  fireEvent.change(room, { target: { value: 'integration_testing' } })
  const building = screen.getByTestId('building_name')
  fireEvent.change(building, { target: { value: 'MVB' } })
  fireEvent.click(screen.getByText('Add'))
  await screen.findByText('MVB integration_testing', undefined, { timeout: 3000 })

  // delete added room to clean up
  const deleteRoom = screen.getByTestId('integration_testing_delete_button')
  fireEvent.click(deleteRoom)
  const confirmDeleteRoom = screen.getByTestId('integration_testing_confirm_delete_button')
  fireEvent.click(confirmDeleteRoom)
  await waitForElementToBeRemoved(() => screen.getByText('Cancel'))
})
