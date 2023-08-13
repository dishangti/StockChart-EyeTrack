<template>
  <div>
    <div class="structInfo">This test demo utilizes the Shanghai Composite Index.</div>
    <el-button style="display: inline-block" type="primary" size="small"
     @click="displayHeatMap" v-if="!isShowSaliency"
      >View Saliency Maps</el-button
    >
    <el-button style="display: inline-block" type="primary" size="small"
     @click="notDisplayHeatMap"  v-if="isShowSaliency"
      >Cancel Viewing Saliency Maps</el-button
    >
    <img src="./assets/imgs/test.png" v-if="!isShowSaliency" />
    <img
      style="width: 1000px; height: 400px"
      src="./assets/imgs/test_h.png"
      alt=""
      v-if="isShowSaliency"
    />
  </div>
</template>

<script>
export default {
  name: "Attention",
  data(){
    return {
        isShowSaliency: false,
    }
  },
  methods:{
    displayHeatMap(){
        this.isShowSaliency = true;
    },
    notDisplayHeatMap(){
        this.isShowSaliency = false;
    }
  }
};
</script>

<style scoped>
.structInfo {
  text-align: left;
  width: 300px;
  display: inline-block;
  font-size: 14px;
  margin-bottom: 20px;
}

img {
  width: 1000px;
  height: 400px;
}
</style>