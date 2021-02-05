import React from 'react';
import '../node_modules/react-vis/dist/style.css';
import { Grid, Paper } from '@material-ui/core';
import './App.css';
import Room from './components/Room.js'

/* do list of solid graphs (min-max of sensors) which pop out to
list of all sensors in the room */

var rooms = [
  {
    id: 1,
    name: "2.3",
    sensors: [
      {
        id: 0,
        sensorId: 15,
        description: "Back of room"
      },
      {
        id: 1,
        sensorId: 16,
        description: "Front of room"
      }
    ],
    data: [
      {x: 0, y: 8},
      {x: 1, y: 5},
      {x: 2, y: 4},
      {x: 3, y: 9},
      {x: 4, y: 1},
      {x: 5, y: 7},
      {x: 6, y: 6},
      {x: 7, y: 3},
      {x: 8, y: 2},
      {x: 9, y: 0}
    ]
  },
  {
    id: 2,
    name: "2.1",
    sensors: [
      {
        id: 0,
        sensorId: 15,
        description: "Back of room"
      },
      {
        id: 1,
        sensorId: 16,
        description: "Front of room"
      }
    ],
    data: [
      {x: 0, y: 4},
      {x: 1, y: 3},
      {x: 2, y: 8},
      {x: 3, y: 4},
      {x: 4, y: 0},
      {x: 5, y: 3},
      {x: 6, y: 5},
      {x: 7, y: 9},
      {x: 8, y: 6},
      {x: 9, y: 7}
    ]
  },
  {
    id: 3,
    name: "1.5",
    sensors: [
      {
        id: 0,
        sensorId: 15,
        description: "Back of room"
      },
      {
        id: 1,
        sensorId: 16,
        description: "Front of room"
      }
    ],
    data: [
      {x: 0, y: 3},
      {x: 1, y: 8},
      {x: 2, y: 4},
      {x: 3, y: 9},
      {x: 4, y: 4},
      {x: 5, y: 7},
      {x: 6, y: 2},
      {x: 7, y: 5},
      {x: 8, y: 0},
      {x: 9, y: 1}
    ]
  }
]

var roomCards = rooms.map((room) => (
  <Grid item xs={12} sm={6} md={4}>
    <div className="PaddedCard">
      <Room {...room} key={room.id}/>
    </div>
  </Grid>)
)

function App() {
  return (
    <div className="App">
      <Paper className="App-header">
        CO2 Monitor Control Panel
      </Paper>
      <Grid container
        spacing={0}
        direction="row"
        justify="space-around"
        alignItems="center"
      >
        {roomCards}
      </Grid>
    </div>
  );
}

export default App;
