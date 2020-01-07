// Import main css
import "~/assets/style/index.scss";
import "prism-themes/themes/prism-atom-dark.css";

// Import default layout so we don't need to import it to every page
import DefaultLayout from "~/layouts/Default.vue";

import VueGtag from "vue-gtag";

// The Client API can be used here. Learn more: gridsome.org/docs/client-api
export default function(Vue, { router, head, isClient }) {
  Vue.use(VueGtag, {
    config: {
      id: process.env.Google_Analytics_ID
    }
  });

  // Set default layout as a global component
  Vue.component("Layout", DefaultLayout);
}
