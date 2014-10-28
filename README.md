# rightfoot
## Superstar-grade nodejs development environment for web projects.
Uses the following kickass libraries to get you started in record time:

* [Coffeescript](http://coffeescript.org) for clean, expressive JS
* [Jade](http://jade.io) for clean, expressive HTML templates
* [Stylus](https://learnboost.github.io/stylus/) for awesome and powerful CSS
* [Bower](http://bower.io) for professional package management
* [Brunch](http://brunch.io) for super-fluid development
* [Pleeease](http://pleeease.io) for CSS optimization and autoprefixing
* [UglifyJS](http://lisperator.net/uglifyjs) for JS minification

It features on the fly compilation, optimization and page reloading (as long as [auto-reload-brunch](http://github.com/brunch/auto-reload-brunch) is kept installed):

Everything is preconfigured and ready to go. All you need to do is add your bower libraries and start editing `index.jade` to your liking.


## Install
### Node.js
Install [Node.js](http://nodejs.org).  Visit [the download site](http://nodejs.org/download/) and download the version appropriate to your OS. Once `node` and `npm` commmands are available run the following:
 `$ npm install`

This will create a directory called `node_modules` and install its packages (using `package.json` for configuration).


### Brunch
Install it using:
`# npm install -g brunch`


### Bower
Install it using:
`# npm install -g bower`

#### Installing packages
Install your bower packages and add version info to `package.json`:
`bower install --save my-package-name`

Note: You will need git available in your $PATH for the last command to work. Windows users are recommended to run that command inside a git shell.

The previous step will create a `bower_components` directory and will contain all packages defined inside `bower.json`.


### Use
Simply issue the following command:
`npm start`

This will start a server on `http://localhost:3333`.

You can now edit `index.jade` for the main content, as well as `scripts/app.coffee` for the main JS and `styles/app.styl` for the CSS. Everything will be minified/autoprefixed/compiled in real time as soon as you save your changes.


### Deploy
Remember to remove brunch's auto-reload package once you're ready to publish:
`npm uninstall --save auto-reload-brunch`


### Ideas welcome!
I will gladly accept suggestions. This particular combo has served me really well, but of course there's always room for improvement.


### Thanks!
