
---
title: The Anne Pro 2 Replacement Project
date: 2024-06-03
tags: ["Open Source", "Linux"] 
Cover: https://images.unsplash.com/photo-1630096711968-d118c17a173a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
---

_Because preferences of a Linux user don't stop at the software

I've used the `Anne Pro 2` since 2016, and though it has served me well -even better since I had installed the OpenQMK alternative firmware on it, I decided to replace it. Why? Well, like all good things, we begin to show our age;  both the USB-C connection and space bar began to become flaky, which are rather important within a wired device used to _type_. So, I decided to see what was new in the world of keyboards and if my preferences which led me to the Anne Pro 2 had changed. Here were my requirements:

## Keyboard Layout and Size

Having lived with a 60% for so long, I feel as if the smaller layouts such as 60% or 65% can be the perfect keyboard size for me. I never use a numpad, nor do I find myself using the `Insert`, `End`, , `Home`, `Page Up` or `Page Down` keys at all. The only time I may glance that direction is if I'm about to take a screenshot, but that is also a shortcut that I setup on all my systems `<CTRL>+<ALT>+P`. Though I do enjoy the function that 75% and above can provide, a keyboard bigger also forces the keys themselves to be offset to the left if I were to have the keyboard centred between my two monitors. 

## Keycaps and Profiles

