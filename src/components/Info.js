import React from 'react'
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
import './Info.css'
import Sensor from './Sensor.js'

const Transition = React.forwardRef((props, ref) => <Slide direction="up" ref={ref} {...props} />)

/**
 * @param {object} props
 * @return {React.Component}
 */
export default function Info (props) {
  const [open, setOpen] = React.useState(false)
  const handleClickOpen = () => {
    setOpen(true)
  }
  const handleClose = () => {
    setOpen(false)
  }

  const [openAddSensor, setOpenAddSensor] = React.useState(false)
  const handleClickOpenAddSensor = () => {
    setOpenAddSensor(true)
  }
  const handleCloseAddSensor = () => {
    setOpenAddSensor(false)
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
      <Button onClick={handleClickOpen}>
        More info
      </Button>
      <Dialog
        fullScreen
        open={open}
        onClose={handleClose}
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
                onClick={handleClose}
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
