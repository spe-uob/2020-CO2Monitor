import React from 'react'
import { render, screen, cleanup, fireEvent, waitForElementToBeRemoved } from '@testing-library/react'
// import renderer from 'react-test-renderer'
import App from '../App'

afterEach(() => {
  cleanup()
})

test('should render title bar', () => {
  render(<App />)
  const title = screen.getByText('CO2 Monitor Control Panel')
  expect(title).toBeInTheDocument()
})

test('open and close add room dialog', async () => {
  render(<App />)
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
