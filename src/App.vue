<template>
  <div id="app">
    <input type="text" v-model.lazy="keyword">
    <u>
      <li v-for="(item,index) in list" :key="index">{{item.text}}</li>
    </u>
  </div>
</template>

<script>
export default {
  name: "app",
  data() {
    return {
      keyword: "smile",
      list: []
    };
  },
  watch: {
    keyword(value) {
      this.searchEmoji(value);
    }
  },
  created() {
    this.searchEmoji(this.keyword);
  },
  methods: {
    searchEmoji(keyword) {
      fetch("https://emoji.getdango.com/api/emoji?q=" + keyword)
        .then(res => res.json())
        .then(res => {
          this.list = res.results;
        });
    },
    emoji2Image(code) {}
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
li {
  list-style: none;
}
</style>
