import React from 'react';
import {
  Button,
  Dialog,
  DialogContent,
  Grid,
  Paper,
  Slide,
} from '@material-ui/core';
import {Add, Close} from '@material-ui/icons';
import './Info.css';
import Sensor from './Sensor.js';

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

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

  if (props.sensors.length > 0) {
    console.log(props.sensors[0].sensorId);
  }

  const sensors = props.sensors.map((sensor) => (
    <Grid item
      sm={12}
      md={6}
      lg={4}
      key={sensor.description + sensor.sensorId}
      className="PaddedCard"
    >
      <Sensor {...sensor} />
    </Grid>
  ));

  return (
    <React.Fragment>
      <Button onClick={handleClickOpen}>
                More info
      </Button>
      <Dialog
        fullScreen
        open={open}
        onClose={handleClose}
        TransitionComponent={Transition}
      >
        <Paper className="Info-header">
          <Grid container
            spacing={0}
            direction="row"
            justify="space-between"
            alignItems="center"
          >
            <Grid item sm={12} md={6}>
              <Button
                variant="extended"
                className="Left-header"
                onClick={handleClose}
                disableElevation
              >
                <Close />
              </Button>
            </Grid>
            <Grid item sm={12} md={6}>
              <Button
                variant="extended"
                className="Right-header"
                disableElevation
                startIcon={<Add />}
              >
                Add sensor
              </Button>
            </Grid>
          </Grid>
        </Paper>
        <DialogContent>
          <Grid container
            spacing={0}
            direction="row"
            justify="flex-start"
            alignItems="flex-start"
          >
            {sensors}
          </Grid>
        </DialogContent>
      </Dialog>
    </React.Fragment>
  );
}
