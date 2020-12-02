---
title: "Getting SSL Setup on WordPress and Static Sites"
date: 2018-10-29
draft: false
Cover: "images/DSC5524.jpg"
tags: ["Web Development", "SSL", "Experiments", "Lessons"]
description: "At the start of 2018, Google made a major push to rank and direct users to HTTPS websites in effort to be more web-safe; a fantastic way to push for such security onto as many websites as possible, aimed at those who care about there search rankings, privacy, and consumers. This also meant that at the time of writing this article, I was already at least eight months behind on this -and GoDaddy was the persistent parent who always reminded me of the HTTPS push, alongside their one-click-install SSL certificates sold on top of their hosting packages. In 2018, who wants to invest hundreds for SSL just to spend as much (if not more) in the next?"
---

_Hosted by GoDaddy, Leveraging Let’s Encrypt and ZeroSSL_

At the start of 2018, Google made a major push to rank and direct users to HTTPS websites in effort to be more web-safe; a fantastic way to push for such security onto as many websites as possible, aimed at those who care about there search rankings, privacy, and consumers. This also meant that at the time of writing this article, I was already at least eight months behind on this -and GoDaddy was the persistent parent who always reminded me of the HTTPS push, alongside their one-click-install SSL certificates sold on top of their hosting packages. In 2018, who wants to invest hundreds for SSL just to spend as much (if not more) in the next?

I decided to try out Let’s Encrypt on both my WordPress blog site, and a static website which serves purely HTML files (for the manner of this test). Before we go about this tutorial, I figured that we should establish what defined a secure site and explain the motive of Let’s Encrypt, which I’ll be utilizing alongside the ZeroSSL tool. Though I can see where self-signed certificates are useful for high-end corporations and platforms, for your average website or application, Let’s Encrypt should be perfectly suited, and here is why I gather such opinion.

## What is HTTPS / SSL?

How-To-Guide describes the differences between HTTP and HTTPS as the following:

> HTTPS is much more secure than HTTP. When you connect to an HTTPS-secured server—secure sites like your bank’s will automatically redirect you to HTTPS—your web browser checks the website’s security certificate and verifies it was issued by a legitimate certificate authority. This helps you ensure that, if you see “https://bank.com” in your web browser’s address bar, you’re actually connected to your bank’s real website. The company that issued the security certificate vouches for them.
>
> When you send sensitive information over an HTTPS connection, no one can eavesdrop on it in transit. HTTPS is what makes secure online banking and shopping possible.

> It also provides additional privacy for normal web browsing, too. For example, Google’s search engine now defaults to HTTPS connections. This means that people can’t see what you’re searching for on Google.com.

If it wasn’t obvious because of the above, the following websites and applications should be avoided if they don’t support HTTPS as of now:

- Shopping portals
- Banking applications
- Social media platforms
- Applications which consume sensitive data

If it’s any incentive, Apple’s application programming manifest defaults to HTTPS requests, and attempts to make a non-secure API call must also override this default; often failing the application in the app store approval process if not corrected.

## What’s Let’s Encrypt?

