import React from 'react';
import {
  Card,
  CardActions,
  // CardContent,
  CardHeader,
} from '@material-ui/core';
/* import {
  XYPlot,
  LineSeries,
} from 'react-vis';*/
import Info from './Info.js';

/**
 *
 * @param {Object} props
 * @param {string} props.name - name of the room
 * @return {React.ReactFragment} Card with room
 */
export default function Room(props) {
  return (
    <Card>
      <CardHeader title={'Room: ' + props.name}>

      </CardHeader>
      {/* <CardContent>
        <XYPlot height={300} width={500}>
          <LineSeries data={props.data} />
        </XYPlot>
      </CardContent>*/}
      <CardActions>
        <Info {...props} />
      </CardActions>
    </Card>
  );
}
