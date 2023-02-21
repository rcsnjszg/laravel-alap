<template>
  <nav-bar />
  <router-view />
</template>

<script setup>
import { RouterView } from 'vue-router';
import NavBar from '@/components/layout/BSNavBar.vue';
</script>