<template>
  <div id="app">
    <SearchBar @search="searchEmojiByKeyword($event)"></SearchBar>
    <main>
      <EmojiList :list="results" v-if="results.length>0"></EmojiList>
    </main>
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
          item =>
            item.name.includes(word) ||
            word.includes(item.name) ||
            item.keywords.includes(word) ||
            word.includes(item.char)
        );
      }
    }
  }
};
</script>

<style >
html,
body {
  margin: 0;
  background-color: #efefef;
}
p {
  margin: 0;
}
#app {
  display: flex;
  display: -webkit-flex; /* Safari */
  min-height: 100vh;
  flex-direction: column;
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
main {
  flex: 1;
}

footer {
  padding: 30px 0;
  color: #ccc;
}
</style>
