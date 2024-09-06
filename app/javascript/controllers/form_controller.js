import { Controller } from "@hotwired/stimulus"

const CEP_API_URL = 'https://viacep.com.br/ws/';

export default class extends Controller {
  static targets = ["salary", "inss", "address", "neighborhood", "city", "state", "form", "error"]

  connect() {
  }

  changeSalary(event) {
    // Format the salary input and remove currency symbol for URL
    let formattedValue = this.salaryTarget.value.replace("R$", "").replace(".", "").trim();
    this.salaryTarget.value = this.currency(this.salaryTarget.value)
  
    // Send the formatted value in the request
    const url = `/collaborators/calculate_inss_discount/${encodeURIComponent(formattedValue)}`;
    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.inssTarget.value = this.currency(data.inss_discount);
      });
  }

  currency(value) {
    // Remove a formatação existente e converte para número
    value = Number(value.replace(/\./g, "").replace("R$", "").replace(",", "."));
    
    // Formata no padrão brasileiro com separadores corretos
    return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(value);
  }

  maskCPF(event) {
    let cpf = event.target.value;
  
    cpf = cpf.replace(/\D/g, "");
    if (cpf.length > 11) {
      cpf = cpf.substring(0, 11);
    }
    cpf = cpf.replace(/(\d{3})(\d)/, "$1.$2");
    cpf = cpf.replace(/(\d{3})(\d)/, "$1.$2");
    cpf = cpf.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
  
    event.target.value = cpf;
  }

  maskPhone(event) {
    let value = event.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,5})(\d{0,4})/)
    event.target.value = !value[2] ? value[1] : '(' + value[1] + ') ' + value[2] + (value[3] ? '-' + value[3] : '')
  }

  maskCep(event) {
    let value = event.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,3})(\d{0,3})/)
    event.target.value = !value[2] ? value[1] : value[1] + '.' + value[2] + (value[3] ? '-' + value[3] : '')
  }

  async getAddress(event) {
    const cep = event.target.value.replace(/\D/g, '');
    if (cep.length !== 8) return;

    try {
      const response = await fetch(`${CEP_API_URL}${cep}/json/`);
      if (!response.ok) throw new Error('Network response was not ok');
      const data = await response.json();
      
      if (data.erro) {
        this.showError('CEP não encontrado.');
        this.addressTarget.value = ''
        this.cityTarget.value = ''
        this.neighborhoodTarget.value = ''
        this.stateTarget.value = ''
        return;
      }

      this.addressTarget.value = data.logradouro;
      this.cityTarget.value = data.localidade;
      this.neighborhoodTarget.value = data.bairro;
      this.stateTarget.value = data.uf;
      this.hideError(); // Hide error message if data is valid
    } catch (error) {
      this.showError('Endereço não encontrado');
      this.addressTarget.value = ''
      this.cityTarget.value = ''
      this.neighborhoodTarget.value = ''
      this.stateTarget.value = ''
    }
  }

  showError(message) {
    const errorElement = this.errorTarget;
    errorElement.textContent = message;
    errorElement.classList.remove('d-none');
  }

  hideError() {
    this.errorTarget.textContent = '';
    this.errorTarget.classList.add('d-none');
  }

  parseCurrency(value) {
    return value.replace("R$", "").replace(".", "").replace(",", ".").trim();
  }

  submitForm(event) {
    event.preventDefault();
    this.convertFieldsToDecimal();
    this.formTarget.submit(); // Enviar o formulário
  }

  convertFieldsToDecimal() {
    this.salaryTarget.value = this.parseCurrency(this.salaryTarget.value);
    this.inssTarget.value = this.parseCurrency(this.inssTarget.value);
  }
}