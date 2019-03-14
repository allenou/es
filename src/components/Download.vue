<template>
  <div id="download" @click.stop.prevent="hideDownload">
    <div class="content">
      <i v-html="emoji2Image(emoji.char)"></i>
      <div class="type">
        <p @click="download('svg')">SVG</p>
        <p @click="download('jpg')">PNG</p>
      </div>
    </div>
  </div>
</template>
<script>
import twemoji from "twemoji";
export default {
  props: {
    emoji: Object
  },
  methods: {
    hideDownload() {
      this.$emit("hide");
    },
    emoji2Image(unicode) {
      return twemoji.parse(unicode, {
        folder: "svg",
        ext: ".svg"
      });
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
<style >
#download {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.7);
}
.content {
  width: 50%;
  margin: auto;
  padding: 30px;
  background-color: #fff;
}
#download img.emoji {
  max-width: 200px !important;
}
</style>
