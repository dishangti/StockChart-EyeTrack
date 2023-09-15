import Vue from 'vue'
import App from './App.vue'
// 引入eleui组件库
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.config.productionTip = false;
Vue.use(ElementUI);

new Vue({
    render: h => h(App),
}).$mount('#app')