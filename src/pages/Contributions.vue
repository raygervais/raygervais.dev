<template>
  <Layout :show-logo="false">
    <!-- Author intro -->
    <Author :show-title="true" />

    <div class="posts flex-container">
      <ContributionCard
        class="flex-item"
        v-for="edge in $page.allContribution.edges"
        :key="edge.node.id"
        :contribution="edge.node"
      />
    </div>
  </Layout>
</template>

<page-query>
query {
  allContribution (sortBy: "title", order: ASC) {
    totalCount
    edges {
      node {
        id
        title
        link
        description
        cover_image
        content
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
import ContributionCard from "~/components/ContributionCard.vue";

export default {
  components: {
    Author,
    ContributionCard,
  },
  data: function() {
    return { events: [], repos: [] };
  },
  metaInfo() {
    return {
      title: "Uses",
      meta: [
        {
          key: "og:title",
          name: "og:title",
          content: "raygervais.dev - uses",
        },
        {
          key: "twitter:title",
          name: "twitter:title",
          content: "raygervais.dev - uses",
        },
      ],
    };
  },
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

  margin: 0 1em var(--space);
  width: 100%;
  position: relative;

  & h2:first-of-type {
    margin-top: 0;
  }

  @media (min-width: 1024px) {
    min-height: 60rem;
  }
}

.header {
  width: calc(100% + var(--space) * 2);
  margin-left: calc(var(--space) * -1);
  margin-top: calc(var(--space) * -1);
  margin-bottom: calc(var(--space) / 2);
  overflow: hidden;
  border-radius: var(--radius) var(--radius) 0 0;

  img {
    width: 100%;
  }
}

.post-title {
  padding: calc(var(--space) / 2) 0 calc(var(--space) / 2);
  text-align: center;
}

.title-box {
  text-align: center;
}
</style>
