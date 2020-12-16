import logo from './logo.svg';
import React from 'react';
import './App.css';
import { Grid, Paper } from '@material-ui/core';
import '../node_modules/react-vis/dist/style.css';
import {
  XYPlot,
  LineSeries
} from 'react-vis';

const data1 = [
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

const data2 = [
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
];

const data3 = [
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
];

function App() {
  return (
    <div className="App">
      <div className="App-header">
        <Grid container 
          spacing={0}
          direction="row"
          justify="center"
          alignItems="center"
        >
          <Grid item>
            <XYPlot height={300} width={500}>
              <LineSeries data={data1} />
            </XYPlot>
          </Grid>
          <Grid item>
            <XYPlot height={300} width={500}>
              <LineSeries data={data2} />
            </XYPlot>
          </Grid>
          <Grid item>
            <XYPlot height={300} width={500}>
              <LineSeries data={data3} />
            </XYPlot>
          </Grid>
        </Grid>
      </div>
    </div>
  );
}

export default App;
