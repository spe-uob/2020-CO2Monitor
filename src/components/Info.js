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
  TextField,
  Snackbar
} from '@material-ui/core'
import { Alert } from '@material-ui/lab'
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
  const [open, setOpen] = useState(false)

  // snackbar for errors and successes
  const [snackSeverity, setSnackSeverity] = useState('error')
  const [snackText, setSnackText] = useState('')
  const [snackOpen, setSnackOpen] = useState(false)

  // adding sensor process
  const [openAddSensor, setOpenAddSensor] = useState(false)
  const [addSensorName, setAddSensorName] = useState('')
  const [addSensorId, setAddSensorId] = useState('')

  const addSensor = () => {
    axios.post('https://100.25.147.253:8080/api/buildings/' + props.buildingId + '/rooms/' + props.room + '/sensors', {
      name: addSensorName,
      id: addSensorId
    }).then(() => {
      setSnackSeverity('success')
      setSnackText('Added sensor!')
      setSnackOpen(true)

      setAddSensorName('')
      setAddSensorId('')
      setOpenAddSensor(false)
      props.refresh()
    }).catch((error) => {
      setSnackSeverity('error')
      setSnackText('Failed to add sensor: ' + error.message)
      setSnackOpen(true)
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

      <Snackbar open={snackOpen} autoHideDuration={3000} onClose={() => setSnackOpen(false)}>
        <Alert onClose={() => setSnackOpen(false)} severity={snackSeverity}>
          {snackText}
        </Alert>
      </Snackbar>
    </>
  )
}
