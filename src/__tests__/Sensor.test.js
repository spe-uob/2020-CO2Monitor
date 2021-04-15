import React from 'react'
import { render, screen, cleanup, fireEvent, waitForElementToBeRemoved } from '@testing-library/react'
// import renderer from 'react-test-renderer'
import Sensor from '../components/Sensor'

afterEach(() => {
  cleanup()
})

const data =
      {
        id: 0,
        sensorId: '0: 0',
        description: 'Well...',
        data: [
          {
            x: 0,
            y: 0
          },
          {
            x: 1,
            y: 1
          },
          {
            x: 2,
            y: 2
          },
          {
            x: 3,
            y: 5
          },
          {
            x: 4,
            y: 7
          },
          {
            x: 5,
            y: 7
          },
          {
            x: 6,
            y: 10
          },
          {
            x: 7,
            y: 7
          },
          {
            x: 8,
            y: 11
          },
          {
            x: 9,
            y: 17
          },
          {
            x: 10,
            y: 14
          },
          {
            x: 11,
            y: 17
          },
          {
            x: 12,
            y: 18
          },
          {
            x: 13,
            y: 18
          },
          {
            x: 14,
            y: 14
          },
          {
            x: 15,
            y: 20
          },
          {
            x: 16,
            y: 28
          },
          {
            x: 17,
            y: 22
          },
          {
            x: 18,
            y: 30
          },
          {
            x: 19,
            y: 29
          },
          {
            x: 20,
            y: 32
          },
          {
            x: 21,
            y: 34
          },
          {
            x: 22,
            y: 38
          },
          {
            x: 23,
            y: 27
          },
          {
            x: 24,
            y: 35
          },
          {
            x: 25,
            y: 42
          },
          {
            x: 26,
            y: 31
          },
          {
            x: 27,
            y: 37
          },
          {
            x: 28,
            y: 55
          },
          {
            x: 29,
            y: 52
          },
          {
            x: 30,
            y: 46
          },
          {
            x: 31,
            y: 33
          },
          {
            x: 32,
            y: 47
          },
          {
            x: 33,
            y: 41
          },
          {
            x: 34,
            y: 38
          },
          {
            x: 35,
            y: 59
          },
          {
            x: 36,
            y: 42
          },
          {
            x: 37,
            y: 45
          },
          {
            x: 38,
            y: 50
          },
          {
            x: 39,
            y: 54
          },
          {
            x: 40,
            y: 42
          },
          {
            x: 41,
            y: 49
          },
          {
            x: 42,
            y: 59
          },
          {
            x: 43,
            y: 58
          },
          {
            x: 44,
            y: 79
          },
          {
            x: 45,
            y: 53
          },
          {
            x: 46,
            y: 66
          },
          {
            x: 47,
            y: 77
          },
          {
            x: 48,
            y: 84
          },
          {
            x: 49,
            y: 93
          },
          {
            x: 50,
            y: 82
          },
          {
            x: 51,
            y: 71
          },
          {
            x: 52,
            y: 97
          },
          {
            x: 53,
            y: 69
          },
          {
            x: 54,
            y: 90
          },
          {
            x: 55,
            y: 86
          },
          {
            x: 56,
            y: 61
          },
          {
            x: 57,
            y: 78
          },
          {
            x: 58,
            y: 62
          },
          {
            x: 59,
            y: 77
          },
          {
            x: 60,
            y: 82
          },
          {
            x: 61,
            y: 66
          },
          {
            x: 62,
            y: 111
          },
          {
            x: 63,
            y: 83
          },
          {
            x: 64,
            y: 92
          },
          {
            x: 65,
            y: 103
          },
          {
            x: 66,
            y: 94
          },
          {
            x: 67,
            y: 70
          },
          {
            x: 68,
            y: 98
          },
          {
            x: 69,
            y: 126
          },
          {
            x: 70,
            y: 114
          },
          {
            x: 71,
            y: 72
          },
          {
            x: 72,
            y: 122
          },
          {
            x: 73,
            y: 106
          },
          {
            x: 74,
            y: 95
          },
          {
            x: 75,
            y: 84
          },
          {
            x: 76,
            y: 87
          },
          {
            x: 77,
            y: 93
          },
          {
            x: 78,
            y: 149
          },
          {
            x: 79,
            y: 97
          },
          {
            x: 80,
            y: 98
          },
          {
            x: 81,
            y: 157
          },
          {
            x: 82,
            y: 145
          },
          {
            x: 83,
            y: 161
          },
          {
            x: 84,
            y: 93
          },
          {
            x: 85,
            y: 143
          },
          {
            x: 86,
            y: 110
          },
          {
            x: 87,
            y: 123
          },
          {
            x: 88,
            y: 117
          },
          {
            x: 89,
            y: 98
          },
          {
            x: 90,
            y: 169
          },
          {
            x: 91,
            y: 154
          },
          {
            x: 92,
            y: 152
          },
          {
            x: 93,
            y: 149
          },
          {
            x: 94,
            y: 96
          },
          {
            x: 95,
            y: 100
          },
          {
            x: 96,
            y: 157
          },
          {
            x: 97,
            y: 103
          },
          {
            x: 98,
            y: 144
          },
          {
            x: 99,
            y: 124
          },
          {
            x: 100,
            y: 131
          },
          {
            x: 101,
            y: 141
          },
          {
            x: 102,
            y: 178
          },
          {
            x: 103,
            y: 181
          },
          {
            x: 104,
            y: 164
          },
          {
            x: 105,
            y: 115
          },
          {
            x: 106,
            y: 150
          },
          {
            x: 107,
            y: 133
          },
          {
            x: 108,
            y: 158
          },
          {
            x: 109,
            y: 137
          },
          {
            x: 110,
            y: 131
          },
          {
            x: 111,
            y: 189
          },
          {
            x: 112,
            y: 216
          },
          {
            x: 113,
            y: 156
          },
          {
            x: 114,
            y: 208
          },
          {
            x: 115,
            y: 193
          },
          {
            x: 116,
            y: 171
          },
          {
            x: 117,
            y: 186
          },
          {
            x: 118,
            y: 140
          },
          {
            x: 119,
            y: 208
          },
          {
            x: 120,
            y: 217
          },
          {
            x: 121,
            y: 132
          },
          {
            x: 122,
            y: 181
          },
          {
            x: 123,
            y: 144
          },
          {
            x: 124,
            y: 201
          },
          {
            x: 125,
            y: 249
          },
          {
            x: 126,
            y: 248
          },
          {
            x: 127,
            y: 149
          },
          {
            x: 128,
            y: 253
          },
          {
            x: 129,
            y: 170
          },
          {
            x: 130,
            y: 245
          },
          {
            x: 131,
            y: 205
          },
          {
            x: 132,
            y: 236
          },
          {
            x: 133,
            y: 205
          },
          {
            x: 134,
            y: 260
          },
          {
            x: 135,
            y: 207
          },
          {
            x: 136,
            y: 196
          },
          {
            x: 137,
            y: 221
          },
          {
            x: 138,
            y: 248
          },
          {
            x: 139,
            y: 191
          },
          {
            x: 140,
            y: 217
          },
          {
            x: 141,
            y: 266
          },
          {
            x: 142,
            y: 222
          },
          {
            x: 143,
            y: 217
          }
        ]
      }

