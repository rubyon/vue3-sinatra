<template>
  <div class="about">
    <h1>This is an about page</h1>
    <span>{{ title }}</span>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'axios',
  data() {
    return {
      title: ''
    }
  },
  mounted() {
    const vm = this
    axios
      .get('http://localhost:8080/api/title')
      .then(function (response) {
        vm.title = response.data.title
      })
      .catch(function (error) {
        alert(error)
      })
  }
}
</script>