**Found on [Let’s Encrypt](https://letsencrypt.org/)’s website:**

> The objective of Let’s Encrypt and the [ACME protocol](https://ietf-wg-acme.github.io/acme/) is to make it possible to set up an HTTPS server and have it automatically obtain a browser-trusted certificate, without any human intervention. This is accomplished by running a certificate management agent on the web server.

## Working with GoDaddy & SSL Certificates

If you are using GoDaddy (as I am in this tutorial), one crucial item you need is access to your account’s full **cPanel** interface. The web hosting LAMP stack should come with the platform access by default, as opposed to the WordPress hosting tier which grants no such means. Without, you may be stuck having to purchase a Certificate from GoDaddy who will kindly also install it for you onto your website. But, what does that cost look like? Because this tutorial is revolving around a blog site, and a static website, I’m not going to tread anywhere beyond the standard consumer offerings; ones which hobbyist and developers would utilize.

![](https://lh6.googleusercontent.com/wgOzH_vay5xF536IvzCT0Yh9FBJzBL2WtCENKbGtHp7CLlj6R0-PZAniPL-sCCvpVE3OjuVotejG_FZNdUrPvTJC4OM2t4nTdG2mbDwMbwEs90PU3SIIZcSdmNX13sxE0R_ELjgQ)

According to 10/15/2018, the GoDaddy offerings are the following for SSL Certificates and installation:

**Tier**

**# Sites Covered**

**Cost / Year**

One Website

One

$70.00

Multiple Websites

Up to Five

$154.00

All Subdomains of a Single Website

One, all Subdomains

$311.50

There is one benefit that I see coming from GoDaddy’s offerings (which, if I may add is freely available on many other providers listed below), is that it’s a year-long valid SSL certificate, which greatly outlasts Let’s Encrypt standard 90 days. Not knocking the company, simply the product’s cost PER website.

## ZeroSSL

[ZeroSSL](http://zerossl.com/) is a fantastic interactive tool which runs on top of Let's Encrypt, allowing for even easier SSL certificate generation and management. I find it utterly helpful with managing and describing the steps required to obtain a valid LE certificate for your various domains.

Here is a step by step which follows the video titled ‘Install Godaddy SSL Certificate for Free - LetsEncrypt cPanel installation’ found in the ZeroSSL link below. **I highly recommend following the video, since visually it makes a lot more sense compared to the steps below.**

https://www.youtube.com/watch?time_continue=20&v=GPcznB74GPs

1. Log in to cPanel.
2. In a seperate tab, open zerossl.com.
3. Click on ‘start’ button under ‘Free SSL Certificate Wizard’.
4. Enter in your domains, you will be prompted to also include a www- prefixed variant.
5. Select both checkboxes, click next.
6. Select next again, which will generate account key.
7. Download both the cert and private key for safe keeping.
8. Hit next, where you are asked to verify you own the domain:
   1. Download the two files provided
   2. In your cPanel, open the file manager and navigate to the domain of choice.
   3. Create a folder in the domain titled .well-known
   4. Create a folder inside called acme-challenge, upload the two verification files to this directory.
   5. Once uploaded, click on the files in the ZeroSSL listings to verify. If you are able to see the keys coming from your domain, the next step will verify and confirm ownership successfully.
   6. Hit next to confirm
9. Download the certificates generated in the last step, or copy them to your clipboard.
10. In cPanel, navigate to Security->SSL->Manage SSL Sites
    1. Select your domain
    2. Add the first key (the certificate, which when copied contains two keys separated by the expected `---`. Take the second key and put that into the last field (Certificate Authority Bundle).
    3. Copy the private key from ZeroSSL and put into the middle corresponding field.
11. You should see green check marks which verify that the values provided are valid, and if so, click the ‘Install Certificate’ button. This will install the SSL certificate for that domain.
12. Test by going to HTTPS://<YOUR_DOMAIN>, if you get a half-lock under HTTPS, see the topic below which describes what has to be done for a static site or WordPress site to be truly HTTPS compliant.

If the above worked, then you have a valid SSL certificate installed on your domain which will last 90 days! But, this is currently only accessible when a user types in ‘HTTPS’, so how do we default it? Adding the following lines to the bottom of the domain’s `.htaccess` file will reroute all traffic to HTTPS gateways!

RewriteEngine On

RewriteCond %{HTTPS} off

RewriteRule ^(.\*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

### Static Websites

![](./images/SSL-Playground.png)

The following need to be updated on your Static site (which should also apply to the vast majority of server-side rendered websites):

- All links and references, moving HTTP-> HTTPS
- All images, external content coming from CDN(s) need to be updated to use HTTPS
- All JavaScript libraries and files need to be referenced using HTTPS too!

From there, you should be good to go! I tested the above using my latest little project ‘The Developer’s Playground’ which can be found here: [https://the-developers-playground.ca](https://the-developers-playground.ca)!

### WordPress

![](./images/SSL-RG.png)

Woah, blogception!

For WordPress, I found the Really Simple SSL ([https://wordpress.org/plugins/really-simple-ssl/](https://wordpress.org/plugins/really-simple-ssl/)) plugin mitigated many of the common issues that would arise from a previously HTTP configured installation. It will correct image references, link references, and common semantics which makes browsers such as Firefox or Chrome complain about the site’s integrity. It really is, Really Simple SSL!

If you are using Google Analytics, you’ll have to update the domain’s via unlinking and reconnecting (depending on how you’ve connected the platforms), or by configuring via settings within the console.

The website I used for testing and confirmation of this process is the same one you are probably reading this on, which is raygervais.ca! Notice that lovely lock in the URL?

## Conclusion

This post I don’t find to be the best in structure or information, but it does provide one item which I was looking for when trying to understand and implement SSL on my GoDaddy based sites; how to do it. Finding ZeroSSL wasn’t as easy as I would expect, and included searching through various forums and tickets, with no direct link or resource pointing to it from the search itself. Hence, I wrote said post.

Once you go through the process twice, you’ll see just how easy it is to setup Let’s Encrypt on your domain, and have a valid secure site!

## Sources & Reference

- [https://www.howtogeek.com/181767/htg-explains-what-is-https-and-why-should-i-care/](https://www.howtogeek.com/181767/htg-explains-what-is-https-and-why-should-i-care/)
- [https://letsencrypt.org/how-it-works/](https://letsencrypt.org/how-it-works/)
- [https://zerossl.com/ssl-videos.html](https://zerossl.com/ssl-videos.html)
- [https://www.wpbeginner.com/beginners-guide/how-to-get-a-free-ssl-certificate-for-your-wordpress-website/](https://www.wpbeginner.com/beginners-guide/how-to-get-a-free-ssl-certificate-for-your-wordpress-website/)
- [https://www.godaddy.com/web-security/ssl-certificate](https://www.godaddy.com/web-security/ssl-certificate)
- [https://www.troyhunt.com/heres-why-your-static-website-needs-https/](https://www.troyhunt.com/heres-why-your-static-website-needs-https/)
- [https://www.makeuseof.com/tag/best-web-hosting-services/](https://www.makeuseof.com/tag/best-web-hosting-services/)
- [https://www.makeuseof.com/tag/best-wordpress-hosting-providers/](https://www.makeuseof.com/tag/best-wordpress-hosting-providers/)
