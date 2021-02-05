import React from 'react'
import {Card, CardActions, CardContent, CardHeader, Button} from '@material-ui/core'
import {
  XYPlot,
  LineSeries
} from 'react-vis';

export default function Room(props) {
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
                <Button>I will do something later</Button>
            </CardActions>
        </Card>
    )
}