![CSA Keycaps](https://m.media-amazon.com/images/S/aplus-media-library-service-media/b04c60d9-9c5e-491d-9b02-a4c62abd92d6.__CR0,0,1464,600_PT0_SX1464_V1___.jpg)

I've had quite a fun time trying new keycaps over the years, and have to enjoy the  `XDA`, `CSA` and `SA` profiles for my keycaps. These can also be added after, so a keyboard not including them by default I don't see a determent -as long as the included keycaps are good-enough quality to last until I want to replace them with my beloved keycaps.  My previously used ones are the set pictured.

That being said, they _MUST_ be PBT.  [Corsair explains](https://www.corsair.com/us/en/explorer/gamer/keyboards/abs-vs-pbt-keycaps/#:~:text=PBT%2C%20as%20compared%20to%20ABS,losing%20their%20color%20over%20time.) the difference between PBT and ABS well,

> PBT, as compared to ABS, is far more robust, so it both wears more slowly than ABS, and the pattern of wear is more even, so the keycaps stay usable and pretty for longer. Additionally, PBT is more resistant to degradation caused by UV light. UV being the main cause of vibrant keycaps losing their color over time. This means that PBT keycaps will keep their color, and their pleasing texture for longer.

## Key Switches

Previously, I've had keyboards which contained CherryMX Blue, Gateron Browns, and with the Anne Pro 2, Khail Boxed Whites. Yet, there was a key switch class which I had never considered before which had caught my attention, linears. Of all things, it was a YouTube Video by [Hipyo Tech - Make Your Keyboard THOCK for $3](https://www.youtube.com/watch?v=vxUmoTa_4aI) which actually got me to consider linears and also evaluate how my Anne Pro 2 sounded. The clicky Kailh Boxed Whites produce a high pitched `clacky` sound characteristic that some go for, but I wasn't interested in that after hearing of the low-mid ranged `thock`. It had a certain elegance and breath to it. Still, I had tried CherryMX Red's before and wasn't impressed, but these days there's so many competitive offering's with their own flavors, so I why not explore?

Over two months, I had opted to try a few different keyboards to compare and see which I liked best. Those will be explained below, but I made this table to help me understand the mathematical differences which made them feel different. 

| Switch             | Type    | Pin | Operating Force (g) | Actuation Force (g) | Total Travel Distance (mm) |
| ------------------ | ------- | --- | ------------------- | ------------------- | -------------------------- |
| Epomaker Flamingo  | Linear  | 5   | 44                  | 44                  | 3.4                        |
| Epomaker Blue Bird | Linear  | 5   | 47                  | 47                  | 3.8                        |
| Outemu White Jade  | Linear  | 5   | 35                  | 45                  | 3.5                        |
| Gateron Red        | Linear  | 5   | 44                  | w45                 | 4                          |
| Kailh Box Whites   | Clicky  | 3   |                     | 60                  | 3.6                        |
| Gateron Browns     | Tactile | 3   | 55                  | 4                   |                            |
| CherryMX Blue      | Clicky  | 3   | 48                  | 4                   |                            |
|                    |         |     |                     |                     |                            |
An additional **hard requirement** is, that the keyboard must support hot-swappable switches. One thing that I never knew I needed until I learned of it. Having previously come to accept the Anne Pro 2's switches, and more so their incompatibility with Cherry stemmed keycaps, the idea of a keyboard being modular seems incredible. 

## Programmability

For the longest of times, as I mentioned, I've run the Anne Pro 2 using the `openqmk` alternative firmware along with my own customizations. It's been a godsend to be able to customize the keyboard, but Ivve also made it a goal to not customize it *for the sake of being able to customize it*. I found once I had a setup that I was comfortable with, I didn't change. That setup is as follows, and must be implementable as a hard-requirement for any of the keyboards which will succeed it.  It's a simple customization, but one that I believe to be vital for both programmers and those who don't want to take their fingers off of homerow. 

- Remappable `CAPS Lock` key: I like to turn this key into a dedicated `fn` toggle, which is useful for the proceeding changes.
- Remapping `hjkl` to the vim directional keys when in the first `fn` layer of the keyboard. 

## Why Not Keychron? 

Two reasons. One, because I have not tried Keychron before and thus, wasn't sure if I can justify the cost, and two, because I was equally curious how the market has improved since the Anne Pro 2, which was by another eastern company.  Though, I have been considering the V1 Max since it ticks all of the boxes, including first-class support for QMK and VIA configurations. Still, I had already resolved that I wanted to try the other keyboards first and work my way towards Keychron if they disappointed.

## Comparing the Options

### Epomaker Shadow-X
- **Switches:** Epomaker Blue Birds
- **Layout:** 70%
- **Build:** Plastic / Hot Swappable
- **QMK / VIA?** No
- **Cost:** $128
- **Link:** [Amazon.ca: Epomaker Shadow-X](https://a.co/d/4jTUP6J)
- **Comments if tested:**
  - Of the recently tested, this one had the loudest thonk, which though is appealing, is not functional late into the night. Far deeper pitched keyswitches too when actuated, which was nice.
  - LCD screen I found was far more of a gimmick, did not provide any useful information and because of the placement, was constantly obstructed by my right hand when typing. Worst, because the software is a really cheap Windows application, I couldn't customize it either unless I was using my dual-booted laptop.
  - The layout looks cool, but it isn't practical if you like me, enjoy having the keyboard centered on the desk. 

### Epomaker EK68
- **Switches:** Epomaker Flamingo
- **Layout:** 68%
- **Build:** Plastic / Hot Swappable
- **QMK / VIA?** No
- **Cost:** $150
- **Link:** [Amazon.ca: Epomaker EK68](https://a.co/d/j3uFCXY)
- **Comments if tested:**
  - Switches feel good, still loud for linears.
  - Capslock doesn't toggle until you hit an additional key after.
  - Similar to the Shadow X, crappy windows software left me with a lot to be desired. I would have forgiven the software if I knew that once I set it up, I wouldn't have to return to it again; but alas even the options provide by the software didn't cover my base needs. Ex, I couldn't remake any keys such as `CapsLock` to `Fn` when long pressed -a common mapping that I do to all my keyboards coming from my `vi` roots, with `fn` active `hjkl` follows the traditional vim navigation.

### M71
- **Switches:** Outemu White Jade
- **Layout:** 68%
- **Build:** Aluminium / Hot-swappable
- **QMK / VIA?** No
- **Cost:** $100
- **Link:** [Amazon.ca: M71](https://a.co/d/cv5CURw)
- **Comments if tested:**
  - Switches aren't nearly as clicky which I appreciate; and for linear's they don't feel nearly as soft or easily hit-able. Short travel distance I'm noticing.
  - Metal frame feels good.
  - White frame was an interesting choice, but I wager paired with a good set of keycaps this will be decent.
  - HAS a caps lock indicator which is visible when active. The EK68 didn't.
  - The caplock key doesn't require an additional key switch to be triggered before it itself is triggered.
  - Not nearly as loud as EPK68 or Shadow-X, absolute pitch appears to be slightly higher, but there's still  `thock` with the stock switches.
  - I already miss the idea of being able to program / switch my keyboard layouts, the lack of QMK / VIA is already making me consider switching to the Keychron. Yet, compared to the Epomakers listed below, the software has allowed me to map for both momentary and long pressed keys; so my `hjkl` mapping lives within the `fn` layer, which in itself can be temporally activated by holding `CapsLock`.

## Choice and Conclusion

Normally I don't find myself agreeing with YouTubers, but I won't lie, Hippyo Tech's recommendation of the [_M71|S-K71_ Keyboard](https://www.youtube.com/watch?v=Jv_wmuEnyoA) was spot on for those looking for a premium feel, real metal frame, and gasket layers. I had never tried keyswitches which are "marbly" before, but these ones impressed me -which is to say, they didn't have me reaching for a comparison to my favorite keyswitch I tried previously, the `Bluebirds` by Epomaker.


## Resources

- [Cover Image: Photo by Islam Warzely on Unsplash](https://unsplash.com/photos/black-computer-keyboard-on-brown-wooden-table-Bcto3TrALq4)
