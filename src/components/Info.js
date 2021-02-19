import React from 'react';
import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardHeader,
  Dialog,
  DialogContent,
  Grid,
  Paper,
  Slide,
} from '@material-ui/core';
import {Add, Close} from '@material-ui/icons';
// import {boxShadow} from '@material-ui/system';
import {
  XYPlot,
  LineSeries,
  makeWidthFlexible,
} from 'react-vis';
import './Info.css';

const FlexXYPlot = makeWidthFlexible(XYPlot);
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

  const sensorGraphs = props.sensors.map((sensor) => (
    <Grid item
      sm={12}
      md={6}
      lg={4}
      key={sensor.description + sensor.sensorId}
      className="PaddedCard"
    >
      <Card>
        <CardHeader title={sensor.description + ' ' + sensor.sensorId} />
        <CardContent>
          <FlexXYPlot height={300}>
            <LineSeries data={sensor.data} />
          </FlexXYPlot>
        </CardContent>
        <CardActions>
          <Button>
            Edit sensor
          </Button>
        </CardActions>
      </Card>
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
            {sensorGraphs}
          </Grid>
        </DialogContent>
      </Dialog>
    </React.Fragment>
  );
}
