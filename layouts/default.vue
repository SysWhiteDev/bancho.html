<template>
  <div class="nav">
    <div>
      <div class="left">
        <div class="branding" @click="router.push('/')">
          <img src="/branding/minlogo.png" alt="" v-if="config.public.img" />
          <p>{{ config.public.name }}</p>
        </div>
        <div class="links">
          <NuxtLink :to="{ name: 'leaderboard' }"
            >Leaderboards<span></span>
          </NuxtLink>
        </div>
      </div>
      <div class="right"></div>
    </div>
  </div>
  <div>
    <slot />
  </div>
</template>

<script setup>
const router = useRouter();
const config = useRuntimeConfig();

// set title
useHeadSafe({
  title: config.public.name
})
</script>
<style scoped>
@import url("@/assets/styles/navigation/navbar.css");
@import url("@/assets/styles/navigation/footer.css");
</style>