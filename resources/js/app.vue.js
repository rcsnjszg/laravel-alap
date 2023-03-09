import {createApp} from 'vue';
import {createPinia} from 'pinia';
import {router} from '@/router/index.js'
import BSAlert from '@/components/layout/BSAlert.vue'
import App from '@/App.vue';

const app = createApp(App);
app.use(createPinia());
app.use(router);
app.component('ErrorComponent', BSAlert);
app.mount("#app");