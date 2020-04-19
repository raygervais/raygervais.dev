<template>
  <div
    class="post-card content-box"
    :class="{ 'post-card--has-poster': post.poster }"
  >
    <div class="post-card__header">
      <g-image
        alt="Cover image"
        v-if="post.cover_image"
        class="post-card__image"
        :src="post.cover_image"
      />
    </div>
    <div class="post-card__content">
      <h2 class="post-card__title" v-html="post.title" />
      <p class="post-card__description" v-html="post.description" />

      <PostMeta class="post-card__meta" :post="post" />
      <PostTags class="post-card__tags" :post="post" />

      <g-link class="post-card__link" :to="post.path">Link</g-link>
    </div>
  </div>
</template>

<script>
import PostMeta from "~/components/PostMeta";
import PostTags from "~/components/PostTags";

export default {
  components: {
    PostMeta,
    PostTags
  },
  props: ["post"]
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

  &:hover {
    transition: all linear 250ms;
    transform: translateY(-5px);
    // box-shadow: -1px 9px 20px var(--border-color);
    // -webkit-box-shadow: -1px 9px 20px var(--border-color);
    // -moz-box-shadow: -1px 9px 20px var(--border-color);
    // box-shadow: -1px 9px 20px var(--border-color);

    // border: solid 1px var(--border-color);

    .post-card__image {
      -webkit-filter: grayscale(1);
      filter: grayscale(1);
      // filter: blur(2px);
    }
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
