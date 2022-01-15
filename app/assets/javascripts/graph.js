function createGraph() { 
    const ctx = document.getElementById('prc').getContext("2d");
    const chart = new Chart(ctx, {
    type: 'bar',
    data: {
          labels: ['タンパク質', '脂質', '炭水化物'],
          datasets: [{
            label: '摂取量',
            data: [gon.total.protein, gon.total.fat, gon.total.carbon],
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)'
            ],
            borderWidth: 1
          }, {
            label: '目標量',
            data: [gon.user.weight*2, gon.user.weight*0.7, (gon.bmr*1.1-gon.user.weight*2*4-gon.user.weight*0.7*9)/4],
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)'
            ],
            borderWidth: 3
          }]
        },
        options: {
          title: {
            display: true,
            text: '栄養成分表'
          },
          scales: {
            yAxes: [{
              ticks: {
                suggestedMax: 100,
                suggestedMin: 0,
                stepSize: 10,
                callback: function(value, index, values){
                  return  value +  'g'
                }
              }
            }]
          }                  
        }
    });
}

document.addEventListener('turbolinks:load', createGraph);