<template>
  <header>
    <p>
      <input type="text" placeholder="Emoji name to search..." v-model="keyword" ref="search">
    </p>
    <GitHubBadge slug="allenou/emoji" fill="#fff"></GitHubBadge>
  </header>
</template>
<script>
import GitHubBadge from "vue-github-badge";
export default {
  components: {
    GitHubBadge
  },
  data() {
    return {
      keyword: ""
    };
  },
  watch: {
    keyword(keyword) {
      this.$emit("search", keyword);
    }
  },
  mounted() {
    this.autoFocus();
  },
  methods: {
    autoFocus() {
      this.$refs.search.focus();
    },
    showShoppingCar() {
      this.$bus.$emit("show");
    }
  }
};
</script>
<style scoped>
header {
  display: flex;
  align-items: center;
  padding: 20px 0;
  background-color: #3F51B5;
}
header /deep/ a{
  position: absolute!important ;
  top: inherit!important ;
}
p {
  width: 60%;
  margin: auto;
  padding: 0 30px;
  background-color: #fff;
}
input {
  width: 100%;
  height: 40px;
  margin-left: -16px;
  border: none;
  font-size: 18px;
  line-height: 40px;
  outline: none;
}
i {
  color: #fff;
}
</style>
