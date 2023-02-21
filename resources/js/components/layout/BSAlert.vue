<template>
  <div class="alert alert-danger">
    <h3>Hiba történt!</h3>
    <p> {{ error }} </p>
  </div>
</template>

<script setup>
const props = defineProps({ error: String });
</script>