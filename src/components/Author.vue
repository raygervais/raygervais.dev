<template>
  <div class="author">
    <g-image
      alt="Author image"
      class="author__image"
      src="~/assets/images/author.jpg"
      width="180"
      height="180"
      blur="5"
    />

    <h1 v-if="showTitle" class="author__site-title">
      {{ $static.metadata.siteName }}
    </h1>

    <p class="author__intro">{{ $static.metadata.siteDescription }}</p>

    <div class="navigation_bar">
      <p class="author__links">
        <!-- <g-link to="/about">About</g-link> -->
        <g-link to="/">Articles</g-link>
        <g-link to="/uses">Uses</g-link>
        <g-link to="/uses">Open Source</g-link>

        <a href="//twitter.com/_raygervais">Twitter</a>
        <a href="//github.com/raygervais">GitHub</a>
      </p>
    </div>
  </div>
</template>

<static-query>
query {
  metadata {
    siteName
	siteDescription
  }
}
</static-query>

<script>
export default {
  props: ["showTitle"],
};
</script>

<style lang="scss">
.author {
  margin: 0 auto;
  max-width: 80%;
  text-align: center;
  padding: calc(var(--space) / 2) 0;

  &__image {
    border-radius: 100%;
    width: 90px;
    height: 90px;
    margin-bottom: 1em;
  }

  &__intro {
    opacity: 0.8;
  }

  &__site-title {
    font-size: 1.5em;
  }

  &__links {
    padding: 1rem;

    a {
      transition: all linear 250ms;
      text-decoration: none;
      border-bottom: none;
      border-radius: 5px;

      margin: 0 0.5em;

      padding: 1rem;

      &:hover {
        color: var(--bg-color);
        background: var(--title-color);
        padding: 1rem;
      }
    }
  }
}

@media (max-width: 768px) {
  .author__links a {
    display: block;

    &:last-child {
      padding-bottom: 0;
    }
  }
}
</style>
