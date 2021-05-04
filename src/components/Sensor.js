import React from 'react'
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
  TextField
} from '@material-ui/core'
import {
  XAxis,
  YAxis,
  XYPlot,
  LineSeries,
  makeWidthFlexible
} from 'react-vis'
import axios from 'axios'

const FlexXYPlot = makeWidthFlexible(XYPlot)

/**
 * @param {object} props
 * @return {React.Component}
 */
export default function Sensor (props) {
  const [deleteOpen, setDeleteOpen] = React.useState(false)
  const [editOpen, setEditOpen] = React.useState(false)

  const deleteSensor = () => {
    axios.delete('https://100.25.147.253:8080/api/v1/sensors/' + props.id.toString()).then((response) => {
      setDeleteOpen(false)
      props.refresh()
    }).catch((error) => {
      console.log(error)
    })
  }

  const graphMax = Math.max(...props.readings.map((entry) => (entry.co2)))

  return (
    <Card>
      <CardHeader title={`${props.description} ${props.id}`} />
      <CardContent>
        <FlexXYPlot height={300} xType="time">
          <XAxis title="time" />
          <YAxis title="CO2" />
          <LineSeries data={props.readings.map((entry) => (
            {
              y: entry.co2,
              x: entry.date
            }
          ))} />
        </FlexXYPlot>
        The 24h maximum is
        {' '}
        <b>{graphMax}</b>
        <br />
        <b>{props.readings.length}</b>
        {' '}
        data points recorded by this sensor
      </CardContent>
      <CardActions>
        <Button
          onClick={() => setEditOpen(true)}
        >
          Edit sensor
        </Button>
        <Dialog
          open={editOpen}
          onClose={() => setEditOpen(false)}
        >
          <DialogTitle>
            Editing:
            <b>
              {` ${props.id} `}
            </b>
          </DialogTitle>
          <DialogContent>
            <TextField multiline label="Name" variant="outlined" />
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setEditOpen(false)}>
              Cancel
            </Button>
            <Button color="primary" variant="contained">
              Save
            </Button>
          </DialogActions>
        </Dialog>
        <Button
          onClick={() => setDeleteOpen(true)}
          color="secondary"
          variant="contained"
        >
          Delete
        </Button>
        <Dialog
          open={deleteOpen}
          onClose={() => setDeleteOpen(false)}
        >
          <DialogTitle>
            Are you sure you want to delete:
            <b>
              {` ${props.id} `}
            </b>
            ?
          </DialogTitle>
          <DialogActions>
            <Button onClick={() => setDeleteOpen(false)}>
              Cancel
            </Button>
            <Button onClick={deleteSensor} color="secondary" variant="contained">
              Delete
            </Button>
          </DialogActions>
        </Dialog>
      </CardActions>
    </Card>
  )
}
