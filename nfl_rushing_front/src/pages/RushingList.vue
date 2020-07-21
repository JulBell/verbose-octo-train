<template>
  <LayoutDefault>
    <h3>NFL RushingList List</h3>
    <b-container fluid>
      <b-row>
        <b-col
          lg="6">
          <b-form-group
            label="Filter"
            label-cols-sm="3"
            label-align-sm="right"
            label-size="sm"
            label-for="filterInput"
            class="mb-0"
          >
            <b-input-group size="sm">
              <b-form-input
                id="filterInput"
                v-model="filter"
                type="search"
                placeholder="Type to Search"
              />
              <b-input-group-append>
                <b-button
                  :disabled="!filter"
                  @click="filter = ''">Clear</b-button>
              </b-input-group-append>
            </b-input-group>
          </b-form-group>
        </b-col>
        <b-col lg="6">
          <b-form-group>
            <b-button
              :disabled="csvLoading"
              @click="exportToCSV()">
              <b-spinner
                v-if="csvLoading"
                small/>
              Export to CSV
            </b-button>
          </b-form-group>
        </b-col>
      </b-row>
      <b-table
        id="rushing-table"
        :items="itemsProvider"
        :fields="fields"
        :filter="filter"
        :no-sort-reset="true"
        :sort-by.sync="sortBy"
        :filter-included-fields="filterOn"
        no-border-collapse
        responsive
        @sort-changed="sortingChanged"/>
      <b-row>
        <b-col lg="6">
          <b-form-group>
            <b-button
              :disabled="!hasPreviousPage"
              @click="previousRushings()">Previous</b-button>
          </b-form-group>
        </b-col>
        <b-col lg="6">
          <b-form-group>
            <b-button
              :disabled="!hasNextPage"
              @click="nextRushings()">Next</b-button>
          </b-form-group>
        </b-col>
      </b-row>
    </b-container>
  </LayoutDefault>
</template>
<script>
import LayoutDefault from '@/layouts/LayoutDefault.vue'
import RushingRow from '@/components/RushingRow.vue'
import { apolloClient } from '../graphql/client'
import rushingsData from '@/graphql/RushingsConnection.gql'
import { mapState, mapActions } from 'vuex'
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
      errors: [],
      fields: [
        { key: 'playerName', sortable: false, stickyColumn: true },
        { key: 'team', sortable: false },
        { key: 'position', sortable: false },
        { key: 'attempts', sortable: false },
        { key: 'attemptsPerGameAvg', sortable: false },
        { key: 'yards', sortable: true },
        { key: 'yardsPerGameAvg', sortable: false },
        { key: 'yardsPerAttemptAvg', sortable: false },
        { key: 'touchdowns', sortable: true },
        { key: 'longuest', sortable: true },
        { key: 'firstDowns', sortable: false },
        { key: 'firstDownsPct', sortable: false },
        { key: 'twentyPlus', sortable: false },
        { key: 'fourtyPlus', sortable: false },
        { key: 'fumbles', sortable: false }
      ],
      filter: null,
      filterOn: ['playerName'],
      sortBy: 'yards',
      endCursor: null,
      hasPreviousPage: false,
      hasNextPage: false,
      first: 10,
      last: null,
      csvLoading: false
    }
  },
  computed: {
    ...mapState(['rushings'])
  },
  watch: {
  },
  methods: {
    ...mapActions(['fetchRushingsStats']),
    itemsProvider (ctx, callback) {
      ctx.endCursor = this.endCursor
      ctx.startCursor = this.startCursor
      ctx.first = this.first
      ctx.last = this.last
      this.fetchRushingsStats(ctx).then(() => {
        this.$nextTick(() => {
          const items = this.rushings.edges.map(edge => edge.node)
          this.loadingRushings = false
          this.hasPreviousPage = this.rushings.pageInfo.hasPreviousPage
          this.hasNextPage = this.rushings.pageInfo.hasNextPage
          callback(items)
        })
      })
    },
    nextRushings () {
      this.endCursor = this.rushings.pageInfo.endCursor
      this.startCursor = null
      this.first = 10
      this.last = null
      this.$root.$emit('bv::refresh::table', 'rushing-table')
    },
    previousRushings () {
      this.startCursor = this.rushings.pageInfo.startCursor
      this.endCursor = null
      this.first = null
      this.last = 10
      this.$root.$emit('bv::refresh::table', 'rushing-table')
    },
    sortingChanged (ctx) {
      this.endCursor = null
      this.startCursor = null
    },
    async exportToCSV () {
      this.csvLoading = true
      await apolloClient.query({
        query: rushingsData,
        variables: {
          sortBy: this.sortBy,
          sortDesc: this.sortDesc,
          nameFilter: this.filter
        }
      }).then((res) => {
        let rushingData = res.data.rushings.edges.map(edge => edge.node)
        let csvContent = 'data:text/csv;charset=utf-8,'
        csvContent += [
          Object.keys(rushingData[0]).join(';'),
          ...rushingData.map(item => Object.values(item).join(';'))
        ]
          .join('\n')
          .replace(/(^\[)|(\]$)/gm, '')

        const data = encodeURI(csvContent)
        const link = document.createElement('a')
        link.setAttribute('href', data)
        link.setAttribute('download', 'export.csv')
        link.click()
        this.csvLoading = false
      })
    }
  }
}
</script>
<style scoped>
</style>
