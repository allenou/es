<template>
  <div id="shopping-car" @click.stop="hideShoppingCar" v-show="showCar">
    <div class="content">
      <p v-for="(item,index) in goods" :key="index">
        <i v-html="emoji2Image(item.char)"></i>
        <span>{{item.name}}</span>
      </p>
    </div>
  </div>
</template>
<script>
import twemoji from "twemoji";
export default {
  props: {
    goods: Array
  },
  data() {
    return {
      showCar: false
    };
  },
  created() {
    this.showShoppingCar();
  },
  methods: {
    emoji2Image(unicode) {
      return twemoji.parse(unicode, {});
    },
    showShoppingCar() {
      this.$bus.$on("show", () => {
        this.showCar = true;
      });
    },
    hideShoppingCar() {
      this.showCar = false;
    },
    download(type) {
      const emoji = this.emoji;
      const image = document.querySelector(".emoji");
      const img = new Image();
      img.crossOrigin = "";
      img.onload = function() {
        const canvas = document.createElement("canvas");
        const context = canvas.getContext("2d");
        canvas.width = image.width; //确保canvas的尺寸和图片一样
        canvas.height = image.height;

        context.drawImage(img, 0, 0, canvas.width, canvas.height); //将图片绘制到canvas中

        var tag = document.createElement("a");
        tag.download = emoji.name;
        tag.style.display = "none";
        tag.href = canvas.toDataURL("image/svg+xml");
        document.body.appendChild(tag);
        tag.click();
        document.body.removeChild(tag);
      };
      img.src = image.src;
    }
  }
};
</script>
<style scoped>
#shopping-car {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.7);
}
.content {
  overflow: hidden;
  float: right;
  height: 100%;
  width: 30%;
  padding: 10px;
  background-color: #ccc;
}
p {
  float: left;
  width: 25%;
  display: inline-block;
}
span {
  display: block;
  margin-top: 10px;
}
</style>
