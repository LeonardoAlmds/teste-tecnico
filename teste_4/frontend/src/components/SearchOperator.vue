<template>
  <div class="search-operator">
    <div class="search-bar">
      <button v-if="!showFilter" @click="toggleFilter">Filtrar Dados</button>
      <div v-if="showFilter" class="filter-container">
        <input v-model="query" placeholder="Buscar operadora por razão social ou nome fantasia..." @keyup.enter="searchOperators" />
        <button @click="searchOperators">Buscar</button>
        <button @click="clearFilter" class="exit">Sair do Filtro</button>
      </div>
    </div>
    
    <Loading v-if="loading" :visible="loading" />
    
    <p v-if="error" class="error">{{ error }}</p>
    
    <p v-if="!loading && !paginatedResults.length && !error" class="no-results">
      Nenhum operador encontrado! Tente novamente com outro nome.
    </p>
    
    <table v-if="paginatedResults.length" class="operator-table">
      <thead>
        <tr>
          <th>Registro ANS</th>
          <th>Razão Social</th>
          <th>Nome Fantasia</th>
          <th>Cidade</th>
          <th>UF</th>
          <th>Detalhes</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="op in paginatedResults" :key="op.REGISTRO_ANS">
          <td :title="op.REGISTRO_ANS">{{ op.REGISTRO_ANS }}</td>
          <td :title="op.RAZAO_SOCIAL" class="truncate">{{ op.RAZAO_SOCIAL }}</td>
          <td :title="op.NOME_FANTASIA" class="truncate">{{ op.NOME_FANTASIA || 'Não Informado' }}</td>
          <td :title="op.CIDADE">{{ op.CIDADE }}</td>
          <td :title="op.UF" >{{ op.UF }}</td>
          <td><button @click="openModal(op)">Ver mais</button></td>
        </tr>
      </tbody>
    </table>
    
    <div v-if="total > 5" class="pagination">
      <button @click="prevPage" :disabled="currentPage === 1">Anterior</button>
      <span>Página {{ currentPage }} de {{ totalPages }}</span>
      <button @click="nextPage" :disabled="currentPage === totalPages">Próximo</button>
    </div>
    
    <OperatorModal v-if="selectedOperator" :operator="selectedOperator" @close="closeModal" />
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue';
import api from '../services/api';
import OperatorModal from './OperatorModal.vue';
import Loading from './Loading.vue';

export default {
  components: { OperatorModal, Loading },
  setup() {
    const query = ref('');
    const results = ref([]);
    const total = ref(0);
    const loading = ref(false);
    const error = ref(null);
    const currentPage = ref(1);
    const itemsPerPage = 5;
    const selectedOperator = ref(null);
    const showFilter = ref(false);

    const fetchAllOperators = () => {
      loading.value = true;
      setTimeout(async () => {
        try {
          const response = await api.get('/buscar/todos');
          results.value = response.data.operators;
          total.value = response.data.total_found;
        } catch (err) {
          error.value = err.message;
        } finally {
          loading.value = false;
        }
      }, 100);
    };

    const searchOperators = async () => {
      if (!query.value.trim()) return;
      loading.value = true;
      error.value = null;

      setTimeout(async () => {
        try {
          const response = await api.get('/buscar/nome_fantasia-razao_social', {
            params: { q: query.value }
          });
          results.value = response.data.operators;
          total.value = response.data.total_found;
          currentPage.value = 1; 
        } catch (err) {
          error.value = err.message;
        } finally {
          loading.value = false;
        }
      }, 100);
    };

    const toggleFilter = () => {
      showFilter.value = true;
    };

    const clearFilter = () => {
      showFilter.value = false;
      query.value = '';
      fetchAllOperators();
    };

    onMounted(fetchAllOperators);

    const totalPages = computed(() => Math.ceil(total.value / itemsPerPage));
    const paginatedResults = computed(() => results.value.slice((currentPage.value - 1) * itemsPerPage, currentPage.value * itemsPerPage));
    const nextPage = () => { if (currentPage.value < totalPages.value) currentPage.value++; };
    const prevPage = () => { if (currentPage.value > 1) currentPage.value--; };
    const openModal = (operator) => { selectedOperator.value = operator; };
    const closeModal = () => { selectedOperator.value = null; };

    return {
      query, results, total, loading, error, searchOperators, currentPage, totalPages, paginatedResults, nextPage, prevPage, selectedOperator, openModal, closeModal, showFilter, toggleFilter, clearFilter
    };
  }
};
</script>

<style scoped>
  .search-operator {
    margin-bottom: 45px;
  }

  .search-bar {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .search-bar input {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 3px;
    font-size: 16px;
  }
  .search-bar button {
    padding: 10px;
    background-color: var(--primary);
    color: white;
    border: 1px solid var(--primary);
    border-radius: 3px;
    cursor: pointer;
    font-weight: 600;
    font-size: 16px;
    transition: .1s ease-in-out;
  }

  .search-bar button:hover {
    background-color: var(--white);
    color: var(--primary);
  }

  .filter-container {
    display: flex;
    gap: 10px;
    width: 100%;
  }

  .filter-container input {
    flex: 1;
  }

  .filter-container .exit {
    background-color: var(--secondary);
    border: 1px solid var(--secondary);;
    transition: .1s ease-in-out;
  }

  .filter-container .exit:hover {
    background-color: var(--white);
    color: var(--secondary);
  }

  .no-results {
    text-align: center;
    color: var(--attention);
    font-weight: 600;
    margin-top: 15px;
    font-size: 18px;
    border: 2px solid var(--attention);
    padding: 10px;
    border-radius: 5px;
    font-family: var(--font-georama);
  }

  .error {
    text-align: center;
    color: var(--secondary);
    font-weight: 600;
    margin-top: 15px;
    font-size: 18px;
    border: 2px solid var(--secondary);
    padding: 10px;
    border-radius: 5px;
    font-family: var(--font-georama);
  }

  .operator-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    color: var(--color-font-table);
    font-weight: 400;
    font-family: var(--font-lexend);
  }

  .operator-table tbody tr:nth-child(odd) {
    background-color: var(--row-odd);
  }

  .operator-table tbody tr:nth-child(even) {
    background-color: var(--row-even);
  }

  .operator-table th, .operator-table td {
    padding: 10px;
    text-align: left;
    border: 1px solid var(--table-border);
    text-align: center;
  }

  .operator-table th {
    background-color: var(--table-header);
    color: var(--white); 
  }

  .operator-table button {
    font-size: 14px;
    padding: 5px;
    background-color: var(--green);
    color: var(--white);
    border: 1px solid var(--green);
    font-weight: 600;
    cursor: pointer;
    width: 90px;
    transition: .1s ease-in-out;
  }

  .operator-table button:hover {
    background-color: var(--white);
    color: var(--green);
  }

  .truncate {
    max-width: 300px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    font-family: var(--font-lexend);
  }

  .pagination button {
    padding: 10px;
    background-color: var(--primary);
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
  }

  .pagination button:disabled {
    background-color: var(--disabled);
    cursor: not-allowed;
  }

  .pagination span {
    margin: 0 10px;
    font-size: 14px;
    color: var(--pagination-text);
  }
</style>