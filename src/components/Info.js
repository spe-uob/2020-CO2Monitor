import React, { useState } from 'react'
import {
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  Paper,
  Slide,
  TextField
} from '@material-ui/core'
import { Add, Close } from '@material-ui/icons'
import axios from 'axios'
import './Info.css'
import Sensor from './Sensor.js'

const Transition = React.forwardRef((props, ref) => <Slide direction="up" ref={ref} {...props} />)

/**
 * @param {object} props
 * @return {React.Component}
 */
export default function Info (props) {
  const [open, setOpen] = React.useState(false)

  // adding sensor process
  const [openAddSensor, setOpenAddSensor] = useState(false)
  // const [addSensorSuccess, setAddSensorSuccess] = useState(false)
  // const [addSensorError, setAddSensorError] = useState(false)
  const [addSensorName, setAddSensorName] = useState('')
  const [addSensorId, setAddSensorId] = useState('')

  const addSensor = () => {
    axios.post('https://100.25.147.253:8080/api/rooms/' + '437579' + '/sensors', {
      name: addSensorName,
      id: addSensorId
    }).then(() => {
      // setAddSensorSuccess(true)
      setAddSensorName('')
      setAddSensorId('')
      setOpenAddSensor(false)
      props.refresh()
    }).catch((error) => {
      console.log(error)
    })
  }

  const sensors = props.sensors.map((sensor) => (
    <Grid
      item
      sm={12}
      md={6}
      lg={4}
      key={sensor.description + sensor.id}
      className="PaddedCard"
    >
      <Sensor {...sensor} />
    </Grid>
  ))

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        More info
      </Button>
      <Dialog
        fullScreen
        open={open}
        onClose={() => setOpenAddSensor(false)}
        TransitionComponent={Transition}
        data-testid="info-dialog"
      >
        <Paper className="Info-header">
          <Grid
            container
            spacing={0}
            direction="row"
            justify="space-between"
            alignItems="center"
          >
            <Grid item sm={12} md={6}>
              <Button
                className="Left-header"
                onClick={() => setOpen(false)}
                disableElevation
                data-testid="close-more-info"
              >
                <Close />
              </Button>
            </Grid>
            <Grid item sm={12} md={6}>
              <Button
                className="Right-header"
                disableElevation
                startIcon={<Add />}
                onClick={() => setOpenAddSensor(true)}
              >
                Add sensor
              </Button>
              <Dialog
                open={openAddSensor}
                onClose={() => setOpenAddSensor(false)}
              >
                <DialogTitle>
                  Add sensor
                </DialogTitle>
                <DialogContent>
                  <div>
                    <TextField
                      label="Sensor ID"
                      variant="outlined"
                      onChange={(event) => setAddSensorId(event.target.value)}
                    />
                  </div>
                  <div className="PaddedCard" />
                  <div>
                    <TextField
                      label="Name"
                      variant="outlined"
                      onChange={(event) => setAddSensorName(event.target.value)}
                      onKeyDown={(e) => {
                        if (e.keyCode === 13) {
                          addSensor()
                        }
                      }}
                    />
                  </div>
                </DialogContent>
                <DialogActions>
                  <Button onClick={() => setOpenAddSensor(false)}>
                    Cancel
                  </Button>
                  <Button onClick={addSensor} color="primary" variant="contained">
                    Add
                  </Button>
                </DialogActions>
              </Dialog>
            </Grid>
          </Grid>
        </Paper>
        <DialogContent>
          <Grid
            container
            spacing={0}
            direction="row"
            justify="flex-start"
            alignItems="flex-start"
          >
            {sensors}
          </Grid>
        </DialogContent>
      </Dialog>
    </>
  )
}
