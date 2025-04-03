<template>
  <div v-if="operator" class="modal-overlay">
    <div class="modal-content">
      <h2>{{ operator.RAZAO_SOCIAL }}</h2>
      <div class="grid">
        <div class="grid-item"><span>Registro ANS:</span> {{ operator.REGISTRO_ANS || "Não Informado" }}</div>
        <div class="grid-item"><span>CNPJ:</span> {{ operator.CNPJ || "Não Informado" }}</div>
        <div class="grid-item"><span>Razão Social:</span> {{ operator.RAZAO_SOCIAL || "Não Informado" }}</div>
        <div class="grid-item"><span>Nome Fantasia:</span> {{ operator.NOME_FANTASIA || "Não Informado" }}</div>
        <div class="grid-item"><span>Modalidade:</span> {{ operator.MODALIDADE || "Não Informado" }}</div>
        <div class="grid-item">
          <span>Logradouro:</span> 
          {{ formatAddress(operator.LOGRADOURO, operator.NUMERO, operator.COMPLEMENTO) }}
        </div>

        <div class="grid-item"><span>Bairro:</span> {{ operator.BAIRRO || "Não Informado" }}</div>
        <div class="grid-item"><span>Cidade:</span> {{ operator.CIDADE || "Não Informado" }}</div>
        <div class="grid-item"><span>UF:</span> {{ operator.UF || "Não Informado" }}</div>
        <div class="grid-item"><span>CEP:</span> {{ operator.CEP || "Não Informado" }}</div>
        <div class="grid-item"><span>Telefone:</span> {{ "(" + operator.DDD + ")" + " " + operator.TELEFONE || "Não Informado" }}</div>
        <div class="grid-item"><span>Fax:</span> {{ operator.FAX || "Não Informado" }}</div>
        <div class="grid-item"><span>Email:</span> {{ operator.ENDERECO_ELETRONICO || "Não Informado" }}</div>
        <div class="grid-item"><span>Representante:</span> {{ operator.REPRESENTANTE || "Não Informado" }}</div>
        <div class="grid-item"><span>Cargo:</span> {{ operator.CARGO_REPRESENTANTE || "Não Informado" }}</div>
        <div class="grid-item"><span>Data Registro ANS:</span> {{ operator.DATA_REGISTRO_ANS || "Não Informado" }}</div>
      </div>
      <button class="close-btn" @click="$emit('close')">FECHAR</button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    operator: Object
  },
  methods: {
    formatAddress(logradouro, numero, complemento) {
      let address = logradouro || "Não Informado";
      
      if (numero) {
        address += `, ${numero}`;
      }
      if (complemento) {
        address += `, ${complemento}`;
      }

      return address;
    }
  }
};
</script>

<style scoped>
  .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.7);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 9999;
      font-family: var(--font-georama);
  }

  .modal-content {
      background: #fff;
      padding: 25px;
      border-radius: 12px;
      max-width: 1000px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
      text-align: left;
      color: #333;
      position: relative;
      animation: fadeIn 0.3s ease-in-out;
  }

  .modal-content h2 {
      font-size: 24px;
      margin-bottom: 15px;
      color: #222;
      text-align: center;
      font-weight: 600;
  }


  .grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr); 
      gap: 15px;
  }

  .grid-item {
      font-size: 16px;
      padding: 15px 30px;
      background: #f3f3f3;
      border-radius: 5px;
  }

  .grid-item span {
      color: #000;
      font-weight: 500;
      font-family: var(--font-lexend);
  }

  .close-btn {
      background-color: var(--secondary);
      border: 2px solid var(--secondary);
      font-family: var(--font-georama);
      color: var(--white);
      padding: 10px;
      text-align: center;
      width: 100%;
      margin-top: 15px;
      font-weight: 600;
      font-size: 16px;
      cursor: pointer;
      border-radius: 5px;
      transition: .3s ease-in-out;
  }

  .close-btn:hover {
      background-color: var(--white);
      color: var(--secondary);
  }
</style>
