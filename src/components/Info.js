import React from 'react';
import {
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogContentText,
  DialogActions,
} from '@material-ui/core';
import {
  XYPlot,
  LineSeries,
} from 'react-vis';

/**
 * @param {object} props
 * @return {React.Component}
 */
export default function Info(props) {
  const [open, setOpen] = React.useState(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const sensorGraphs = props.sensors.map((sensor) => (
    <React.Fragment key={sensor.description + sensor.sensorId}>
      <DialogContentText>
        sensor.description + sensor.sensorId
      </DialogContentText>
      <XYPlot height={500} width={900}>
        <LineSeries data={sensor.data} />
      </XYPlot>
    </React.Fragment>
  ));

  return (
    <React.Fragment>
      <Button onClick={handleClickOpen}>
                More info
      </Button>
      <Dialog
        maxWidth={1000}
        open={open}
        onClose={handleClose}
      >
        <DialogTitle>{'More Info'}</DialogTitle>
        <DialogContent>
          <DialogContentText>
          Bunch of graphs for now
          </DialogContentText>
          {sensorGraphs}
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>
            Close
          </Button>
        </DialogActions>
      </Dialog>
    </React.Fragment>
  );
}
