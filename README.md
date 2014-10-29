<img src="http://media.catmoji.com/post/dmx/my-cat-likes-to-be-comfortable.jpg">

# rightfoot
## A+ nodejs development environment for jump-starting web projects.
* [Coffeescript](http://coffeescript.org) for clean, expressive JS
* [Jade](http://jade.io) for clean, expressive HTML templates
* [Stylus](https://learnboost.github.io/stylus/) for awesome and powerful CSS
* [Bower](http://bower.io) for professional package management
* [Brunch](http://brunch.io) for super-fluid development (with [some extra help](#brunch))
* [Pleeease](http://pleeease.io) for CSS optimization and autoprefixing
* [UglifyJS](http://lisperator.net/uglifyjs) for JS minification

It features on-the-fly compilation, optimization and page reloading.

Everything is preconfigured and ready to go. Simply follow the instructions below and start editing `index.jade`.


## Installing
### 1. Node.js
Install [Node.js](http://nodejs.org).  Visit [the download site](http://nodejs.org/download/) and download the version appropriate to your OS. Once `node` and `npm` commmands are available run the following:
 `$ npm install`

This will create a directory called `node_modules` and install its packages (using `package.json` for configuration).


### <a name="brunch"></a>2. Brunch
You can install it using the node package manager:
`# npm install -g brunch`

The following brunch plugins are subsequently installed:
* [auto-reload-brunch](https://github.com/brunch/auto-reload-brunch)
* [brunch-pleeease](https://www.npmjs.org/package/brunch-pleeease)
* [coffee-script-brunch](https://github.com/brunch/coffee-script-brunch)
* [jade-pages-brunch](https://github.com/Kagami/jade-pages-brunch)
* [javascript-brunch](https://github.com/brunch/javascript-brunch)
* [stylus-brunch](https://github.com/brunch/stylus-brunch)
* [uglify-js-brunch](https://github.com/brunch/uglify-js-brunch)

#### Brunch notes
* Consider uninstalling `auto-reload-brunch` when it's time to publish.
* `jade-pages-brunch` is used to compile flat html. Consider an alterntative like `jaded` if you're looking for something more dynamic.


### 3. Bower
Install it using:
`# npm install -g bower`

#### Installing packages
Install your bower packages and add version info to `package.json`:
`bower install --save my-package-name`

This will create a `bower_components` directory and will contain all packages defined inside `bower.json`.

#### Note
You will need git available in your $PATH for the last command to work. Windows users are recommended to run that command inside a git shell.


## Using
Simply issue the following command:
`npm start`

This will start a server on `http://localhost:3333`.

You can now edit `index.jade` for the main content, as well as `scripts/app.coffee` for the main JS and `styles/app.styl` for the CSS. Everything will be minified/autoprefixed/compiled in real time as soon as you save your changes.


## Deploying
Remember to remove brunch's auto-reload package once you're ready to publish:
`npm uninstall --save auto-reload-brunch`


## Ideas FTW
I will gladly consider suggestions and pull requests. This particular combo has served me really well, but of course there's always room for improvement.


## Thanks!
