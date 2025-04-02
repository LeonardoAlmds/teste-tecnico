<template>
  <div>
    <input v-model="query" placeholder="Buscar operadora..." />
    <button @click="searchOperators">Buscar</button>
    <p v-if="loading">Carregando...</p>
    <p v-if="error">{{ error }}</p>
    <ul>
      <li v-for="op in results" :key="op">{{ op.RAZAO_SOCIAL }}</li>
    </ul>
    <p>Total encontrado: {{ total }}</p>
  </div>
</template>

<script>
import { ref } from 'vue';
import api from '../services/api';

export default {
  setup() {
    const query = ref('');
    const results = ref([]);
    const total = ref(0);
    const loading = ref(false);
    const error = ref(null);

    const searchOperators = async () => {
      if (!query.value.trim()) return;
      loading.value = true;
      error.value = null;

      try {
        const response = await api.get('/buscar/nome_fantasia-razao_social', {
          params: { q: query.value }
        });
        results.value = response.data.operators;
        total.value = response.data.total_found;
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    return { query, results, total, loading, error, searchOperators };
  },
};
</script>