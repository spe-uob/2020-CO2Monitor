import React from 'react'
import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardHeader,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle
} from '@material-ui/core'
import {
  XAxis,
  YAxis,
  XYPlot,
  AreaSeries,
  makeWidthFlexible
} from 'react-vis'
import Info from './Info.js'

const FlexXYPlot = makeWidthFlexible(XYPlot)

/**
 * @param {Object} props
 * @param {string} props.name - name of the room
 * @return {React.ReactFragment} Card with room
 */
export default function Room (props) {
  const [open, setOpen] = React.useState(false)
  const handleClickOpen = () => {
    setOpen(true)
  }
  const handleClose = () => {
    setOpen(false)
  }

  let minMaxGraph
  if (props.sensors.length > 0) {
    const graphData = []
    let graphMax = 0
    const yIndices = props.sensors.map((sensor) => (sensor.readings.length - 1))
    const latest = new Date(Math.max.apply(null, (props.sensors.map((sensor) => (
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
        <Button onClick={handleClickOpen} color="secondary" variant="contained">
          Delete
        </Button>
        <Dialog
          open={open}
          onClose={handleClose}
        >
          <DialogTitle>
            Are you sure you want to delete:
            <b>
              {` ${props.name} `}
            </b>
            ?
          </DialogTitle>
          <DialogContent>
            You sure bro?
          </DialogContent>
          <DialogActions>
            <Button onClick={handleClose}>
              Cancel
            </Button>
            <Button color="secondary" variant="contained">
              Delete
            </Button>
          </DialogActions>
        </Dialog>
      </CardActions>
    </Card>
  )
}
