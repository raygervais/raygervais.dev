<template>
  <Layout :show-logo="false">
    <!-- Author intro -->
    <Author :show-title="true" />

    <br />

    <div class="flex-container">
      <div class="content-box title-box">
        <h1>Stuff I Use for Software Development</h1>

        <hr />
        <p>
          This article was inspired by the ever-persistent question "What do
          they use?", which
          <a
            href="https://twitter/wesbos"
            target="_blank"
            rel="nofollow noopener noreferrer"
            >Wes Bos</a
          >
          decided to answer in the
          <a
            href="https://uses.tech/"
            target="_blank"
            rel="nofollow noopener noreferrer"
            >/uses.tech</a
          >
          project.
        </p>
      </div>
    </div>

    <br />

    <!-- List posts -->
    <div class="flex-container">
      <div class="flex-item content-box">
        <h2>Professional Occupation: Cloud Engineer</h2>
        <table>
          <thead>
            <th></th>
            <th></th>
          </thead>
          <tbody>
            <tr>
              <td>Operating Systems</td>
              <td>Linux, Windows, MacOS</td>
            </tr>
            <tr>
              <td>Public Cloud</td>
              <td>Microsoft Azure, Google Cloud Platform</td>
            </tr>
            <tr>
              <td>Container</td>
              <td>Docker</td>
            </tr>
            <tr>
              <td>CI/CD</td>
              <td>Jenkins, Concourse</td>
            </tr>
            <tr>
              <td>Infrastructure as Code</td>
              <td>Puppet, Terraform, Packer, Chef</td>
            </tr>
            <tr>
              <td>Scripting</td>
              <td>Ruby, Python, Groovy, BASH</td>
            </tr>
            <tr>
              <td>CLI, Tooling and Misc Languages</td>
              <td>Golang, Java, .NET</td>
            </tr>
          </tbody>
        </table>

        <h2>Hobbies / Interests</h2>
        <table>
          <thead>
            <th></th>
            <th></th>
          </thead>
          <tbody>
            <tr>
              <td>Application Development</td>
              <td>iOS</td>
            </tr>
            <tr>
              <td>Application Development</td>
              <td>Android</td>
            </tr>
            <tr>
              <td>Application Development</td>
              <td>Web</td>
            </tr>
            <tr>
              <td>Open Source</td>
            </tr>
          </tbody>
        </table>
        <h2>Software</h2>
        <table>
          <thead>
            <th></th>
            <th></th>
          </thead>
          <tbody>
            <tr>
              <td>Editor</td>
              <td>Vim, Visual Studio Code</td>
            </tr>
            <tr>
              <td>Terminal</td>
              <td>Alacritty</td>
            </tr>
            <tr>
              <td>Shell</td>
              <td>BASH, fish, zsh</td>
            </tr>
            <tr>
              <td>Font Families</td>
              <td>Fira Mono Code, Victor Mono Code</td>
            </tr>
            <tr>
              <td>Color Scheme</td>
              <td>Atom Dark, Nord, Xcode Dark(2019)</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="flex-item content-box">
        <h2>Hardware</h2>
        <table>
          <thead>
            <tr>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>Operating System</strong></td>
              <td>
                Windows 10 <em>with many Linux Docker Containers</em> / Pop!OS
              </td>
            </tr>
            <tr>
              <td><strong>CPU</strong></td>
              <td>Intel - Core i7-8700K 3.7GHz 6-Core Processor</td>
            </tr>
            <tr>
              <td><strong>CPU Cooler</strong></td>
              <td>
                Cooler Master - Hyper 212 EVO 82.9 CFM Sleeve Bearing CPU Cooler
              </td>
            </tr>
            <tr>
              <td><strong>Motherboard</strong></td>
              <td>MSI - Z370 GAMING PLUS ATX LGA1151 Motherboard</td>
            </tr>
            <tr>
              <td><strong>Memory</strong></td>
              <td>
                G.Skill - Ripjaws V Series 16GB (2 x 8GB) DDR4-3000 Memory
              </td>
            </tr>
            <tr>
              <td><strong>Storage</strong></td>
              <td>Samsung - 850 EVO 500GB M.2-2280 Solid State Drive</td>
            </tr>
            <tr>
              <td><strong>Storage</strong></td>
              <td>
                Western Digital - Caviar Blue 1TB 3.5" 7200RPM Internal Hard
                Drive
              </td>
            </tr>
            <tr>
              <td><strong>Video Card</strong></td>
              <td>Gigabyte - GeForce GTX 1070 8GB G1 Gaming Video Card</td>
            </tr>
            <tr>
              <td><strong>Computer Case</strong></td>
              <td>
                Phanteks - Enthoo Pro M Tempered Glass (Black) ATX Mid Tower
                Case
              </td>
            </tr>
            <tr>
              <td><strong>Power Supply</strong></td>
              <td>
                EVGA - SuperNOVA G2 750W 80+ Gold Certified Fully-Modular ATX
                Power Supply
              </td>
            </tr>
            <tr>
              <td><strong>Sound Card</strong></td>
              <td>Asus - Xonar DGX 24-bit 96 KHz Sound Card</td>
            </tr>
            <tr>
              <td><strong>Sound Card</strong></td>
              <td>M-Audio Mbox II Mini</td>
            </tr>
            <tr>
              <td><strong>Wireless Network Adapter</strong></td>
              <td>
                Gigabyte - GC-WB867D-I PCI-Express x1 802.11a/b/g/n/ac Wi-Fi
                Adapter
              </td>
            </tr>
            <tr>
              <td><strong>Monitor</strong></td>
              <td>Dual AOC 4K IPS Monitor</td>
            </tr>
            <tr>
              <td><strong>Mouse</strong></td>
              <td>Logitech MX Master 2S</td>
            </tr>
            <tr>
              <td><strong>Keyboard</strong></td>
              <td>Anne Pro 2 with Kailh Box Whites</td>
            </tr>
            <tr>
              <td><strong>Speakers</strong></td>
              <td>
                Personus Eris 3.5
              </td>
            </tr>
            <tr>
              <td><strong>Microphone</strong></td>
              <td>Audio-Technica AT2020</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="flex-container"></div>
  </Layout>
</template>

<script>
import Author from "~/components/Author.vue";

export default {
  components: {
    Author,
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
    min-height: 85rem;
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
  align-items: flex-start;
  flex-grow: 1;
  flex-basis: inherit;

  @media (min-width: 1024px) {
    min-width: calc(var(--content-width) * 2.05);
  }
}
</style>
