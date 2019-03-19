<template>
  <div id="emoji-list">
    <input type="text" id="copy">
    <ul>
      <li v-for="(item,index) in list" :key="index">
        <p @click="addToShoppingCar(item)">
          <i v-html="emoji2Image(item.char)" @click="download($event,item)"></i>
          <span @click="copyEmojiName(item.name)">:{{item.name}}:</span>
        </p>
      </li>
    </ul>
    <div class="notification" v-show="copied">{{copyedText}} is now copied to your clipboard</div>
  </div>
</template>
<script>
import twemoji from "twemoji";

export default {
  props: {
    list: Array
  },
  data() {
    return {
      copied: false,
      copyedText: "",
      emoji: null
    };
  },
  watch: {
    copied(value) {
      if (value) {
        setTimeout(() => {
          this.copied = false;
        }, 1500);
      }
    }
  },
  methods: {
    emoji2Image(name) {
      return twemoji.parse(name, {});
    },
    copyEmojiName(name) {
      const input = document.querySelector("#copy");
      input.value = this.copyedText = ":" + name + ":";
      input.select();
      if (document.execCommand("copy")) {
        this.copied = true;
        document.execCommand("copy");
      }
    },

    download(e, emoji) {
      const image = e.target;
      const img = new Image();
      img.crossOrigin = "";
      img.onload = function() {
        const canvas = document.createElement("canvas");
        const context = canvas.getContext("2d");
        canvas.width = image.width*2;
        canvas.height = image.height*2;
        context.drawImage(img, 0, 0, canvas.width, canvas.height);

        var tag = document.createElement("a");
        tag.download = emoji.name;
        tag.style.display = "none";
        tag.href = canvas.toDataURL("image/png");
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
#copy {
  display: inline-block;
  position: absolute;
  z-index: -11;
  top: -100px;
  width: 10%;
  border: none;
}
#emoji-list {
  padding-top: 40px;
}
#emoji-list ul {
  display: flex;
  flex-wrap: wrap;

  width: 60%;
  margin: auto;
  padding: 30px;
  background-color: #fff;
}

#emoji-list li {

  width: 25%;

  height: 40px;
  margin-bottom: 30px;
  line-height: 40px;
 
  text-align: left;
  list-style: none;
}
#emoji-list li p {
  display: inline-block;
  cursor: pointer;
  white-space: nowrap;
  overflow: hidden;
  max-width: 90%;
  text-overflow: ellipsis;
}

#emoji-list img.emoji {
  max-width: 30px;
  margin-right: 10px;
  vertical-align: middle;
}
#emoji-list li p:hover span {
  font-weight: 700;
}
#emoji-list p:hover img.emoji {
  max-width: 32px;
}
/* #emoji-list li span{
   transition: all .6s ease-in;
} */
/* #emoji-list span {
  max-width: 75%;
  display: inline-block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  transition: all .6s ease-in;
} */
.notification {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  line-height: 40px;
  color: #fff;
  background-color: #4caf50;
}
</style>
