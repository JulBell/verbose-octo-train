<template>
  <div>
    {{ rushing.playerName }} - {{ rushing.yards }}
  </div>
</template>

<script>
// import { mapActions } from 'vuex'

export default {
  name: 'RushingRow',
  components: {
  },
  props: {
    rushing: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
    }
  },
  computed: {

  },
  methods: {

  }
}
</script>

<style>
</style>
