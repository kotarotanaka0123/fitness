function createGraph(sp) { 
    const ctx = document.getElementById('highchart').getContext("2d");
    let span_days = [];
    let today = new Date();
    let span = sp;
    while(span >= 0){
      today = new Date();
      today.setDate(today.getDate()-span);
      span_days.push(today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate());
      span--;
    }
    const chart = new Chart(ctx, {
    type: 'line',
    data: {
          labels: span_days,
          datasets: [{
            label: '総摂取カロリー',
            data: gon.achievementScore,
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
          }, {
            label: '目標カロリー',
            data: gon.absorbCalorie,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
          }]
        },
        options: {
          title: {
            display: true,
            text: ''
          },
          scales: {
            yAxes: [{
              ticks: {
                suggestedMax: 100,
                suggestedMin: 0,
                stepSize: 100,
                callback: function(value, index, values){
                  return  value +  'kcal'
                }
              }
            }]
          }                  
        }
    });
}

document.addEventListener('turbolinks:load', createGraph(7));