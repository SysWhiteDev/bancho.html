export default defineNuxtConfig({
  css: ["@/assets/styles/main.css"],
  hooks: {
    "pages:extend"(pages) {
      pages.push({
        name: "leaderboard",
        path: "/lb/:mode?/:sorting?/:mod?/:page?",
        file: "~/pages/LeaderboardView.vue",
      });
      pages.push({
        name: "userpage",
        path: "/u/:id",
        file: "~/pages/UserView.vue",
      });
    },
  },
  runtimeConfig: {
    public: {
      name: "bancho.html",
      img: true,
      baseUrl: undefined,
      apiUrl: undefined
    },
  },
  app: {
    head: {
      link: [
        {
          rel: "stylesheet",
          href: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css",
        },
      ],
    },
  },
  modules: ["@pinia/nuxt"],
});
