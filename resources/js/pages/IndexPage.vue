<template>
  <h1 class="">Helló, Vite és Vue meg Laravel!</h1>
  <ul>
    <li v-for="item in list" :key="item.id">{{ item.name }}</li>
  </ul>
</template>

<script setup>
import { http } from '@/helpers/http.js'
import { onMounted, reactive } from 'vue';
const list = reactive([]);
onMounted(console.log(http.get('/asd')))
</script>
