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

    for (let i = 0; i < props.sensors[0].readings.length; i++) {
      let maxco2 = props.sensors[0].readings[i].co2
      let minco2 = props.sensors[0].readings[i].co2
      for (let j = 1; j < props.sensors.length; j++) {
        maxco2 = Math.max(maxco2, props.sensors[j].readings[i].co2)
        minco2 = Math.min(minco2, props.sensors[j].readings[i].co2)
      }
      graphMax = Math.max(graphMax, maxco2)
      graphData.push(
        {
          x: i, // props.sensors[0].data[i].x,
          y: maxco2,
          y0: minco2
        }
      )
    }

    minMaxGraph = (
      <>
        <FlexXYPlot height={300}>
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
