<template>
  <header>
    <input type="text" id="search" placeholder="Try to search..." v-model="keyword">
    <!-- <i @click="showShoppingCar">购物车</i> -->
  </header>
</template>
<script>
export default {
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
      document.querySelector("#search").focus();
    },
    showShoppingCar() {
      this.$bus.$emit("show");
    }
  }
};
</script>
<style scoped>
header {
  padding: 30px 0;
  background-color: #232323;
}
input {
  width: 60%;
  height: 40px;
  margin: auto;
  text-indent: 14px;
  border: 1px solid #efefef;
  font-size: 18px;
  line-height: 40px;
  outline: none;
}
i {
  color: #fff;
}
</style>
