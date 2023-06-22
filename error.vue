<template>
  <div>
    <p>{{ error.message }}</p>
  </div>
</template>

<script setup>
defineProps(["error"]);
</script>