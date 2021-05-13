import React, { useState, useEffect } from 'react'
import '../node_modules/react-vis/dist/style.css'
import {
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  Paper,
  Fab,
  IconButton,
  InputBase,
  TextField,
  Snackbar,
  CircularProgress
} from '@material-ui/core'
import { Add, Search } from '@material-ui/icons'
import { makeStyles } from '@material-ui/core/styles'
import { Alert } from '@material-ui/lab'
import { connect } from 'react-redux'
import axios from 'axios'
import './App.css'
import Room from './components/Room.js'

const useStyles = makeStyles((theme) => ({
  addRoomTheme: {
    position: 'fixed',
    bottom: theme.spacing(2),
    right: theme.spacing(2)
  }
}))

const formatAPI = (db) => {
  const flattened = []
  for (const building of db) {
    for (const room of building.rooms) {
      room.building = building.name
      room.buildingId = building.id
      for (const sensor of room.sensors) {
        for (const reading of sensor.readings) {
          reading.date = new Date(reading.date)
        }
        sensor.readings.sort((a, b) => a.date - b.date)
      }
      flattened.push(room)
    }
  }
  // console.log(flattened[0].sensors[0].readings)
  return flattened
}

/**
 * @return {React.Component}
 */
function App (props) {
  const classes = useStyles()
  const serverURL = 'https://co2.icedcoffee.dev/api/v1/'

  // snackbar for errors and successes
  const [snackSeverity, setSnackSeverity] = useState('error')
  const [snackText, setSnackText] = useState('')
  const [snackOpen, setSnackOpen] = useState(false)

  // room global data
  const [roomCards, setRoomCards] = useState('Loading...')
  const [rooms, setRooms] = useState([])

  const refresh = () => {
    axios.get(serverURL + 'buildings/?kids=1').then((response) => {
      setRooms(response.data)
      setRoomCards(formatAPI(response.data).map((room) => (
        <Grid
          item
          sm={12}
          md={6}
          lg={4}
          key={room.id * 1000 + room.name}
          className="PaddedCard"
        >
          <Room {...room} refresh={refresh} token={props.token} serverURL={serverURL} />
        </Grid>
      )))
    }).catch((error) => {
      setSnackSeverity('error')
      setSnackText('Refresh error: ' + error.message)
      setSnackOpen(true)
    })
  }

  useEffect(() => {
    // wait for token to be set before calling refresh function
    refresh()
  }, [props.token])

  // login
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [loginError, setLoginError] = useState(<React.Fragment />)
  const [loginButton, setLoginButton] = useState('Log in')

  const requestToken = () => {
    setLoginButton(<CircularProgress />)
    axios.post(serverURL + 'auth', {
      username: username,
      password: password
    }).then((response) => {
      props.dispatch({ type: 'SET', payload: response.data.token })
    }).catch((error) => {
      setLoginError(
            <Alert severity="error">
              Error: {error.message}
            </Alert>
      )
    })
    setLoginButton('Log in')
  }

  // adding room process
  const [openAddRoom, setOpenAddRoom] = useState(false)
  const [addRoomName, setAddRoomName] = useState('')
  const [addRoomBuildingName, setAddRoomBuildingName] = useState('')

  const addRoom = () => {
    axios.get(serverURL + 'buildings', {
      headers: {
        Authorization: 'Bearer ' + props.token,
        'Content-Type': 'application/json'
      }
    }).then((response) => {
      // check for building
      const results = response.data.filter((buildingData) => buildingData.name === addRoomBuildingName)
      if (results.length === 1) {
        axios.post(serverURL + 'rooms', {
          name: addRoomName,
          building: {
            id: results[0].id
          }
        }, {
          headers: {
            Authorization: 'Bearer ' + props.token,
            'Content-Type': 'application/json'
          }
        }).then(() => {
          setSnackSeverity('success')
          setSnackText('Added room!')
          setSnackOpen(true)

          setAddRoomName('')
          setAddRoomBuildingName('')
          setOpenAddRoom(false)
          refresh()
        }).catch((error) => {
          setSnackSeverity('error')
          setSnackText('Could not add room: ' + error.message)
          setSnackOpen(true)
        })
      } else {
        setSnackSeverity('error')
        setSnackText('Room could not be added: Building name error')
        setSnackOpen(true)
      }
    }).catch((error) => {
      // could not get buildings
      setSnackSeverity('error')
      setSnackText('Could not add room: ' + error.message)
      setSnackOpen(true)
    })
  }

  // room search
  const [searchTerm, setSearchTerm] = useState('')

  const checkTerm = (data, term) => {
    if (data === null) {
      return false
    } else if (typeof (data) === 'object') {
      for (const dataKey in data) {
        if (dataKey !== 'data' && checkTerm(data[dataKey], term)) {
          return true
        }
      }
      return false
    } else {
      if (typeof data === 'string') {
        // match any substring
        return data.toLowerCase().includes(term.toLowerCase())
      } else {
        // match number ids exactly
        return data.toString() === term
      }
    }
  }

  const filterBySearchTerm = () => {
    setRoomCards(formatAPI(rooms.filter(room => checkTerm(room, searchTerm))).map((room) => (
      <Grid
        item
        sm={12}
        md={6}
        lg={4}
        key={room.id * 1000 + room.name}
        className="PaddedCard"
      >
        <Room {...room} refresh={refresh} token={props.token} serverURL={serverURL}/>
      </Grid>
    )))
  }

  if (props.token) {
    return (
      <div className="App">
        {/* Header bar */}
        <Paper className="App-header">
          <Grid
            container
            spacing={0}
            direction="row"
            justify="space-between"
            alignItems="center"
          >
            <Grid item sm={12} md={6}>
              <a className="Left-header">
                CO2 Monitor Control Panel
              </a>
            </Grid>
            <Grid item sm={12} md={6}>
              <div className="Right-header">
                <InputBase
                  placeholder="Search For Room"
                  onChange={(event) => setSearchTerm(event.target.value)}
                  onKeyDown={(e) => {
                    if (e.keyCode === 13) {
                      filterBySearchTerm()
                    }
                  }}
                />
                <IconButton onClick={filterBySearchTerm}>
                  <Search />
                </IconButton>
              </div>
            </Grid>
          </Grid>
        </Paper>

        {/* The cards (rooms) */}
        <Grid
          container
          spacing={0}
          direction="row"
          justify="flex-start"
          alignItems="flex-start"
        >
          {roomCards}
        </Grid>

        {/* Spain but the s is silent */}
        <Fab
          className={classes.addRoomTheme}
          onClick={() => setOpenAddRoom(true)}
          data-testid="add-room-button"
        >
          <Add />
        </Fab>
        <Dialog
          open={openAddRoom}
          onClose={() => setOpenAddRoom(false)}
        >
          <DialogTitle>
            Add Room
          </DialogTitle>
          <DialogContent>
            <TextField
              label="name"
              variant="outlined"
              onChange={(event) => setAddRoomName(event.target.value)}
              inputProps={{ 'data-testid': 'room_name' }}
            />
            <div className="PaddedCard" />
            <TextField
              label="building"
              variant="outlined"
              onChange={(event) => setAddRoomBuildingName(event.target.value)}
              onKeyDown={(e) => {
                if (e.keyCode === 13) {
                  addRoom()
                }
              }}
              inputProps={{ 'data-testid': 'building_name' }}
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setOpenAddRoom(false)} data-testid="cancel-add-room">
              Cancel
          </Button>
            <Button onClick={addRoom} color="primary" variant="contained">
              Add
            </Button>
          </DialogActions>
        </Dialog>

        <Snackbar open={snackOpen} autoHideDuration={3000} onClose={() => setSnackOpen(false)}>
          <Alert onClose={() => setSnackOpen(false)} severity={snackSeverity}>
            {snackText}
          </Alert>
        </Snackbar>
      </div>
    )
  } else {
    return (
      <>
        <Dialog
          open={true}
        >
          <DialogTitle>
            Log in
          </DialogTitle>
          <DialogContent>
            <TextField
              label="username"
              aria-label="username"
              variant="outlined"
              onChange={(e) => setUsername(e.target.value)}
              inputProps={{ 'data-testid': 'username' }}
            />
            <div className="PaddedCard" />
            <TextField
              label="password"
              variant="outlined"
              type="password"
              onChange={(e) => setPassword(e.target.value)}
              onKeyDown={(e) => {
                if (e.keyCode === 13) {
                  requestToken()
                }
              }}
              inputProps={{ 'data-testid': 'password' }}
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={requestToken} color="primary" variant="contained">
              {loginButton}
            </Button>
          </DialogActions>
          {loginError}
        </Dialog>
      </>
    )
  }
}

const mapStateToProps = (state) => ({
  token: state.token
})

export default connect(mapStateToProps)(App)
