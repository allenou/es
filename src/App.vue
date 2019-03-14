<template>
  <div id="app">
    <SearchBar @search="searchEmojiByKeyword($event)"></SearchBar>
    <EmojiList :list="results" v-if="results.length>0"></EmojiList>
    <footer>MIT © ALLEN</footer>
  </div>
</template>

<script>
import SearchBar from "./components/SearchBar";
import EmojiList from "./components/EmojiList";
export default {
  name: "app",
  components: {
    SearchBar,
    EmojiList
  },
  data() {
    return {
      all: [],
      results: []
    };
  },
  created() {
    this.initEmoji();
  },
  methods: {
    async initEmoji() {
      const emojilib = await import("emojilib");
      const emojiobj = emojilib.lib;
      this.all = Object.keys(emojiobj).map(name => ({
        name,
        ...emojiobj[name]
      }));
      this.results = this.all.slice(0, 100);
    },
    searchEmojiByKeyword(keyword) {
      const word = keyword.trim();
      if (!word) {
        this.results = this.all.slice(0, 100);
      } else {
        this.results = this.all.filter(
          item => item.name.includes(word) || item.keywords.includes(word)
        );
      }

      // fetch("https://emoji.getdango.com/api/emoji?q=" + keyword)
      //   .then(res => res.json())
      //   .then(res => {
      //     this.list = res.results;
      //   });
    }
  }
};
</script>

<style >
body {
  margin: 0;
}
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
}
ul {
  margin: auto;
}
footer {
  /* margin-top: 30px; */
  padding: 30px 0;
  color: #ccc;
}
</style>
