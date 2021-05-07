import React from 'react'
import { render, screen, cleanup, fireEvent } from '@testing-library/react'
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
  //   fireEvent.click(screen.getAllByText('Log in')[1])
  //   await waitForElementToBeRemoved(() => username)

  //   const addRoom = screen.getByTestId('add-room-button')
  //   expect(addRoom).toBeInTheDocument()

  //   // open dialog
  //   fireEvent.click(addRoom)
  //   const title = screen.getByText('Add Room')
  //   expect(title).toBeInTheDocument()

  //   // enter info and submit
  //   const name = screen.getByText('name')
  //   fireEvent.change(name, { target: { value: 'integration_testing' } })
  //   expect(name.value).toBe('integration_testing')
  //   fireEvent.click(screen.getByText('Add'))
  //   await waitForElementToBeRemoved(() => screen.getByText(/Cancel/i))
  //   expect(title).not.toBeInTheDocument()

//   // wait for confirmation
})
