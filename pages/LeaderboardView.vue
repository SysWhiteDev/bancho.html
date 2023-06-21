<template>
  <div class="wrapper">
   
    <div>
       <alert />
      <div class="tabletitle">
        <div class="title">Leaderboard</div>
        <div class="selectors">
          <div class="selector">
            <div
              @click="selectsort('pp')"
              :class="{ sactive: selecteddata.sorting === sorts.pp }"
            >
              <i class="fa-solid fa-subscript"></i>
              <p>pp</p>
            </div>
            <div
              @click="selectsort('score')"
              :class="{ sactive: selecteddata.sorting === sorts.score }"
            >
              <i class="fa-solid fa-star"></i>
              <p>score</p>
            </div>
          </div>
          <div class="selector">
            <div
              :class="{ sactive: selecteddata.mode == modes.std }"
              @click="selectmode('std')"
            >
              <p>osu!std</p>
            </div>
            <div
              :class="{
                sactive: selecteddata.mode == modes.taiko,
                sdisabled: selecteddata.mod == mods.ap,
              }"
              @click="selectmode('taiko')"
            >
              <p>osu!taiko</p>
            </div>
            <div
              :class="{
                sactive: selecteddata.mode == modes.catch,
                sdisabled: selecteddata.mod == mods.ap,
              }"
              @click="selectmode('catch')"
            >
              <p>osu!catch</p>
            </div>
            <div
              :class="{
                sactive: selecteddata.mode == modes.mania,
                sdisabled:
                  selecteddata.mod == mods.ap || selecteddata.mod == mods.rx,
              }"
              @click="selectmode('mania')"
            >
              <p>osu!mania</p>
            </div>
          </div>
          <div class="selector">
            <div
              @click="this.selectmod('vn')"
              :class="{ sactive: selecteddata.mod == mods.vn }"
            >
              <i class="fa-solid fa-martini-glass-empty"></i>
              <p>vn</p>
            </div>
            <div
              @click="this.selectmod('rx')"
              :class="{
                sactive: selecteddata.mod == mods.rx,
                sdisabled: selecteddata.mode == modes.mania,
              }"
            >
              <i class="fa-solid fa-martini-glass-citrus"></i>
              <p>rx</p>
            </div>
            <div
              @click="this.selectmod('ap')"
              :class="{
                sactive: selecteddata.mod == mods.ap,
                sdisabled:
                  selecteddata.mode == modes.mania ||
                  selecteddata.mode == modes.taiko ||
                  selecteddata.mode == modes.catch,
              }"
            >
              <i class="fa-solid fa-plane"></i>
              <p>ap</p>
            </div>
          </div>
        </div>
      </div>

      <div class="loadingwrapper" v-if="loading && !error">
        <img class="loading" src="@/assets/icons/loading.svg" />
        <p>Hold tight, we are still loading...</p>
      </div>
      <div class="loadingwrapper" v-if="error">
        <img
          class="loading"
          src="@/assets/icons/error.svg"
          style="animation: none"
        />
        <p>Something went wrong... please try again later.</p>
      </div>
      <div v-if="!loading && !error">
        <div
          class="top top1 player"
          @click="$router.push(`/u/${lbdata[0].player_id}`)"
        >
          <div class="leaderboard-player-rank">
            <i class="fa-solid fa-trophy badge" style="color: #f9cb6b"></i>
          </div>
          <div class="userdata">
            <div class="leaderboard-player-name">
              <p>
                {{ lbdata[0].name
                }}<img :src="getFlagURL(lbdata[0].country)" class="flag" />
              </p>
              <div class="stats">
                <div class="pp">
                  <p v-if="selecteddata.sorting == sorts.pp">
                    {{ formatNumber(lbdata[0].pp) }}
                    <br /><span style="font-weight: bold">pp</span>
                  </p>
                  <p v-else>
                    {{ formatNumber(lbdata[0].rscore) }}<br /><span
                      style="font-weight: bold"
                      >score</span
                    >
                  </p>
                </div>
                <div class="acc">
                  <p>
                    {{ lbdata[0].acc.toFixed(2) }}%<br /><span
                      style="font-weight: bold"
                      >acc</span
                    >
                  </p>
                </div>
                <div class="plays">
                  <p>
                    {{ lbdata[0].plays }}<br /><span style="font-weight: bold"
                      >plays</span
                    >
                  </p>
                </div>
                <div class="combo">
                  <p>
                    {{ lbdata[0].max_combo }}<br /><span
                      style="font-weight: bold"
                      >max combo</span
                    >
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="top23">
          <div
            class="top top2 player"
            style="margin-top: 0"
            @click="$router.push(`/u/${lbdata[1].player_id}`)"
          >
            <div class="leaderboard-player-rank">
              <i class="fa-solid fa-medal badge" style="color: #999999"></i>
            </div>
            <div class="userdata">
              <div class="leaderboard-player-name">
                <p>
                  {{ lbdata[1].name
                  }}<img :src="getFlagURL(lbdata[1].country)" class="flag" />
                </p>
                <div class="stats" style="font-size: clamp(15px, 5vw, 17px)">
                  <div class="pp">
                    <p v-if="selecteddata.sorting == sorts.pp">
                      {{ formatNumber(lbdata[1].pp) }}
                      <br /><span style="font-weight: bold">pp</span>
                    </p>
                    <p v-else>
                      {{ formatNumber(lbdata[1].rscore) }}<br /><span
                        style="font-weight: bold"
                        >score</span
                      >
                    </p>
                  </div>
                  <div class="acc">
                    <p>
                      {{ lbdata[1].acc.toFixed(2) }}%<br /><span
                        style="font-weight: bold"
                        >acc</span
                      >
                    </p>
                  </div>
                  <div class="plays">
                    <p>
                      {{ lbdata[1].plays }}<br /><span style="font-weight: bold"
                        >plays</span
                      >
                    </p>
                  </div>
                  <div class="combo">
                    <p>
                      {{ lbdata[1].max_combo }}<br /><span
                        style="font-weight: bold"
                        >max combo</span
                      >
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div
            class="top top3 player"
            style="margin-top: 0"
            @click="$router.push(`/u/${lbdata[2].player_id}`)"
          >
            <div class="leaderboard-player-rank">
              <i
                class="fa-solid fa-award badge"
                style="color: rgb(165, 103, 63)"
              ></i>
            </div>
            <div class="userdata">
              <div class="leaderboard-player-name">
                <p>
                  {{ lbdata[2].name
                  }}<img :src="getFlagURL(lbdata[2].country)" class="flag" />
                </p>
                <div class="stats" style="font-size: clamp(15px, 5vw, 17px)">
                  <div class="pp">
                    <p v-if="selecteddata.sorting == sorts.pp">
                      {{ formatNumber(lbdata[2].pp) }}
                      <br /><span style="font-weight: bold">pp</span>
                    </p>
                    <p v-else>
                      {{ formatNumber(lbdata[2].rscore) }}<br /><span
                        style="font-weight: bold"
                        >score</span
                      >
                    </p>
                  </div>
                  <div class="acc">
                    <p>
                      {{ lbdata[2].acc.toFixed(2) }}%<br /><span
                        style="font-weight: bold"
                        >acc</span
                      >
                    </p>
                  </div>
                  <div class="plays">
                    <p>
                      {{ lbdata[0].plays }}<br /><span style="font-weight: bold"
                        >plays</span
                      >
                    </p>
                  </div>
                  <div class="combo">
                    <p>
                      {{ lbdata[2].max_combo }}<br /><span
                        style="font-weight: bold"
                        >max combo</span
                      >
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="player" style="background: transparent; padding: 0">
          <div class="left"></div>
          <div class="right" style="padding: 0">
            <p
              v-if="selecteddata.sorting == sorts.pp"
              style="padding-right: 21px"
            >
              pp
            </p>
            <p v-else style="width: 6vw">score</p>
            <p>acc</p>
            <p>plays</p>
            <p style="padding-left: 5px; padding-right: 10px">max combo</p>
          </div>
        </div>
        <div
          class="player top4"
          v-for="(player, index) in lbdata.slice(3)"
          :key="player.player_id"
          @click="$router.push(`/u/${player.player_id}`)"
        >
          <div class="left">
            <img :src="getFlagURL(player.country)" class="flag" />
            <div class="leaderboard-player-rank">#{{ index + 4 }}</div>
            <div class="leaderboard-player-name">{{ player.name }}</div>
          </div>
          <div class="right">
            <p
              v-if="selecteddata.sorting == sorts.pp"
              style="padding-right: 20px"
            >
              {{ formatNumber(player.pp) }}pp
            </p>
            <p v-else style="width: 6vw">{{ formatNumber(player.rscore) }}</p>
            <p>{{ player.acc.toFixed(2) }}%</p>
            <p>{{ player.plays }}</p>
            <p>{{ player.max_combo }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const config = useRuntimeConfig();
</script>

<script>
export default {
  data() {
    return {
      loading: true,
      error: false,
      lbdata: null,
      modes: {
        std: 0,
        taiko: 1,
        catch: 2,
        mania: 3,
      },
      mods: {
        vn: 0,
        rx: 4,
        ap: 8,
      },
      sorts: {
        pp: "pp",
        score: "rscore",
      },
      selecteddata: {
        mode: 0,
        mod: 0,
        sorting: "pp",
      },
    };
  },
  mounted() {
    this.selecteddata = {
      mode: this.modes[this.$route.params.mode] || this.selecteddata.mode,
      mod: this.mods[this.$route.params.mod] || this.selecteddata.mod,
      sorting:
        this.sorts[this.$route.params.sorting] || this.selecteddata.sorting,
    };
    this.getlbdata();
  },
  computed: {
    filteredLbdata() {
      return this.lbdata.filter((player, index) => index > 2);
    },
  },
  methods: {
    async getlbdata() {
      this.loading = true;
      this.error = false;
      this.lbdata = null;
      const lbdata = await $fetch(
        `${this.$config.public.api_url}get_leaderboard?mode=${
          this.selecteddata.mode + this.selecteddata.mod
        }&sort=${this.selecteddata.sorting}`
      ).catch((error) => {
        this.error = true;
      });
      this.lbdata = lbdata.leaderboard;
      this.loading = false;
    },
    selectmode(mode) {
      this.selecteddata.mode = this.modes[mode];
      this.getlbdata();
    },
    selectmod(mod) {
      this.selecteddata.mod = this.mods[mod];
      this.getlbdata();
    },
    selectsort(sort) {
      this.selecteddata.sorting = this.sorts[sort];
      this.getlbdata();
    },
    getFlagURL(country) {
      let url = "https://osu.ppy.sh/assets/images/flags/";

      for (let idx = 0; idx < country.length; idx++) {
        let char = country[idx].toUpperCase();
        url += (char.charCodeAt() + 127397).toString(16);
        url += idx !== country.length - 1 ? "-" : ".svg";
      }

      return url;
    },
    formatNumber(number) {
      const abbreviations = {
        " million": 6,
        " billion": 9,
      };
      for (const abbreviation in abbreviations) {
        if (Math.abs(number) >= 10 ** abbreviations[abbreviation]) {
          const roundedNumber = number / 10 ** abbreviations[abbreviation];
          return roundedNumber.toFixed(2) + abbreviation;
        }
      }

      return Math.round(number)
        .toString()
        .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
};
</script>
<style lang="css" scoped >
@import url("@/assets/styles/pages/lb.css");
</style>