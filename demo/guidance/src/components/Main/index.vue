<template>
  <div class="head">
    <el-container>
      <el-header>
        Stock Chart Viewing Guidance System
        <el-divider direction="vertical"></el-divider>
        <span class="moreInfo">Your Thoughtful Stock Market Analysis Assistant!</span>
        <div class="logOut">
          <i class="el-icon-switch-button"></i>
          Exit
        </div>

        <div class="userInfo">Username：Admin</div>
      </el-header>
      <el-container>
          <el-col :span="12" style="width:300px">
            <el-menu>
              <el-menu-item index="1">
                <i class="el-icon-menu"></i>
                <span slot="title">Candlestick Chart Viewing Guide</span>
              </el-menu-item>
              <el-menu-item index="2" style="text-align:left">
                <i class="el-icon-document"></i>
                <span slot="title">Others</span>
              </el-menu-item>
            </el-menu>
          </el-col>
        
        <el-container>
          <el-main><Attention/></el-main>
          <el-footer style="height:100px">
            
            <ol>How to use "View the Saliency Maps"?
               <li>Saliency maps refer to regions in an image where attention is concentrated or allocated more prominently.</li>
               <li>In various saliency maps, the more yellow the color, the richer the information content of that region, indicating that it should be given more attention.</li>
               <li>This guidance is for reference only. The stock market carries risks, so please exercise caution when entering the market.</li>
            </ol>
            
          </el-footer>
        </el-container>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import Attention from '../Attention/index.vue'
export default {
     name: 'Main',
  components: {
    Attention
  }
};
</script>

<style lang= 'css' scoped>
.head :deep() .el-header {
  background-color: #2f333e;
  color: white;
  text-align: left;
  
  line-height: 60px;
  font-weight: bold;
  font-size: 18px;
}
.el-footer {
  background-color: #b3c0d1;
  color: white;
  text-align: left;
  font-size: 14px;
  height: 100px;
}
.el-header :deep() .userInfo {
  padding-right: 10px;
  float: right;
  font-weight: normal;
  font-size: 16px;
}
.logOut {
  float: right;
  font-weight: normal;
  font-size: 16px;
}
.moreInfo {
  font-weight: normal;
  font-size: 13px;
}
.el-aside {
  background-color: white;
  color: #333;
  text-align: center;
  line-height: 100px;
}

.el-main {
  background-color: #e9eef3;
  height: 500px;
  padding: 10px;
}

</style>