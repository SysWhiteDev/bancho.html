<template>
  <div class="alert" v-if="data.active === true">
    <div class="icon">
      <i class="fa-solid fa-circle-info"></i>
    </div>
    <div class="content">
      <p class="title">Information</p>
      <p class="subtitle">Website in showcase mode!</p>
    </div>
  </div>
</template>

<script setup>
const data = ref({
    active: false
});
</script>