import React from 'react'
import {
  XYPlot,
  LineSeries
} from 'react-vis';

export default function Info(props) {
    return (
        <div>
            <XYPlot height={300} width={500}>
                <LineSeries data={props.data} />
            </XYPlot>
        </div>
    )
}
