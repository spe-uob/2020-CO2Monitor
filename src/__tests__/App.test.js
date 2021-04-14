import React from 'react'
import { render, screen, cleanup } from '@testing-library/react'
// import renderer from 'react-test-renderer'
import App from '../App'

afterEach(() => {
  cleanup()
})

test('should render info', () => {
  render(<App />)
  const linkElement = screen.getByText('CO2 Monitor Control Panel')
  expect(linkElement).toBeInTheDocument()
})
