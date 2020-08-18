<template>
  <div
    class="post-card content-box"
    :class="{ 'post-card--has-poster': contribution.poster }"
  >
    <div class="post-card__header">
      <g-image
        alt="Cover image"
        v-if="contribution.cover_image"
        class="post-card__image"
        :src="contribution.cover_image"
      />
    </div>
    <div class="post-card__content">
      <h2 class="post-card__title" v-html="contribution.title" />
      <p class="post-card__description" v-html="contribution.description" />
      <div class="post__content" v-html="contribution.content" />

      <PostMeta class="post-card__meta" :post="contribution" />
    </div>
  </div>
</template>

<script>
import PostMeta from "~/components/PostMeta";

export default {
  components: {
    PostMeta,
  },
  props: ["contribution"],
};
</script>

<style lang="scss">
.post-card {
  margin: 0 1em var(--space);

  position: relative;

  &__header {
    margin-left: calc(var(--space) * -1);
    margin-right: calc(var(--space) * -1);
    margin-bottom: calc(var(--space) / 2);
    margin-top: calc(var(--space) * -1);
    overflow: hidden;
    border-radius: var(--radius) var(--radius) 0 0;

    &:empty {
      display: none;
    }
  }

  &__image {
    min-width: 100%;
    transition: filter 0.6s linear;
  }

  &__title {
    margin-top: 0;
  }

  &__tags {
    z-index: 1;
    position: relative;
  }

  &__link {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
    overflow: hidden;
    text-indent: -9999px;
    z-index: 0;
  }

  // &__description {
  //   overflow: hidden;
  //   display: -webkit-box;
  //   -webkit-line-clamp: 3;
  //   -webkit-box-orient: vertical;
  // }
}
</style>
