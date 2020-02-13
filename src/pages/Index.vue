<template>
  <Layout :show-logo="false">
    <!-- Author intro -->
    <Author :show-title="true" />

    <!-- List posts -->
    <div class="posts flex-container">
      <PostCard
        class="flex-item"
        v-for="edge in $page.posts.edges"
        :key="edge.node.id"
        :post="edge.node"
      />
    </div>

    <div class="flex-container">
      <Pager :info="$page.posts.pageInfo" :linkClass="{ pageNum: true }" />
    </div>
    <br />
  </Layout>
</template>

<page-query>
query ($page: Int) {
  posts: allPost(perPage: 20, page: $page, filter: { published: { eq: true }}) @paginate {
    totalCount
    pageInfo {
      totalPages
      currentPage
      isFirst
      isLast
    }
    edges {
      node {
        id
        title
        date (format: "D. MMMM YYYY")
        timeToRead
        description
        cover_image (width: 770, height: 380, blur: 10)
        path
        tags {
          id
          title
          path
        }
      }
    }
  }
}
</page-query>

<script>
import Author from "~/components/Author.vue";
import PostCard from "~/components/PostCard.vue";
import { Pager } from "gridsome";

export default {
  components: {
    Author,
    PostCard,
    Pager
  },
  metaInfo() {
    return {
      title: "Hello, world!",
      meta: [
        {
          key: "og:title",
          name: "og:title",
          content: "raygervais.dev - posts"
        },
        {
          key: "twitter:title",
          name: "twitter:title",
          content: "raygervais.dev - posts"
        }
      ]
    };
  }
};
</script>

<style lang="scss" scoped>
.flex-container {
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
  -webkit-flex-direction: row;
  -ms-flex-direction: row;
  flex-direction: row;
  -webkit-flex-wrap: wrap;
  -ms-flex-wrap: wrap;
  flex-wrap: wrap;
  -webkit-justify-content: center;
  -ms-flex-pack: center;
  justify-content: center;
  -webkit-align-content: flex-start;
  -ms-flex-line-pack: start;
  align-content: flex-start;
  -webkit-align-items: flex-start;
  -ms-flex-align: start;
  align-items: flex-start;
}

.flex-item {
  -webkit-order: 0;
  -ms-flex-order: 0;
  order: 0;
  -webkit-flex: 0 1 auto;
  -ms-flex: 0 1 auto;
  flex: 0 1 auto;
  -webkit-align-self: auto;
  -ms-flex-item-align: auto;
  align-self: auto;

  @media (min-width: 1024px) {
    min-height: 60rem;
  }
}

.pageNum {
  padding: 1rem var(--space);
  background: var(--bg-content-color);
  border-radius: var(--radius);
  color: var(--link-color);

  -webkit-order: 0;
  -ms-flex-order: 0;
  order: 0;
  -webkit-flex: 0 1 auto;
  -ms-flex: 0 1 auto;
  flex: 0 1 auto;
  -webkit-align-self: auto;
  -ms-flex-item-align: auto;
  align-self: auto;
  margin-right: 0.7em;
}

.active--exact {
  background: var(--link-color);
  color: var(--bg-content-color);
}
</style>
