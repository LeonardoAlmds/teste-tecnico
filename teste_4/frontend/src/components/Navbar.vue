<template>
    <nav class="navbar"></nav>
</template>

<script>
export default {
    data() {
        return {
            menuAberto: false
        };
    },
    methods: {
        toggleMenu() {
            this.menuAberto = !this.menuAberto;
        }
    }
};
</script>

<style scoped>
.navbar {
    background-color: var(--white);
    color: var(--white);
    padding: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    min-height: 60px;
    margin-bottom: 45px;
}

@media (min-width: 1400px) {
    .navbar {
        margin-bottom: 150px;
    }
}
</style>