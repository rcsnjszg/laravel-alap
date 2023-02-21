import axios from 'axios';

export const http = axios.create({
  baseURL: `http://${import.meta.env.VITE_HOST}:${import.meta.env.VITE_LARAVEL_PORT}/api`
})