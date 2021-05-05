import React, { useState } from 'react'
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
  TextField,
  Snackbar
} from '@material-ui/core'
import { Alert } from '@material-ui/lab'
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
  // snackbar for errors and successes
  const [snackSeverity, setSnackSeverity] = useState('error')
  const [snackText, setSnackText] = useState('')
  const [snackOpen, setSnackOpen] = useState(false)

  // deleting the sensor
  const [deleteOpen, setDeleteOpen] = useState(false)

  const deleteSensor = () => {
    axios.delete('https://100.25.147.253:8080/api/v1/sensors/' + props.id.toString()).then((response) => {
      setDeleteOpen(false)

      setSnackSeverity('success')
      setSnackText('Deleted sensor!')
      setSnackOpen(true)

      props.refresh()
    }).catch((error) => {
      setSnackSeverity('error')
      setSnackText('Could not delete sensor: ' + error.message)
      setSnackOpen(true)
    })
  }

  // editing the sensor
  const [editOpen, setEditOpen] = useState(false)
  const [editName, setEditName] = useState('')

  const editSensor = () => {
    axios.put('https://100.25.147.253:8080/api/v1/sensors/' + props.id.toString(), { name: editName }).then((response) => {
      setEditOpen(false)
      setEditName('')

      setSnackSeverity('success')
      setSnackText('Edited sensor ' + response.data.name)
      setSnackOpen(true)

      props.refresh()
    }).catch((error) => {
      setSnackSeverity('error')
      setSnackText('Could not edit sensor: ' + error.message)
      setSnackOpen(true)
    })
  }

  const graphMax = Math.max(...props.readings.map((entry) => (entry.co2)))

  return (
    <>
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
        <b>
            {' ' + graphMax}
            <br />
            {props.readings.length + ' '}
          </b>
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
              <TextField
                label="Name"
                variant="outlined"
                onChange={(event) => setEditName(event.target.value)}
              />
            </DialogContent>
            <DialogActions>
              <Button onClick={() => setEditOpen(false)}>
                Cancel
            </Button>
              <Button onClick={editSensor} color="primary" variant="contained">
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
                {props.id}
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

      <Snackbar open={snackOpen} autoHideDuration={3000} onClose={() => setSnackOpen(false)}>
        <Alert onClose={() => setSnackOpen(false)} severity={snackSeverity}>
          {snackText}
        </Alert>
      </Snackbar>
    </>
  )
}
