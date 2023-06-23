<template>
  <div class="wrapper">
    <div>
      <Alert />
      <div class="titlebar">
        <div class="left">
          <i class="fa-solid fa-user"></i>
          <p>player info</p>
        </div>
        <div class="right">
          <div class="selector">
            <div
              :class="{ sactive: selecteddata.mode == modes.std }"
              @click="selectmode('std')"
            >
              osu!std
            </div>
            <div
              :class="{
                sactive: selecteddata.mode == modes.taiko,
                sdisabled: selecteddata.mod == mods.ap,
              }"
              @click="selectmode('taiko')"
            >
              osu!taiko
            </div>
            <div
              :class="{
                sactive: selecteddata.mode == modes.catch,
                sdisabled: selecteddata.mod == mods.ap,
              }"
              @click="selectmode('catch')"
            >
              osu!catch
            </div>
            <div
              :class="{
                sactive: selecteddata.mode == modes.mania,
                sdisabled:
                  selecteddata.mod == mods.ap || selecteddata.mod == mods.rx,
              }"
              @click="selectmode('mania')"
            >
              osu!mania
            </div>
            <div
              @click="this.selectmod('vn')"
              :class="{ sactive: selecteddata.mod == mods.vn }"
            >
              <i class="fa-solid fa-martini-glass-empty"></i>
            </div>
            <div
              @click="this.selectmod('rx')"
              :class="{
                sactive: selecteddata.mod == mods.rx,
                sdisabled: selecteddata.mode == modes.mania,
              }"
            >
              <i class="fa-solid fa-martini-glass-citrus"></i>
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
            </div>
          </div>
        </div>
      </div>
      <div class="userprofile">
        <div
          class="banner"
          :style="
            player_info
              ? `background-image: url(https://${config.public.base_url}banners/${player_info.info.id}); background-size: cover;`
              : undefined
          "
          :class="{ bannerclosed: bannerclosed }"
        ></div>
        <div class="userdata" :class="{ bannerclosed: bannerclosed }">
          <img
            :src="
              player_info
                ? `https://a.${config.public.base_url}${player_info.info.id}`
                : `https://a.${config.public.base_url}`
            "
            class="pfp"
            :class="{ online: player_status && player_status.online }"
          />

          <div class="text">
            <p class="usernametext">
              {{ player_info ? player_info.info.name : "..." }}
            </p>
            <div class="country">
              <img
                :src="
                  player_info
                    ? getFlagURL(player_info.info.country)
                    : getFlagURL('xx')
                "
                class="flag"
              />
              <p>
                {{
                  player_info
                    ? countries[player_info.info.country.toUpperCase()]
                    : countries["XX"]
                }}
              </p>
            </div>
          </div>
          <i
            class="bannerbutton fa-solid fa-circle-chevron-up"
            @click="bannerclosed = !bannerclosed"
            :class="{ bannerclosed: bannerclosed }"
          ></i>
        </div>
        <div class="loadingwrapper" v-if="loading">
          <img class="loading" src="@/assets/icons/loading.svg" />
          <p>Hold tight, stats are loading...</p>
        </div>
        <div v-else>
          <div class="rankwrapper" :class="{ bannerclosed: bannerclosed }">
            <div class="left">
              <div class="rankings">
                <div class="ranking">
                  <p class="label">Global ranking</p>
                  <p class="rankno">
                    #{{
                      player_info.stats[selecteddata.mode + selecteddata.mod]
                        .rank
                    }}
                  </p>
                </div>
                <div class="ranking">
                  <p class="label">Country ranking</p>
                  <p class="rankno">
                    #{{
                      player_info.stats[selecteddata.mode + selecteddata.mod]
                        .country_rank
                    }}
                  </p>
                </div>
              </div>
              <div class="graph">
                <p style="z-index: 2">Graphs are not supported yet.</p>
              </div>
              <div class="stats">
                <div>
                  <div class="stat">
                    <p>pp</p>
                    <p>
                      {{
                        addDividingPoints(
                          player_info.stats[
                            selecteddata.mode + selecteddata.mod
                          ].pp
                        )
                      }}
                    </p>
                  </div>
                  <div class="stat">
                    <p>play time</p>
                    <p>
                      {{
                        formatSeconds(
                          player_info.stats[
                            selecteddata.mode + selecteddata.mod
                          ].playtime
                        )
                      }}
                    </p>
                  </div>
                </div>
                <div>
                  <div class="stat">
                    <p>SS+</p>
                    <p>
                      {{
                        player_info.stats[selecteddata.mode + selecteddata.mod]
                          .x_count
                      }}
                    </p>
                  </div>
                  <div class="stat">
                    <p>SS</p>
                    <p>
                      {{
                        player_info.stats[selecteddata.mode + selecteddata.mod]
                          .xh_count
                      }}
                    </p>
                  </div>
                  <div class="stat">
                    <p>S+</p>
                    <p>
                      {{
                        player_info.stats[selecteddata.mode + selecteddata.mod]
                          .s_count
                      }}
                    </p>
                  </div>
                  <div class="stat">
                    <p>S</p>
                    <p>
                      {{
                        player_info.stats[selecteddata.mode + selecteddata.mod]
                          .sh_count
                      }}
                    </p>
                  </div>
                  <div class="stat">
                    <p>A</p>
                    <p>
                      {{
                        player_info.stats[selecteddata.mode + selecteddata.mod]
                          .a_count
                      }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div class="vertdivider" />
            <div class="right">
              <div class="keys">
                <p>total score</p>
                <p>ranked score</p>
                <p>accuracy</p>
                <p>plays</p>
                <p>max combo</p>
              </div>
              <div class="values">
                <p>
                  {{
                    addDividingPoints(
                      player_info.stats[selecteddata.mode + selecteddata.mod]
                        .tscore
                    )
                  }}
                </p>
                <p>
                  {{
                    addDividingPoints(
                      player_info.stats[selecteddata.mode + selecteddata.mod]
                        .rscore
                    )
                  }}
                </p>
                <p>
                  {{
                    player_info.stats[
                      selecteddata.mode + selecteddata.mod
                    ].acc.toFixed(2)
                  }}%
                </p>
                <p>
                  {{
                    addDividingPoints(
                      player_info.stats[selecteddata.mode + selecteddata.mod]
                        .plays
                    )
                  }}
                </p>
                <p>
                  {{
                    addDividingPoints(
                      player_info.stats[selecteddata.mode + selecteddata.mod]
                        .max_combo
                    )
                  }}
                </p>
              </div>
            </div>
          </div>
          <div class="aboutme section">
            <div class="sectiontitle">
              <div>
                <i class="fa-solid fa-address-book"></i>
                <p>About me</p>
              </div>
              <i
                class="sectionbutton fa-solid fa-circle-chevron-up"
                :class="{ sectionclosed: this.sectionstatuses.aboutme }"
                @click="
                  this.sectionstatuses.aboutme = !this.sectionstatuses.aboutme
                "
              ></i>
            </div>
            <div
              class="content aboutmecont"
              :class="{ sectionclosed: this.sectionstatuses.aboutme }"
            >
              <p>About me not supported yet.</p>
            </div>
          </div>
        </div>
        <!-- Best plays -->
        <div class="recent section">
          <div class="sectiontitle">
            <div>
              <i class="fa-solid fa-trophy"></i>
              <p>Best plays</p>
            </div>
            <div>
              <i
                class="sectionbutton fa-solid fa-circle-chevron-up"
                :class="{ sectionclosed: sectionstatuses.best }"
                @click="this.sectionstatuses.best = !this.sectionstatuses.best"
              ></i>
            </div>
          </div>
          <div class="content" :class="{ sectionclosed: sectionstatuses.best }">
            <div
              class="loadingwrapper"
              v-if="!player_best"
              style="margin: 40px"
            >
              <img
                class="loading"
                src="@/assets/icons/loading.svg"
                style="margin: 0"
              />
            </div>
            <div
              class="loadingwrapper"
              v-if="player_best && player_best.length === 0"
              style="margin: 40px"
            >
              <img
                class="loading"
                src="@/assets/icons/sad.svg"
                style="animation: none"
              />
              <p>User doesn't have any best score.</p>
            </div>
            <div
              class="play"
              v-for="play in player_best"
              :key="play.id"
              :style="`background: linear-gradient(hsl(var(--main), 25%, 25%, 90%), hsl(var(--main), 25%, 25%, 90%)), url(https://assets.ppy.sh/beatmaps/${play.beatmap.set_id}/covers/card.jpg); background-repeat: no-repeat; background-size: cover;`"
            >
              <div>
                <div class="titlespace">
                  <div :class="'grade grade-' + play.grade">
                    <p>{{ play.grade.replace("X", "SS").replace("H", "") }}</p>
                  </div>
                  <div>
                    <div>
                      <p class="bmtitle">
                        {{ play.beatmap.artist }} | {{ play.beatmap.title }}
                      </p>
                      <p class="bmver">{{ play.beatmap.version }}</p>
                    </div>
                  </div>
                </div>
                <div class="bmstats">
                  <p class="bmppstat">{{ play.pp.toFixed(0) }}pp</p>
                  <p>
                    Accuracy: <b>{{ play.acc.toFixed(2) }}%</b>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Recent plays -->
        <div class="recent section">
          <div class="sectiontitle">
            <div>
              <i class="fa-solid fa-clock-rotate-left"></i>
              <p>Recent plays</p>
            </div>
            <div>
              <div
                v-if="
                  player_status &&
                  player_status.online &&
                  player_status.status.action === 2 &&
                  this.selecteddata.mod + this.selecteddata.mode ===
                    player_status.status.mode
                "
                class="liveind"
                style="margin-right: 10px"
              >
                LIVE
              </div>
              <i
                class="sectionbutton fa-solid fa-circle-chevron-up"
                :class="{ sectionclosed: sectionstatuses.recent }"
                @click="
                  this.sectionstatuses.recent = !this.sectionstatuses.recent
                "
              ></i>
            </div>
          </div>
          <div
            class="content"
            :class="{ sectionclosed: sectionstatuses.recent }"
          >
            <div
              class="play"
              v-if="
                player_status &&
                player_status.online &&
                player_status.status.action === 2 &&
                this.selecteddata.mod + this.selecteddata.mode ===
                  player_status.status.mode
              "
              :style="`background: linear-gradient(hsl(var(--main), 25%, 25%, 90%), hsl(var(--main), 25%, 25%, 90%)), url(https://assets.ppy.sh/beatmaps/${player_status.status.beatmap.set_id}/covers/card.jpg); background-repeat: no-repeat; background-size: cover;`"
            >
              <div>
                <div class="titlespace">
                  <div class="grade">
                    <p>?</p>
                  </div>
                  <div>
                    <div>
                      <p class="bmtitle">
                        {{ player_status.status.beatmap.artist }} |
                        {{ player_status.status.beatmap.title }}
                      </p>
                      <p class="bmver">
                        {{ player_status.status.beatmap.version }}
                      </p>
                    </div>
                  </div>
                </div>
                <div class="bmstats">
                  <p class="bmppstat">LIVE</p>
                  <p>Accuracy: <b>?.??%</b></p>
                </div>
              </div>
            </div>
            <div
              class="loadingwrapper"
              v-if="!player_recent"
              style="margin: 40px"
            >
              <img
                class="loading"
                src="@/assets/icons/loading.svg"
                style="margin: 0"
              />
            </div>
            <div
              class="loadingwrapper"
              v-if="player_recent && player_recent.length === 0"
              style="margin: 40px"
            >
              <img
                class="loading"
                src="@/assets/icons/sad.svg"
                style="animation: none"
              />
              <p>User doesn't have any recent score.</p>
            </div>

            <div
              class="play"
              v-for="play in player_recent"
              :key="play.id"
              :style="`background: linear-gradient(hsl(var(--main), 25%, 25%, 90%), hsl(var(--main), 25%, 25%, 90%)), url(https://assets.ppy.sh/beatmaps/${play.beatmap.set_id}/covers/card.jpg); background-repeat: no-repeat; background-size: cover;`"
            >
              <div>
                <div class="titlespace">
                  <div :class="'grade grade-' + play.grade">
                    <p>{{ play.grade.replace("X", "SS").replace("H", "") }}</p>
                  </div>
                  <div>
                    <div>
                      <p class="bmtitle">
                        {{ play.beatmap.artist }} | {{ play.beatmap.title }}
                      </p>
                      <p class="bmver">{{ play.beatmap.version }}</p>
                    </div>
                  </div>
                </div>
                <div class="bmstats">
                  <p class="bmppstat">{{ play.pp.toFixed(0) }}pp</p>
                  <p>
                    Accuracy: <b>{{ play.acc.toFixed(2) }}%</b>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const { countries } = countriesList();
const config = useRuntimeConfig();
</script>

<script>
// load stlyes
export default {
  data() {
    return {
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
      grades: {
        F: "F",
        D: "D",
        C: "C",
        B: "B",
        A: "A",
        SH: "S",
        S: "S+",
        XH: "X",
        X: "X+",
      },
      selecteddata: {
        mode: 0,
        mod: 0,
        sorting: "pp",
      },
      sectionstatuses: {
        aboutme: true,
        recent: true,
        best: false,
      },
      loading: true,
      player_info: null,
      player_status: null,
      player_best: null,
      bannerclosed: false,
    };
  },
  mounted() {
    this.getPlayerData();
    this.getPlayerStatus();
    setInterval(() => {
      this.getPlayerStatus();
    }, 5000);
    this.getPlayerRecent();
    this.getPlayerBest();
  },
  methods: {
    // USER SELECTION FUNCTIONS
    getFlagURL(country) {
      let url = "https://osu.ppy.sh/assets/images/flags/";
      for (let idx = 0; idx < country.length; idx++) {
        let char = country[idx].toUpperCase();
        url += (char.charCodeAt() + 127397).toString(16);
        url += idx !== country.length - 1 ? "-" : ".svg";
      }
      return url;
    },
    selectmode(mode) {
      this.selecteddata.mode = this.modes[mode];
      this.player_recent = null;
      this.getPlayerRecent();
      this.player_best = null;
      this.getPlayerBest();
    },
    selectmod(mod) {
      this.selecteddata.mod = this.mods[mod];
      this.player_recent = null;
      this.getPlayerRecent();
      this.player_best = null;
      this.getPlayerBest();
    },
    // FORMATTING FUNCTIONSS
    formatSeconds(seconds) {
      const days = Math.floor(seconds / (24 * 60 * 60));
      const hours = Math.floor((seconds % (24 * 60 * 60)) / (60 * 60));
      const minutes = Math.floor((seconds % (60 * 60)) / 60);
      return `${days}d ${hours}h ${minutes}m`;
    },
    addDividingPoints(number) {
      var numberString = number.toString();
      var reversedString = numberString.split("").reverse().join("");
      var resultString = reversedString.replace(/(\d{3})/g, "$1.");
      resultString = resultString.split("").reverse().join("");
      if (resultString.charAt(0) === ".") {
        resultString = resultString.substr(1);
      }
      return resultString;
    },
    // DATA FUNCTIONS
    async getPlayerData() {
      const data = await $fetch(
        `${this.$config.public.api_url}get_player_info?id=${this.$route.params.id}&scope=all`
      );
      this.player_info = data.player;
      this.loading = false;
    },
    async getPlayerStatus() {
      const data = await $fetch(
        `${this.$config.public.api_url}get_player_status?id=${this.$route.params.id}`
      );
      this.player_status = data.player_status;
    },
    async getPlayerRecent() {
      const data = await $fetch(
        `${this.$config.public.api_url}get_player_scores?id=${
          this.$route.params.id
        }&mode=${
          this.selecteddata.mod + this.selecteddata.mode
        }&scope=recent&limit=5`
      );
      this.player_recent = data.scores;
    },
    async getPlayerBest() {
      const data = await $fetch(
        `${this.$config.public.api_url}get_player_scores?id=${
          this.$route.params.id
        }&mode=${
          this.selecteddata.mod + this.selecteddata.mode
        }&scope=best&limit=5`
      );
      this.player_best = data.scores;
    },
  },
};
</script>

<style lang="css" scoped>
@import url("@/assets/styles/pages/profile.css");
</style>
