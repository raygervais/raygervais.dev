// This is where project configuration and plugin options are located.
// Learn more: https://gridsome.org/docs/config

// Changes here requires a server restart.
// To restart press CTRL + C in terminal and run `gridsome develop`

module.exports = {
  siteName: "Ray Gervais",
  siteDescription:
    "Topics of Programming, Techno-babble, Music, and Life through the eyes of a Canadian Software Developer.",

  templates: {
    Post: "/article/:title",
    Tag: "/tag/:id"
  },

  plugins: [
    {
      // Create posts from markdown files
      use: "@gridsome/source-filesystem",
      options: {
        typeName: "Post",
        path: "content/posts/**/*.md",
        refs: {
          // Creates a GraphQL collection from 'tags' in front-matter and adds a reference.
          tags: {
            typeName: "Tag",
            create: true
          }
        }
      }
    },
    {
      use: "gridsome-plugin-rss",
      options: {
        contentTypeName: "Post",
        feedOptions: {
          title: "Ray Gervais",
          feed_url: "https://raygervais.dev/rss.xml",
          site_url: "https://raygervais.dev"
        },
        feedItemOptions: node => ({
          title: node.title,
          description: node.description,
          url: "https://raygervais.dev" + node.path,
          author: node.author
        }),
        output: {
          dir: "./static",
          name: "rss.xml"
        }
      }
    }

    // {
    //   use: "@gridsome/plugin-google-analytics",
    //   options: {
    //     id: process.env.Google_Analytics_ID
    //   }
    // }
  ],

  transformers: {
    //Add markdown support to all file-system sources
    remark: {
      externalLinksTarget: "_blank",
      externalLinksRel: ["nofollow", "noopener", "noreferrer"],
      anchorClassName: "icon icon-link",
      plugins: ["@gridsome/remark-prismjs"]
    }
  }
};
