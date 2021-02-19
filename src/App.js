import React from 'react';
import '../node_modules/react-vis/dist/style.css';
import {
  Grid,
  Paper,
  Card,
  CardContent,
  Fab,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import './App.css';
import Room from './components/Room.js';

/* do list of solid graphs (min-max of sensors) which pop out to
list of all sensors in the room */

// Populate some fake data
const roomNum = Math.floor(Math.random() * 10);
const rooms = [];
for (let i = 0; i < roomNum; i++) {
  const sensors = [];
  const sensorNum = Math.floor(Math.random() * 20);
  for (let is = 0; is < sensorNum; is++) {
    const dataGen = [];
    // 1440 minutes in a day but that is too slow
    for (let ix = 0; ix < 144; ix++) {
      dataGen.push({x: ix, y: Math.floor(Math.random() * ix) + ix});
    }
    sensors.push(
        {
          id: i * 1000 + is,
          sensorId: i.toString() + ': ' + is.toString(),
          description: 'Well...',
          data: dataGen,
        },
    );
  }
  rooms.push(
      {
        id: i,
        name: i.toString() + ' room',
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
roomCards.push(
    <Grid item sm={12} md={6} lg={4} key={-1}>
      <div className="PaddedCard">
        <Card>
          <CardContent className="Fab-expander">
            <Fab disabled>
              <AddIcon />
            </Fab>
          </CardContent>
        </Card>
      </div>
    </Grid>,
);

/**
 * @return {React.Component}
 */
function App() {
  return (
    <div className="App">
      <Paper className="App-header">
        <Grid container
          spacing={0}
          direction="row"
          justify="space-between"
          alignItems="center"
        >
          <Grid item sm={12} md={6}>
            <a className="Left-header">
              CO2 Monitor Control Panel
            </a>
          </Grid>
          <Grid item sm={12} md={6}>
            <Fab variant="extended" className="Right-header" disabled>
              <AddIcon />
              Add room
            </Fab>
          </Grid>
        </Grid>
      </Paper>
      <Grid container
        spacing={0}
        direction="row"
        justify="flex-start"
        alignItems="flex-start"
      >
        {roomCards}
      </Grid>
    </div>
  );
}

export default App;
