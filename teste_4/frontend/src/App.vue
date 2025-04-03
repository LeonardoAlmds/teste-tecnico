<template>
  <Navbar />
  <div class="container">
    <h1 class="title">Operadoras Ativas</h1>
    <SearchOperator />
  </div>
</template>

<script>
import SearchOperator from './components/SearchOperator.vue';
import Navbar from './components/Navbar.vue';

export default {
  components: {
    SearchOperator,
    Navbar,
  },
};
</script>

<style>
  .container {
    padding: 0 90px;
    height: 100%;
    display: flex;
    flex-direction: column;  
    justify-content: center; 
  }

  .title {
    font-size: 36px;
    font-family: var(--font-georama);
    font-weight: 600;
    margin-bottom: 30px;
  }

  @media (min-width: 1400px) {
    .container {
      padding: 0 170px;
  }
}

</style>