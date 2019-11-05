
---
title: "Jekyll"
date: 2019-11-05T19:14:57+11:00
draft: true
---

Hello
The tutorial which helped me the most has been this:
<http://dev.im-bot.com/jekyll-travis-github/>
Although When I was following there still were a few things which were unclear. So here we are...
## 1. Getting a skeleton Jekyll website up

I discovered that someone already made a template repo: <https://github.com/barryclark/jekyll-now><br>
Or fork from <https://github.com/joshcarp/joshcarp.github.io><br>

I guess it's advised to get Jekyll running locally, even though the end game is to have it all deployable through travis; Sometimes you'll install a plugin and want to test it locally/ need to install another Gem or something. 
<br><https://jekyllrb.com/docs/>

## 2. Travis build to master
Secondly You'll need a github access token with repo push access only and travis set up in order for it to push to master. 

After you've got your access key you want to install the travis gem and hash it then add replace yours in the `.travis.yml` file in the repo. 
Oh, don't forget to enable travis builds on the `jekyll` branch



## 3. Customising Jekyll
 You can customise the theme your website uses by adding `theme: theme_name` to the `_config.yml` and adding the gem to your Gemfile then bundle install to update dependencies. 

Another option is to branch the repo of a theme, add the _site, _includes, _sass/, assets/ and scripts/ to your Jekyll branch, although I haven't tested this. 

## 4. Enabling google analytics
add `google_analytics: <YOUR ANALYTICS CODE>` to your `_config.yml` file. 

## 6. Adding a custom domain
I'm using google domains with a DNS CNAME record which forwards joshcarp.com to joshcarp.github.io. 
To enable this on the github pages I made a file called CNAME on the `jekyll` branch in the root directory and in `_site` and also one in the root of master with `joshcarp.com` in it, that way github will allow incoming connections from `joshcarp.com`

## 7. custom permalinks
A permalink is how your pages show up in the url. To set a custom one you can add a link in `_config.yml`:<br>
`permalink: /:collection/:title/`
and the default collection for posts is `/posts` as can be seen in the url
some other conventions include using dates, although I don't think that is necessary at this point. 

## 5. Problems
- After installing new plugins Travis was failing:
`The command "bundle exec jekyll build" exited with 1.`
<br>to fix this we need to update the Gemfile by appending the plugin gems <br>
`gem 'jekyll-sitemap'
 gem 'jekyll-seo-tag'`
<br>
Then the Gems need to be installed with:
`bundle install && bundle update`

- If Google analytics isn't working, make sure that you've set the  `JEKYLL_ENV=production` as an environment variable in travisci 



# Apache Virtual hosts
I still want some subdomains to point at my home network, and with that, I want to be able to host multiple websites on the same domain. 
Apache virtual hosts are a way to "redirect" based on where traffic is coming from. 
In my case I have a `go present` presentation running on port 8080 of my server, although I want to be able to access this at the web address gophercon.joshcarp.com <br>

DNS records fundamentally don't allow port redirects, so virtual hosts are a way around this. 
Steps:
1. Have a CNAME record pointing `gophercon.joshcarp.com` to my home IP address.
2. Have apache running on port 80
3. in `/etc/apache2/sites-avaliable` add a file `gophercon.joshcarp.com.conf` and add

``` sh
<VirtualHost *:80> 
  ProxyPreserveHost On
  ProxyRequests Off
  ServerName gophercon.joshcarp.com
  ProxyPass  / http://localhost:8080/
</VirtualHost> 
```
4. enable the site with `sudo a2ensite gophercon.joshcarp.com.conf`<br>
This will redirect incoming traffic from gophercon.joshcarp.com to port 8080 on localhost. 

I can also use this to set root directories for serving websites. 
If I want to set a document root and serve files from there, I can with the following config
``` sh
<VirtualHost *:80>
    ProxyPreserveHost On
     ProxyRequests Off
     DocumentRoot "/var/www/html"
     ServerName home.joshcarp.com
   </VirtualHost>
```

And this will serve all the documents in "/var/www/html" when incoming traffic is encountered from home.joshcarp.com, although I want to keep all web related stuff on github pages at the moment. 

References:
<http://dev.im-bot.com/jekyll-travis-github/>

