<template>
  <div id="app">
    <div class="notification" v-show="copied">{{copyedText}} is now copied to your clipboard</div>
    <input type="text" id="copy">
    <input type="text" id="search" placeholder="Try to search..." v-model="keyword">
    <ul>
      <li v-for="(item,index) in results" :key="index">
        <p @click="copyUnicode(item.name)">
          <i v-html="emoji2Image(item.char)"></i>
          <span>:{{item.name}}:</span>
        </p>
      </li>
    </ul>
  </div>
</template>

<script>
import twemoji from "twemoji";
import { setTimeout } from "timers";
export default {
  name: "app",
  data() {
    return {
      keyword: "",
      all: [],
      results: [],
      copied: false,
      copyedText: ""
    };
  },
  watch: {
    keyword(value) {
      this.searchEmojiByKeyword(value);
    },
    copied(value) {
      if (value) {
        setTimeout(() => {
          this.copied = false;
        }, 1500);
      }
    }
  },
  created() {
    this.initEmoji();
  },
  mounted() {
    this.autoFocus();
  },
  methods: {
    autoFocus() {
      document.querySelector("#search").focus();
    },
    async initEmoji() {
      const emojilib = await import("emojilib");
      const emojiobj = emojilib.lib;
      this.all = Object.keys(emojiobj).map(name => ({
        name,
        ...emojiobj[name]
      }));
      this.results = this.all.slice(100, 200);
    },
    copyUnicode(unicode) {
      const input = document.querySelector("#copy");
      input.value = this.copyedText = ":" + unicode + ":";
      input.select();
      if (document.execCommand("copy")) {
        this.copied = true;
        document.execCommand("copy");
      }
    },
    searchEmojiByKeyword(keyword) {
      const word = keyword.trim();
      if (!word) {
        this.results = this.all.slice(100, 200);
      } else {
        this.results = this.all.filter(item => item.name.includes(word));
      }

      // fetch("https://emoji.getdango.com/api/emoji?q=" + keyword)
      //   .then(res => res.json())
      //   .then(res => {
      //     this.list = res.results;
      //   });
    },
    emoji2Image(unicode) {
      return twemoji.parse(unicode, { className: "twemoji " });
    }
  }
};
</script>

<style>
#app {
  max-width: 996px;
  margin: auto;
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.notification {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  line-height: 40px;
  color: #fff;
  background-color: #4caf50;
}
#copy {
  display: inline-block;
  position: absolute;
  z-index: -11;
  width: 10%;
  border: none;
}
ul {
  overflow: hidden;
  width: 100%;
  padding-left: 0;
}
li {
  float: left;
  width: 25%;
  padding: 14px 0;
  text-align: left;
  list-style: none;

  white-space: nowrap;
  overflow: hidden;
}
li p {
  display: inline-block;
  cursor: pointer;
}
li img {
  max-width: 30px;
  margin-right: 10px;
  vertical-align: middle;
}
li span {
  max-width: 75%;
  display: inline-block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
input {
  width: 100%;
  height: 40px;
  text-indent: 14px;
  border: 1px solid #efefef;
  font-size: 18px;
  line-height: 40px;
  outline: none;
}
</style>
