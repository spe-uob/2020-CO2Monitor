import React from 'react';
import '../node_modules/react-vis/dist/style.css';
import {Grid, Paper} from '@material-ui/core';
import './App.css';
import Room from './components/Room.js';

/* do list of solid graphs (min-max of sensors) which pop out to
list of all sensors in the room */

// Populate some fake data
const roomNum = Math.floor(Math.random() * 20);
const rooms = [];
for (let i = 0; i < roomNum; i++) {
  const sensors = [];
  const sensorNum = Math.floor(Math.random() * 6);
  for (let is = 0; is < sensorNum; is++) {
    const dataGen = [];
    for (let ix = 0; ix < 1440; ix++) {
      dataGen.push({x: ix, y: Math.floor(Math.random() * ix) + ix});
    }
    sensors.push(
        {
          id: i * 1000 + is,
          sensorId: Room.toString() + ': ' + is.toString(),
          description: 'Well...',
          data: dataGen,
        },
    );
  }
  rooms.push(
      {
        id: i,
        name: i.toString + ' room',
        sensors: sensors,
      },
  );
}

const roomCards = rooms.map((room) => (
  <Grid item sm={12} md={6} lg={4} key={room.id * 1000 + room.name}>
    <div className="PaddedCard">
      <Room {...room} />
    </div>
  </Grid>),
);

/**
 * @return {React.Component}
 */
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
