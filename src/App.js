import logo from './logo.svg';
import React from 'react';
import './App.css';
import { Grid, Paper } from '@material-ui/core';
import '../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  LineSeries
} from 'react-vis';

const data = [
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
];

function App() {
  return (
    <div className="App">
      <div className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <Grid container 
          spacing={0}
          direction="row"
          justify="center"
          alignItems="center"
        >
          <Grid item>
            <Paper>Another graph</Paper>
          </Grid>
          <Grid item>
            <XYPlot height={300} width={800}>
              <LineSeries data={data} />
            </XYPlot>
          </Grid>
          <Grid item>
            <Paper>Maybe some buttons</Paper>
          </Grid>
        </Grid>
      </div>
    </div>
  );
}

export default App;
