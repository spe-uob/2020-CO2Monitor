import React from 'react';
import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardHeader,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
} from '@material-ui/core';
import {
  XYPlot,
  LineSeries,
  makeWidthFlexible,
} from 'react-vis';

const FlexXYPlot = makeWidthFlexible(XYPlot);

/**
 * @param {object} props
 * @return {React.Component}
 */
export default function Sensor(props) {
  const [deleteOpen, setDeleteOpen] = React.useState(false);
  const handleClickOpenDelete = () => {
    setDeleteOpen(true);
  };
  const handleCloseDelete = () => {
    setDeleteOpen(false);
  };

  const [editOpen, setEditOpen] = React.useState(false);
  const handleClickOpenEdit = () => {
    setEditOpen(true);
  };
  const handleCloseEdit = () => {
    setEditOpen(false);
  };

  return (
    <Card>
      <CardHeader title={props.description + ' ' + props.sensorId} />
      <CardContent>
        <FlexXYPlot height={300}>
          <LineSeries data={props.data} />
        </FlexXYPlot>
      </CardContent>
      <CardActions>
        <Button
          onClick={handleClickOpenEdit}
        >
          Edit sensor
        </Button>
        <Dialog
          open={editOpen}
          onClose={handleCloseEdit}
        >
          <DialogTitle>
            Editing:
            <b>
              {' ' + props.sensorId + ' '}
            </b>
          </DialogTitle>
          <DialogContent>
            You sure bro?
          </DialogContent>
          <DialogActions>
            <Button onClick={handleCloseEdit}>
              Cancel
            </Button>
            <Button color="primary" variant="contained">
              Save
            </Button>
          </DialogActions>
        </Dialog>
        <Button
          onClick={handleClickOpenDelete}
          color="secondary"
          variant="contained"
        >
          Delete
        </Button>
        <Dialog
          open={deleteOpen}
          onClose={handleCloseDelete}
        >
          <DialogTitle>
            Are you sure you want to delete:
            <b>
              {' ' + props.sensorId + ' '}
            </b>
            ?
          </DialogTitle>
          <DialogContent>
            You sure bro?
          </DialogContent>
          <DialogActions>
            <Button onClick={handleCloseDelete}>
              Cancel
            </Button>
            <Button color="secondary" variant="contained">
              Delete
            </Button>
          </DialogActions>
        </Dialog>
      </CardActions>
    </Card>
  );
}
