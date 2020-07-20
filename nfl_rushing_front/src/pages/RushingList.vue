<template>
  <LayoutDefault>
    <h3>NFL RushingList List</h3>
    <div v-if="loadingRushings"> Loading... </div>
    <div v-else>
      <div
        v-for="rushing in rushings"
        :key="rushing.id">
        <RushingRow
          :rushing="rushing"
        />
      </div>
    </div>
  </LayoutDefault>
</template>
<script>
// import store from '@/store/store'
import LayoutDefault from '@/layouts/LayoutDefault.vue'
import RushingRow from '@/components/RushingRow.vue'
import { mapState } from 'vuex'
export default {
  name: 'RushingList',
  components: {
    RushingRow,
    LayoutDefault
  },
  data () {
    return {
      loadingRushings: true,
      actionPermitted: true,
      errors: []
    }
  },
  computed: {
    ...mapState(['rushings'])
  },
  watch: {
  },
  created () {
    this.loadingRushings = true
    this.$store.dispatch('fetchRushingsStats')
      .then(() => {
        this.$nextTick(() => {
          this.loadingRushings = false
        })
      })
      .catch((error) => {
        console.error(error)
        this.errors.push('Error occured while retrieving RushingStats')
      })
  }
}
</script>
<style scoped>
</style>
