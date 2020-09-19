document.body.querySelectorAll('div.ct-chart').forEach((node) => {
  const options = {
    height: node.dataset['chartHeight'],
    width: node.dataset['chartWidth'],
    colors: node.dataset['chartColors'].split(',')
  }
  const dataset = Object.assign({}, node.dataset)
  const series = Object.values(Object.keys(dataset)
    .filter(key => key.startsWith('chartSeries-'))
    .reduce((obj, key) => {
      obj[key] = dataset[key]
      return obj
    }, {})).map(value => value.split(','))
  const data = {
    labels: node.dataset['chartLabels'].split(','),
    series: series
  }
  Chartist[node.dataset['chartType']](node, data, options)
})