test('check title', () => {
  render(<Sensor {...data} />)
  const linkElement = screen.getByText('Well... 0: 0')
  expect(linkElement).toBeInTheDocument()
})

test('check description', async () => {
  render(<Sensor {...data} />)
  // expect(screen.getByText('The 24h maximum is')).toBeInTheDocument()
  expect(screen.getByText('266')).toBeInTheDocument()
  expect(screen.getByText('144')).toBeInTheDocument()
  // expect(screen.getByText('data points recorded by this sensor')).toBeInTheDocument()
})

test('try editing sensor dialog', async () => {
  render(<Sensor {...data} />)
  fireEvent.click(screen.getByText('Edit sensor'))
  const cancel = screen.getByText('Cancel')
  expect(screen.getByText('Editing:')).toBeInTheDocument()
  expect(screen.getByText('Save')).toBeInTheDocument()
  fireEvent.click(cancel)
  await waitForElementToBeRemoved(() => screen.getByText('Save'))
  expect(cancel).not.toBeInTheDocument()
})

test('try deleting sensor dialog', async () => {
  render(<Sensor {...data} />)
  fireEvent.click(screen.getByText('Delete'))
  const cancel = screen.getByText('Cancel')
  fireEvent.click(cancel)
  await waitForElementToBeRemoved(() => screen.getByText('Cancel'))
  expect(cancel).not.toBeInTheDocument()
})

// test('matches sensor snapshot', () => {
//   const tree = renderer.create(<Sensor {...data} />).toJSON()
//   expect(tree).toMatchSnapshot()
// })
