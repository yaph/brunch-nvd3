init = (error, bardata, areadata) ->
    nv.addGraph ()->
        chart = nv.models.discreteBarChart()
            .x((d)-> d.label)
            .y((d)-> d.value)
            .staggerLabels(true)
            .tooltips(false)
            .showValues(true)
            .transitionDuration(250)

        d3.select('#bar svg')
            .datum(bardata)
            .call(chart)

        nv.utils.windowResize(chart.update)
        chart

    nv.addGraph ()->
        chart = nv.models.stackedAreaChart()
            .x((d)-> d[0])
            .y((d)-> d[1])
            .clipEdge(true)

        chart.xAxis
            .showMaxMin(false)
            .tickFormat((d)-> d3.time.format('%x')(new Date(d)))

        chart.yAxis
            .tickFormat(d3.format(',.2f'))

        d3.select('#area svg')
            .datum(areadata)
            .transition().duration(500).call(chart)

        nv.utils.windowResize(chart.update)
        chart


queue()
    .defer(d3.json, '/data/bar.json')
    .defer(d3.json, '/data/stacked-area.json')
    .await(init)