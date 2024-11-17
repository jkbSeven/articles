---
title: "Creating a personalized blog has never been easier"

author: "jkb"

date: 2024-11-05T18:55:04+01:00

tags: ["hugo", "papermod", "cloudflare"]

draft: false

searchHidden: false

ShowReadingTime: true
ShowPostNavLinks: true
ShowBreadCrumbs: true
ShowCodeCopyButtons: false
ShowWordCount: true
ShowRssButtonInSectionTermList: true

disableShare: true

comments: false
hidemeta: false
hideSummary: false

UseHugoToc: true
showtoc: false
tocopen: false

editPost:
    URL: "https://github.com/jkbSeven/articles/content"
    Text: "Suggest changes"
    appendFilePath: true
---

Let's say that suddenly, out of a long list of personalities, ambitious writer takes over control.
You want to create a blog where you will post articles about things that really interest you.
A couple of problems show up right away, here is how I dealt with them.

## Damn it, I hate frontend
There are a lot of ways of creating a blog right now - you can for example:
* use "website builders"
* use WordPress
* write your own framework for creating static websites

or... use [Hugo](https://gohugo.io/) - super fast SSG (Static Site Generator) written in _Go_  
{{< newline 1 >}}
You can choose from a variety of [themes](https://themes.gohugo.io/) or create your own.
Hugo is very flexible which is great, because you can truly create a blog that suits your needs and design desires.
You can also keep track of all your articles with _git_ - amazing!

I didn't want to use "website builders" or WordPress as I'm not really into putting blocks on the screen.
I'm a caveman and a terminal user, so I really wanted to write articles in Markdown.

I'd been thinking about creating my own framework (which definitely would be a good learning exercise btw),
but I'm running out of time lately, so that was not an option.

Why Hugo and not Jekyll?
Honestly I don't really know, probably because I'm familiar with Go and have zero knowledge about Ruby.

### I'm not a CSS engineer, gotta pick a community theme
I went with PaperMod, which I think is the most popular one, but for a good reason.
It is very clean and has _a lot_ of features.

I was struggling a bit at the beginning,
because I was completely new to Hugo and if that wasn't enough, each theme has its own additional configuration.

After getting through the documentation and checking some options on the go,
I managed to get to a state, that I was really satisfied with.
I've decided to keep it very minimal - search, table of contents, tags and ability to suggest changes by readers. 
The last one is really cool as this is done via merge request on GitHub

### Boosting my ego with "about me" page
With theme and most of Hugo configured, it was time to actually create some content.
The homepage is configured in the main Hugo config file `hugo.yaml`, 
that is where I put the blog description - first thing that you see, when you visit the website.  

`Search` and `About me` are added separately in the `content` directory.
In the meantime I found that some settings didn't really suit my needs,
so I was tweaking the configuration on the go.
That is what I like the most about this approach, it is very easy to change stuff according to your liking.

Got the above pages to an acceptable state, which meant that all that's left to do is to add favicons.

### Bloody favicons...
I had zero experience with favicons, so research was needed.
I came across [this](https://stackoverflow.com/questions/4014823/does-a-favicon-have-to-be-32%C3%9732-or-16%C3%9716)
and [this](https://stackoverflow.com/questions/48956465/favicon-standard-2024-svg-ico-png-and-dimensions)
question on stackoverflow.
While still a bit confused, I opened GIMP and proceeded to use 100% of my artistic skills.
It wasn't terrible. It was time to export the image.

Well, it didn't look good anymore. I created the icon in 512x512 resolution and wanted to scale it down.
It was a disaster.

In the end I decided to create an icon with [favicon generator](https://favicon.io/).
I wanted a very simple icon, so this solution turned out to be perfect.

After wasting a ton of time on this almost irrelevant topic, the frontend side of things was done.

### A couple more of Hugo's tricks
You can create `archetypes` - templates for new content.  
I created an ["article" archetype](https://github.com/jkbSeven/articles/blob/main/archetypes/article.md),
which contains a basic configuration
such as author, title, tags, share options, etc.
Whenever I want to create a new article I simply use  
`hugo new content --kind article OUTPUT_PATH` and that's it, no need to repetitively fill out metadata.

One more cool thing - `shortcodes`.
These are basically Go HTML templates that you can later easily embed in your content.
I created a ["newline" shortcode](https://github.com/jkbSeven/articles/blob/main/layouts/shortcodes/newline.html)
which allows me to insert a specified amount of `<br />` elements.
It serves as a workaround for Markdown's inability to include more than one newline.

## How do I host this blog?
I could technically host it on my server, but there were a lot of issues:
- no static IP
- no way of isolating the web server from other hosts on the network
- 99% chance to misconfigure something and create a cosy backdoor for some folks in black hoodies

### Cloudflare comes in clutch
One of their services, Cloudflare Pages, allows for hosting a static website in a very fast manner.
You simply attach your GitHub repo, tell what framework you are using
and what branch it should follow and it's basically done.
Every time you push changes to the specified branch, they are automatically deployed.

[Detailed instructions for deploying Hugo on Cloudflare](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)

And now the most exciting thing - you get unlimited requests. Yes.
Unlimited requests, worry-free infrastructure and a subdomain of your choice. All of that for **$0.00**.
It honestly feels too good to be true, but this is the reality.
I've spent some time trying to find a catch, but there doesn't seem to be one.

I was struggling with URL for a few minutes,
because in the build command I was trying to use `$CF_PAGES_URL` as Hugo's `baseURL`.
The problem was that this env variable contains URL for current deployment (`xxx.your_subdomain.pages.dev`)
and not the actual subdomain (`your_subdomain.pages.dev`).
After realizing that, I simply hardcoded the subdomain and I was good to go.

## Summary
So there it is, easy and very personalized way of creating a blog.

Is it good for everyone? Obviously not.  
Is it good for engineers? Absolutely.

Total time spent: ~6.5h
* configuring Hugo and PaperMod: ~4.5h
* figuring out favicons: ~1h
* research on Cloudflare Pages: ~1h

I think the outcome is really amazing and the fact that it is securely hosted for free is just incredible.
