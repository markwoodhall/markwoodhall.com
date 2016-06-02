{:title  "Deploying Cryogen to Dokku and Digital Ocean."
 :layout :post
 :date   "27-05-2016"
 :image  "http://i.imgur.com/mayJRbx.png"
 :tags   ["clojure" "cryogen" "dokku"]}

 I've recently moved my blog away from [Ghost Blog](https://ghost.org/) hosted at Digital Ocean.
 While I enjoyed using [Ghost](https://ghost.org/) I always found upgrading a bit of a pain and
 wanted a little bit more control than it gave me.

 I've used static site generators previously and this time opted to go with [Cryogen](http://cryogenweb.org/). I chose
 it because it's written in Clojure using technology I like and am familiar with, it looks relatively complete and
 gave a number of options for deployment.

 This post is a guide to deploying a [Cryogen](http://cryogenweb.org/) site using [Dokku](https://github.com/dokku/dokku) to the cloud infrastructure at
 Digital Ocean. In reality though, it's a guide to deploying to anywhere you can host [Dokku](https://github.com/dokku/dokku). I choose Digital Ocean because
 it's easy and convenient to set [Dokku](https://github.com/dokku/dokku) up.

 ## Setting up Dokku

 You will need a Digital Ocean account, once you have one head over to their [management interface](https://cloud.digitalocean.com) and login. You should
 see a list of your current droplets. Click on the "Create Droplet" button highlighted below.

![Create Droplet](http://i.imgur.com/JrYNpxW.png)

After you have clicked "Create Droplet" look for the "One Click Apps" tab.

![One Click](http://i.imgur.com/kxgyEDy.png)

Then we are looking for the [Dokku](https://github.com/dokku/dokku) image.

![Dokku](http://i.imgur.com/j3d5nAF.png)

Next we select a size and region for our Droplet.

![Size & Region](http://i.imgur.com/PVkhwZp.png)

We configure any additional options, I usually add an ssh key and then click "Create".

![Options](http://i.imgur.com/qn1dFMM.png)

I want to setup a domain name to point at the [Dokku](https://github.com/dokku/dokku) instance, so once the Droplet is created I make a note of the IP and head over to the "Networking" tab, below.

![Networking](http://i.imgur.com/1tPlayj.png)

I then add a domain name for the IP address I made a note of, the domain name below just happens to be one I have spare.

![Domain](http://i.imgur.com/hVv0Gmh.png)

With that out the way it should be possible to head to http://ultrarunn.in and see the [Dokku](https://github.com/dokku/dokku) setup. I want to use the domain name I setup
and I configure the use of virtual host naming, then I click "Finish Setup".

![Dokku Setup](http://i.imgur.com/z0IJTwt.png)

Now that is done we have a [Dokku](https://github.com/dokku/dokku) instance that we can deploy to. In our case we will be able to do a:

```
git remote add deploy dokku@ultrarunn.in:ultrarunn.in # this will deploy to the root domain
git remote add deploy dokku@ultrarunn.in:blog # this will deploy to the blog sub domain

git push deploy master
```

Right, let's get something to deploy.

## Cryogen

It's easy to get started with [Cryogen](http://cryogenweb.org/), in a suitable directory run the following.

```
lein new cryogen my-blog
```

Then `cd my-blog` and run `lein ring server`. You should then see the default [Cryogen](http://cryogenweb.org/) site in your default browser.

![Default Cryogen](http://i.imgur.com/76qltCr.png)

Next, stop the ring server. While still in the `my-blog` directory run `git init` and `git remote add deploy dokku@ultrarunn.in:ultrarunn.in`.

At this point I take a copy of everything in the `my-blog` directory and  clear it down, apart from the git required files. I then move the contents of `resources/public`
from the copy I made of `my-blog` into the root of the `my-blog` folder and commit everything to the master branch.

I then add a `.env` file in the root with the following contents.

```
export BUILDPACK_URL=https://github.com/markwoodhall/buildpack-nginx.git
```

This instructs [Dokku](https://github.com/dokku/dokku) to use the GitHub repo for it's build back. This build back is an nginx buildpack that supports static site generators, I didn't create it but forked
it and made some small adjustments.

This buildpack also requires a `.static` file to exist, so I run `touch .static` and commit the changes to `master`.

Now it's as easy as running a `git push deploy master`.

After a couple of minutes (It's longer the first time as it downloads the buildpack, which is then cached) browsing to http://ultrarunn.in/blog should result in.

![Result](http://i.imgur.com/ylkBYfw.png)

Note, the `/blog` comes from Cryogens config and can be easily changed, if desired.

With all of that done I run `git checkout -b source` and copy the contents from the copy I made of `my-blog`, I then commit that to the source branch. This leaves us with
`master` containing the results of `lein ring server` i.e. the static blog and `source` containing the source code. Anytime I push `master` to the `deploy` remote I
update the deployed blog. I then push the git repo to GitHub/BitBucket etc.

I ended up creating a less than perfect script to automate this somewhat. I checkout the `source` branch, run `vim publish.sh` and add the following.
```
cp -r resources/public ../public
git checkout master
cp -r ../public/* ./
git add .
git commit . -m "Publish"
git push origin master
git push deploy master
rm -rf ../public
```
I then commit `publish.sh`, run `lein ring server` and then kill it. Running `publish.sh` while on the `source` branch will copy the static content
from `resources/public`, stash it a level higher up in `../public`, checkout the `master` branch, copy `../public/*` back in and commit the change. After which it
will push to `deploy` and `master`.
