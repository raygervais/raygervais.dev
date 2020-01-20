<template>
  <div>
    <h2>Tags</h2>
    <div class="post-tags">
      <br />
      <g-link
        class="post-tags__link"
        v-for="tag in post.tags"
        :key="tag.id"
        :to="tag.path"
      >
        {{ tag.title }}
      </g-link>
    </div>
  </div>
</template>

<script>
export default {
  props: ["post"]
};
</script>

<style lang="scss">
.post-tags {
  margin: 1em 0 0;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  flex-direction: row;
  flex-wrap: nowrap;
  flex: 1;

  &__link {
    margin-right: 0.7em;
    font-size: 0.75em;
    color: currentColor;
    text-decoration: none;
    background-color: var(--bg-color);
    color: currentColor !important; //Todo: remove important;
    padding: 0.5em;
    border-radius: var(--radius);
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    text-align: center;
    align-items: center;
    justify-content: center;
    // min-width: 100px;
    flex-grow: 1;
    width: auto;
    height: 60px;
  }
}

@media only screen and (max-width: 600px) {
  .post-tags {
    flex-direction: column;
    width: 100%;

	&__link {
		width: 100%;
		height: auto;
		margin-bottom: 1rem;
	}
  }
}
</style>
