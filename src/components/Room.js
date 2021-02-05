import React from 'react'
import {Card, CardActions, CardContent, CardHeader, Button, Dialog, 
    DialogTitle, DialogContent, DialogContentText, DialogActions} from '@material-ui/core'
import {
  XYPlot,
  LineSeries
} from 'react-vis';

export default function Room(props) {

    const [open, setOpen] = React.useState(false);

    const handleClickOpen = () => {
    setOpen(true);
    };

    const handleClose = () => {
    setOpen(false);
    };

    return (
        <Card>
            <CardHeader title={"Room: " + props.name}>
                
            </CardHeader>
            <CardContent>
                <XYPlot height={300} width={500}>
                    <LineSeries data={props.data} />
                </XYPlot>
            </CardContent>
            <CardActions>
                <Button onClick={handleClickOpen}>
                More info
            </Button>
            <Dialog
                maxWidth={1000}
                open={open}
                onClose={handleClose}
            >
                <DialogTitle>{"More Info"}</DialogTitle>
                <DialogContent>
                <DialogContentText>
                    Here will be some more detailed information about the room
                </DialogContentText>
                <XYPlot height={500} width={900}>
                    <LineSeries data={props.data} />
                </XYPlot>
                </DialogContent>
                <DialogActions>
                <Button onClick={handleClose}>
                    Close
                </Button>
                </DialogActions>
            </Dialog>
            </CardActions>
        </Card>
    )
}
