import React, { useState } from 'react'
import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardHeader,
  Dialog,
  DialogActions,
  DialogTitle,
  Snackbar
} from '@material-ui/core'
import {
  XAxis,
  YAxis,
  XYPlot,
  AreaSeries,
  makeWidthFlexible
} from 'react-vis'
import { Alert } from '@material-ui/lab'
import axios from 'axios'
import Info from './Info.js'

const FlexXYPlot = makeWidthFlexible(XYPlot)

/**
 * @param {Object} props
 * @param {string} props.name - name of the room
 * @return {React.ReactFragment} Card with room
 */
export default function Room (props) {
  const [open, setOpen] = useState(false)
  const [deleteRoomSuccess, setDeleteRoomSuccess] = useState(false)
  const [deleteRoomError, setDeleteRoomError] = useState(false)

  let deleteButton = <React.Fragment />
  if (props.sensors.length > 0) {
    deleteButton = <Button
      disabled
      color="secondary"
      variant="contained"
    >
      Delete
    </Button>
  } else {
    deleteButton = <Button
      onClick={() => setOpen(true)}
      color="secondary"
      variant="contained"
    >
      Delete
    </Button>
  }

  const deleteRoom = () => {
    axios.delete('https://100.25.147.253:8080/api/v1/' + props.id.toString()).then(() => {
      console.log('Deleted rom')
      setDeleteRoomSuccess(true)
    }).catch(() => {
      console.log('could not delete room')
      setDeleteRoomError(true)
    })
  }

  let minMaxGraph
  if (props.sensors.length > 0) {
    const graphData = []
    let graphMax = 0
    const yIndices = props.sensors.map((sensor) => (sensor.readings.length - 1))
    const latest = new Date(Math.max.apply(null, (props.sensors.filter((sensor) => sensor.readings.length > 0).map((sensor) => (
      sensor.readings[sensor.readings.length - 1].date
    )))))

    for (let i = 0; i < 288; i++) {
      latest.setMinutes(latest.getMinutes() - 5)
      let maxco2 = -1
      let minco2 = Infinity

      // console.log(latest)
      for (let j = 0; j < yIndices.length; j++) {
        while (yIndices[j] > -1 && props.sensors[j].readings[yIndices[j]].date > latest) {
          // console.log(props.sensors[j].readings[yIndices[j]])
          maxco2 = Math.max(maxco2, props.sensors[j].readings[yIndices[j]].co2)
          minco2 = Math.min(minco2, props.sensors[j].readings[yIndices[j]].co2)
          yIndices[j] -= 1
        }
      }

      graphMax = Math.max(graphMax, maxco2)
      if (maxco2 !== -1) {
        graphData.push(
          {
            x: new Date(latest),
            y: maxco2,
            y0: minco2
          }
        )
      }
    }

    minMaxGraph = (
      <>
        <FlexXYPlot height={300} xType='time'>
          <XAxis title="time" />
          <YAxis title="CO2" />
          <AreaSeries data={graphData} />
        </FlexXYPlot>
        The 24h maximum is
        {' '}
        <b>{graphMax}</b>
        <br />
        <b>{props.sensors.length}</b>
        {' '}
        sensors in this room
      </>
    )
  } else {
    minMaxGraph = 'No sensors in this room'
  }

  return (
    <Card>
      <CardHeader title={`${props.building} ${props.name}`} />
      <CardContent>
        {minMaxGraph}
      </CardContent>
      <CardActions>
        <Info {...props} />
        {deleteButton}
        <Dialog
          open={open}
          onClose={() => setOpen(false)}
        >
          <DialogTitle>
            Are you sure you want to delete:
            <b>
              {` ${props.name} `}
            </b>
            ?
          </DialogTitle>
          <DialogActions>
            <Button onClick={() => setOpen(false)}>
              Cancel
            </Button>
            <Button onClick={deleteRoom} color="secondary" variant="contained">
              Delete
            </Button>
          </DialogActions>
        </Dialog>
      </CardActions>

      <Snackbar open={deleteRoomSuccess} autoHideDuration={3000} onClose={() => {
        setDeleteRoomSuccess(false)
        props.refresh()
      }}
      >
        <Alert
          onClose={() => {
            setDeleteRoomSuccess(false)
            props.refresh()
          }}
          severity="success"
        >
          Room Deleted. Close me to refresh panel.
        </Alert>
      </Snackbar>

      <Snackbar open={deleteRoomError} autoHideDuration={3000} onClose={() => setDeleteRoomError(false)}>
        <Alert onClose={() => setDeleteRoomError(false)} severity="error">
          Room could not be deleted.
        </Alert>
      </Snackbar>
    </Card>
  )
}
