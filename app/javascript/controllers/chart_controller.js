// app/javascript/controllers/chart_controller.js
import { Controller } from "stimulus";
import Chart from "chart.js/auto";

export default class extends Controller {
  static targets = ["chart"];

  connect() {
    const labels = this.element.dataset.labels ? JSON.parse(this.element.dataset.labels) : [];
    const data = this.element.dataset.data ? JSON.parse(this.element.dataset.data) : [];

    if (labels.length && data.length) {
      const ctx = this.chartTarget.getContext("2d");

      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: 'Número de Funcionários x Faixa Salarial',
            data: data,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)'
              ],
              borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
              ],
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    }
  }
}
