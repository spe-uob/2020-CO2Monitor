import React from 'react';
import {
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  Paper,
  Slide,
  TextField,
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

  const [openAddSensor, setOpenAddSensor] = React.useState(false);
  const handleClickOpenAddSensor = () => {
    setOpenAddSensor(true);
  };
  const handleCloseAddSensor = () => {
    setOpenAddSensor(false);
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
                onClick={handleClickOpenAddSensor}
              >
                Add sensor
              </Button>
              <Dialog
                open={openAddSensor}
                onClose={handleCloseAddSensor}
              >
                <DialogTitle>
                  Add sensor
                </DialogTitle>
                <DialogContent>
                  <div>
                    <TextField
                      multiline
                      label="Sensor ID"
                      variant="outlined"
                    />
                  </div>
                  <div className="PaddedCard" />
                  <div>
                    <TextField
                      multiline
                      label="Description"
                      variant="outlined"
                    />
                  </div>
                </DialogContent>
                <DialogActions>
                  <Button onClick={handleCloseAddSensor}>
                    Cancel
                  </Button>
                  <Button color="primary" variant="contained">
                    Add
                  </Button>
                </DialogActions>
              </Dialog>
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
