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
          <div class="selector sdisabled">
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
        <div class="banner"></div>
        <div class="userdata">
          <img
            :src="
              player_info
                ? `https://a.${config.public.base_url}${player_info.info.id}`
                : `https://a.${config.public.base_url}`
            "
            class="pfp"
          />

          <div class="text">
            <p class="usernametext">{{ player_info ? player_info.info.name: "..." }}</p>
            <div class="country">
              <img :src="player_info ? getFlagURL(player_info.info.country) : getFlagURL('xx')" class="flag" />
              <p>{{ player_info ? countries[player_info.info.country.toUpperCase()] : countries['XX'] }}</p>
            </div>
             
          </div> 
        </div>
        <!-- {{ player_info }} -->
        <div class="loadingwrapper" v-if="loading">
          <img class="loading" src="@/assets/icons/loading.svg" />
          <p>Hold tight, stats are loading...</p>
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
      selecteddata: {
        mode: 0,
        mod: 0,
        sorting: "pp",
      },
      loading: true,
      player_info: null,
    };
  },
  mounted() {
    this.getPlayerData();
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
    },
    selectmod(mod) {
      this.selecteddata.mod = this.mods[mod];
    },
    // DATA FUNCTIONS
    async getPlayerData() {
      const data = await $fetch(
        `${this.$config.public.api_url}get_player_info?id=${this.$route.params.id}&scope=all`
      );
      this.player_info = data.player;
    },
    async getPlayerStatus() {
      await axios
        .get(
          `${this.$config.public.api_url}get_player_status?id=${this.player_id}`
        )
        .then((res) => {
          console.log(res);
          this.player_status = res.data.player_status;
        });
    },
  },
};
</script>

<style lang="css" scoped>
@import url("@/assets/styles/pages/profile.css");
</style>