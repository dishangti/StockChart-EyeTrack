(function(){"use strict";var t={4337:function(t,e,n){var i=n(6369),o=function(){var t=this,e=t._self._c;return e("div",{attrs:{id:"app"}},[e("Main")],1)},a=[],r=function(){var t=this,e=t._self._c;return e("div",{staticClass:"head"},[e("el-container",[e("el-header",[t._v(" Stock Chart Viewing Guidance System "),e("el-divider",{attrs:{direction:"vertical"}}),e("span",{staticClass:"moreInfo"},[t._v("Your Thoughtful Stock Market Analysis Assistant!")]),e("div",{staticClass:"logOut"},[e("i",{staticClass:"el-icon-switch-button"}),t._v(" Exit ")]),e("div",{staticClass:"userInfo"},[t._v("Username：Admin")])],1),e("el-container",[e("el-col",{staticStyle:{width:"300px"},attrs:{span:12}},[e("el-menu",[e("el-menu-item",{attrs:{index:"1"}},[e("i",{staticClass:"el-icon-menu"}),e("span",{attrs:{slot:"title"},slot:"title"},[t._v("Candlestick Chart Viewing Guide")])]),e("el-menu-item",{staticStyle:{"text-align":"left"},attrs:{index:"2"}},[e("i",{staticClass:"el-icon-document"}),e("span",{attrs:{slot:"title"},slot:"title"},[t._v("Others")])])],1)],1),e("el-container",[e("el-main",[e("Attention")],1),e("el-footer",{staticStyle:{height:"100px"}},[e("ol",[t._v('How to use "View the Saliency Maps"? '),e("li",[t._v("Saliency maps refer to regions in an image where attention is concentrated or allocated more prominently.")]),e("li",[t._v("In various saliency maps, the more yellow the color, the richer the information content of that region, indicating that it should be given more attention.")]),e("li",[t._v("This guidance is for reference only. The stock market carries risks, so please exercise caution when entering the market.")])])])],1)],1)],1)],1)},s=[],l=function(){var t=this,e=t._self._c;return e("div",[e("div",{staticClass:"structInfo"},[t._v("This test demo utilizes the Shanghai Composite Index.")]),t.isShowSaliency?t._e():e("el-button",{staticStyle:{display:"inline-block"},attrs:{type:"primary",size:"small"},on:{click:t.displayHeatMap}},[t._v("View Saliency Maps")]),t.isShowSaliency?e("el-button",{staticStyle:{display:"inline-block"},attrs:{type:"primary",size:"small"},on:{click:t.notDisplayHeatMap}},[t._v("Cancel Viewing Saliency Maps")]):t._e(),t.isShowSaliency?t._e():e("img",{attrs:{src:n(1996)}}),t.isShowSaliency?e("img",{staticStyle:{width:"1000px",height:"400px"},attrs:{src:n(7111),alt:""}}):t._e()],1)},c=[],u={name:"Attention",data(){return{isShowSaliency:!1}},methods:{displayHeatMap(){this.isShowSaliency=!0},notDisplayHeatMap(){this.isShowSaliency=!1}}},f=u,p=n(1001),h=(0,p.Z)(f,l,c,!1,null,"3e480fd5",null),d=h.exports,y={name:"Main",components:{Attention:d}},v=y,m=(0,p.Z)(v,r,s,!1,null,"0a2f87e4",null),g=m.exports,S={name:"App",components:{Main:g}},_=S,w=(0,p.Z)(_,o,a,!1,null,null,null),b=w.exports,k=n(8499),x=n.n(k);i["default"].config.productionTip=!1,i["default"].use(x()),new i["default"]({render:t=>t(b)}).$mount("#app")},1996:function(t,e,n){t.exports=n.p+"img/test.a0fd4315.png"},7111:function(t,e,n){t.exports=n.p+"img/test_h.ae7a0cf6.png"}},e={};function n(i){var o=e[i];if(void 0!==o)return o.exports;var a=e[i]={exports:{}};return t[i](a,a.exports,n),a.exports}n.m=t,function(){var t=[];n.O=function(e,i,o,a){if(!i){var r=1/0;for(u=0;u<t.length;u++){i=t[u][0],o=t[u][1],a=t[u][2];for(var s=!0,l=0;l<i.length;l++)(!1&a||r>=a)&&Object.keys(n.O).every((function(t){return n.O[t](i[l])}))?i.splice(l--,1):(s=!1,a<r&&(r=a));if(s){t.splice(u--,1);var c=o();void 0!==c&&(e=c)}}return e}a=a||0;for(var u=t.length;u>0&&t[u-1][2]>a;u--)t[u]=t[u-1];t[u]=[i,o,a]}}(),function(){n.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return n.d(e,{a:e}),e}}(),function(){n.d=function(t,e){for(var i in e)n.o(e,i)&&!n.o(t,i)&&Object.defineProperty(t,i,{enumerable:!0,get:e[i]})}}(),function(){n.g=function(){if("object"===typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(t){if("object"===typeof window)return window}}()}(),function(){n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)}}(),function(){n.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})}}(),function(){n.p=""}(),function(){var t={143:0};n.O.j=function(e){return 0===t[e]};var e=function(e,i){var o,a,r=i[0],s=i[1],l=i[2],c=0;if(r.some((function(e){return 0!==t[e]}))){for(o in s)n.o(s,o)&&(n.m[o]=s[o]);if(l)var u=l(n)}for(e&&e(i);c<r.length;c++)a=r[c],n.o(t,a)&&t[a]&&t[a][0](),t[a]=0;return n.O(u)},i=self["webpackChunkk_eye"]=self["webpackChunkk_eye"]||[];i.forEach(e.bind(null,0)),i.push=e.bind(null,i.push.bind(i))}();var i=n.O(void 0,[998],(function(){return n(4337)}));i=n.O(i)})();
//# sourceMappingURL=app.ffd8c231.js.map