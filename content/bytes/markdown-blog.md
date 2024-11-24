---
title: "Build and deploy a Markdown blog in a blink of an eye"

author: "jkb"

date: 2024-11-23T18:38:00+01:00

tags: ["hugo", "papermod", "cloudflare"]

draft: false

searchHidden: false

ShowReadingTime: true
ShowPostNavLinks: false
ShowBreadCrumbs: true
ShowCodeCopyButtons: false
ShowWordCount: true
ShowRssButtonInSectionTermList: true

disableShare: true

comments: false
hidemeta: false
hideSummary: false

UseHugoToc: true
showtoc: true
tocopen: false

editPost:
    URL: "https://github.com/jkbSeven/articles/content"
    Text: "Suggest changes"
    appendFilePath: true
---

Let's say that suddenly, out of a long list of personalities, ambitious writer takes over.  
You want to create a blog, where you will post articles about things you find very interesting.
A couple of problems show up right away - how to structure it? how to style it? how do I even deploy it?

There is actually a suprisingly easy way to solve all those problems and here is how.

## Problem No. 1: How do I even start?
There are a lot of ways of creating and styling a blog right now - you can for example:
* use "website builders"
* use WordPress
* write your own framework for creating static websites

or... use [Hugo](https://gohugo.io/) - super fast SSG (Static Site Generator) written in _Go_, where creating a Markdown
file is equivalent to creating a post.

I didn't want to use "website builders" as I'm not really into putting blocks on the screen.
I'm a caveman and a terminal user, so I really wanted to write articles in Markdown - WordPress had to go as well.

I'd been thinking about creating my own framework (which definitely would be a good learning exercise btw),
but I'm running out of time lately, so that was not an option.

Why Hugo and not Jekyll?
Honestly I don't really know, probably because I'm familiar with Go and have zero knowledge about Ruby.

### Damn it, I hate frontend
With Hugo you can choose from a variety of [themes](https://themes.gohugo.io/) or create your own.
I went with [PaperMod](https://github.com/adityatelange/hugo-PaperMod),
which I think is the most popular theme, but for a good reason.
It is very clean and has _a lot_ of features. I also really like how it looks on mobile devices.

So... Hugo it is, moving on to configuration.

## Problem No. 2: Swimming in the configuration lake
Well if the blog is supposed to be very customizable, there must be a lot of options available
and a lot of configuration required.
You can't have it both ways.

### The difficult bit
While Hugo's documentation is well written, getting through PaperMod's one was more difficult
(totally expected, as this is just a community theme), but still doable of course.

After reading the docs and checking some options on the go, I managed to get the blog to a state, that I really liked.
I've decided to keep it very minimal - search, table of contents, tags and ability to suggest changes by readers. 
The last one is really cool, as this is done via merge request on GitHub.

The configuration really just came down to copying the default config from PaperMod's docs,
reading through all the options, researching ones that were not obvious, applying changes according to my liking
and, last but not least, striping all the stuff related to analytics.

One thing I learnt along the way, that I think is worth sharing - what's the purpose of
[robots.txt](https://www.cloudflare.com/learning/bots/what-is-robots-txt/) 

### Bloody favicons...
I had zero experience with favicons, so I needed to do some research.
I came across [this](https://stackoverflow.com/questions/4014823/does-a-favicon-have-to-be-32%C3%9732-or-16%C3%9716)
and [this](https://stackoverflow.com/questions/48956465/favicon-standard-2024-svg-ico-png-and-dimensions)
question on stackoverflow.
While still a bit confused about what resolutions do I really need,
I opened GIMP and proceeded to use 100% of my artistic skills. It wasn't terrible, so it was time to export my image.

Well, let's just say it didn't look good anymore.
I created the icon in 512x512 resolution and scaled it down, it was a disaster.

In the end I decided to create the icon with [favicon generator](https://favicon.io/).
I didn't want anything fancy, so this solution turned out to be perfect.
Icon was generated in all required resolutions and I just had to put it in the `static` directory.

After wasting a ton of time on this almost irrelevant topic, the frontend side of things was done.

### A couple more tricks up Hugo's sleeve
You can create `archetypes` - simply speaking, templates for new content.  
I created an ["article" archetype](https://github.com/jkbSeven/articles/blob/main/archetypes/article.md),
which contains a basic configuration such as author, title, tags, share options, etc.
Whenever I want to create a new article I simply use  
`hugo new content --kind article OUTPUT_PATH` and that's it, no need to repetitively fill out metadata.

One more cool thing - `shortcodes`.
These are basically Go HTML templates that you can easily embed in your Markdown content.
I created a ["newline" shortcode](https://github.com/jkbSeven/articles/blob/main/layouts/shortcodes/newline.html)
which allows me to insert a specified amount of `<br />` elements.
It serves me as a workaround for Markdown's inability to include more than one newline.

## Problem No. 3: Where and how do I deploy this blog?
I could technically host it on my server, but there were a lot of issues:
- no static IP
- no way of isolating the web server from other hosts on the local network
- 99% chance of misconfiguring something and creating a cosy backdoor for some folks in black hoodies

### Cloudflare comes in clutch
One of their services, Cloudflare Pages, allows for hosting a static website in a very fast manner.
You simply attach your GitHub repo, tell Cloudflare what framework you are using and what branch it should follow. 
Every time you push changes to the specified branch, they are automatically deployed.

[Detailed instructions for deploying Hugo on Cloudflare](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)

### Sounds great, what about the price and limitations?
If you read the terms, you see things like unlimited requests, unlimited bandwith,
500 deployments per month, subdomain of your choice (`your_subdomain.pages.dev`).

It sounds really nice, but what's the price? You get all of that for **$0.00**.
It honestly feels too good to be true, but this is the reality.
I've spent some time trying to find a catch, but there doesn't seem to be one.

So basically you get all the good stuff mentioned above and a worry-free infrastructure for free. This is exciting!

### What if I already have a domain?
Well this is another great thing about Cloudflare Pages, you can attach it to your own domain/subdomain.
That's exactly what I did and it was a seamless experience.
I don't know how it would look like if I didn't have my domain registered on Cloudflare,
so I can't really speak for that experience.

### In case you want to host it there as well
Before I attached my own domain, I was struggling a bit with URL for the blog.
In the build command I was trying to use `$CF_PAGES_URL` as Hugo's `baseURL`.
The problem was that this environment variable contains URL for current deployment (`xxx.your_subdomain.pages.dev`)
and not the actual subdomain (`your_subdomain.pages.dev`).
After realizing that, I simply hardcoded the subdomain and I was good to go.

## Summary
So there it is, fully customizable blog with a lot of features securely deployed for free.  
It was honestly a really nice and pleasant experience.

Is it meant for everyone? Obviously not.  
Is it meant for engineers? Absolutely.

### What I liked the most about Hugo
I think its flexibility - you can create a blog that suits your needs and design desires with a very little effort.
You can also keep track of all your articles with _git_ - amazing!

### Numbers behind the whole process
Total time spent: **~6.5h**
* configuring Hugo and PaperMod: ~4.5h
* figuring out favicons: ~1h
* research on Cloudflare Pages: ~1h

If this isn't your first encounter to Hugo then this time will drastically go down.  
If I were to build it from the ground up again, it would probably take me around an hour, mindblowing.
