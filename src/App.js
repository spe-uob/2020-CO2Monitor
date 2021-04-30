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
import './App.css'
import Room from './components/Room.js'
import axios from 'axios'

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

// --- GET RID OF THIS LATER ---

// Populate some fake data
/*
const roomNum = Math.floor(Math.random() * 10)
let rooms = []

for (let i = 0; i < roomNum; i++) {
  const sensors = []
  const sensorNum = Math.floor(Math.random() * 20)
  for (let is = 0; is < sensorNum; is++) {
    const dataGen = []
    // 1440 minutes in a day but that is too slow
    for (let ix = 0; ix < 144; ix++) {
      dataGen.push({ x: ix, y: Math.floor(Math.random() * ix) + ix })
    }
    sensors.push(
      {
        id: i * 1000 + is,
        sensorId: `${i.toString()}: ${is.toString()}`,
        description: 'Well...',
        data: dataGen
      }
    )
  }
  rooms.push(
    {
      id: i,
      name: `${i.toString()} room`,
      sensors
    }
  )
}
*/

// console.log(rooms)

// -----------------------------

/**
 * @return {React.Component}
 */
function App () {
  const classes = useStyles()

  const [token, setToken] = useState('test')
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [loginError, setLoginError] = useState(<React.Fragment />)
  const [loginButton, setLoginButton] = useState('Log in')

  const requestToken = () => {
    setLoginButton(<CircularProgress />)
    axios.put('https://100.25.147.253:8080/api/v1/login',
      {
        username: username,
        password: password
      }).then((response) => {
      setToken(response.data.token)
    }).catch((error) => {
      console.log(error)
      setLoginError(
          <Alert severity="error">
            Please log in.
          </Alert>
      )
      setLoginButton('Log in')
    })
  }

  const [roomCards, setRoomCards] = useState('Loading...')
  const [rooms, setRooms] = useState([])

  const refreshRooms = () => {
    axios.get('https://100.25.147.253:8080/api/v1/buildings/?kids=1')
      .then((response) => {
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
            <Room {...room} />
          </Grid>
        )))
      }).catch((error) => {
        console.log(error)
      })
  }

  useEffect(() => {
    refreshRooms()
  }, [])

  const [openAddRoom, setOpenAddRoom] = useState(false)
  const handleClickOpenAddRoom = () => {
    setOpenAddRoom(true)
  }
  const handleCloseAddRoom = () => {
    setOpenAddRoom(false)
  }

  const [addRoomSuccess, setAddRoomSuccess] = useState(false)
  const addRoomSuccessOpen = () => {
    setAddRoomSuccess(true)
  }
  const addRoomSuccessClose = () => {
    setAddRoomSuccess(false)
  }

  const [addRoomError, setAddRoomError] = useState(false)
  const addRoomErrorOpen = () => {
    setAddRoomError(true)
  }
  const addRoomErrorClose = () => {
    setAddRoomError(false)
  }

  const [addRoomName, setAddRoomName] = useState('')
  const changeAddRoomName = (newTerm) => {
    setAddRoomName(newTerm)
  }
  const [addRoomBuildingName, setAddRoomBuildingName] = useState('')
  const changeAddRoomBuildingName = (newTerm) => {
    setAddRoomBuildingName(newTerm)
  }

  const addRoom = () => {
    console.log('Some !%^&!%%! called this stupid function')
    axios.get('https://100.25.147.253:8080/api/v1/buildings/list').then((response) => {
      // check for building
      const results = response.data.filter((buildingData) => buildingData.name === addRoomBuildingName)
      if (results.length === 1) {
        axios.post('https://100.25.147.253:8080/api/v1/buildings/list', {
          name: addRoomName,
          building: {
            id: results[0].id
          }
        }).then(() => {
          addRoomSuccessOpen()
          refreshRooms()
        })
      } else {
        addRoomErrorOpen()
        console.log('Building not present')
      }
      console.log(response)
    }).catch((error) => {
      // could not get buildings
      addRoomErrorOpen()
      console.log(error)
    })
  }

  const [searchTerm, setSearchTerm] = useState('')
  const changeSearchTerm = (newTerm) => {
    setSearchTerm(newTerm)
  }

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
        return data.includes(term)
      } else {
        // match number ids exactly
        return data.toString() === term
      }
    }
  }

  const filterBySearchTerm = () => {
    setRoomCards(rooms.filter(room => checkTerm(room, searchTerm)).map((room) => (
      <Grid
        item
        sm={12}
        md={6}
        lg={4}
        key={room.id * 1000 + room.name}
        className="PaddedCard"
      >
        <Room {...room} refresh={refreshRooms} />
      </Grid>
    )))
  }

  const keyPressSearch = (e) => {
    if (e.keyCode === 13) {
      filterBySearchTerm()
    }
  }

  const keyPressAddRoom = (e) => {
    if (e.keyCode === 13) {
      addRoom()
    }
  }

  if (token) {
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
                  onChange={(event) => changeSearchTerm(event.target.value)}
                  onKeyDown={(event) => keyPressSearch(event)}
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
          onClick={handleClickOpenAddRoom}
          data-testid="add-room-button"
        >
          <Add />
        </Fab>
        <Dialog
          open={openAddRoom}
          onClose={handleCloseAddRoom}
        >
          <DialogTitle>
            Add Room
        </DialogTitle>
          <DialogContent>
            <TextField
              label="name"
              variant="outlined"
              onChange={(event) => changeAddRoomName(event.target.value)}
            />
            <div className="PaddedCard" />
            <TextField
              label="building"
              variant="outlined"
              onChange={(event) => changeAddRoomBuildingName(event.target.value)}
              onKeyDown={(event) => keyPressAddRoom(event)}
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={handleCloseAddRoom} data-testid="cancel-add-room">
              Cancel
          </Button>
            <Button onClick={addRoom} color="primary" variant="contained">
              Add
          </Button>
          </DialogActions>

          <Snackbar open={addRoomSuccess} autoHideDuration={6000} onClose={addRoomSuccessClose}>
            <Alert onClose={addRoomSuccessClose} severity="success">
              Room Added! Refresh the page to see changes.
          </Alert>
          </Snackbar>

          <Snackbar open={addRoomError} autoHideDuration={6000} onClose={addRoomErrorClose}>
            <Alert onClose={addRoomErrorClose} severity="error">
              Room could not be added.
          </Alert>
          </Snackbar>
        </Dialog>
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
            variant="outlined"
            onChange={(e) => setUsername(e.target.value)}
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

export default App
