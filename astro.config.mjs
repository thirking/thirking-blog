import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import svelte from "@astrojs/svelte";
import tailwind from "@astrojs/tailwind";

import node from "@astrojs/node";

// https://astro.build/config
export default defineConfig({
  site: 'https://wwww.thirking.top',
  integrations: [mdx(), sitemap(), svelte(), tailwind()],
  output: "server",
  adapter: node({
    mode: "standalone"
  })
});