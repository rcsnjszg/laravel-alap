import './bootstrap';
import {createApp} from "vue";
import App from "./App.vue";
import "bootstrap/scss/bootstrap.scss"
import "../css/app.scss"
const app = createApp(App);

app.mount("#app");