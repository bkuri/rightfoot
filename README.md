<img src="http://i1039.photobucket.com/albums/a472/bkuri/g4204_zpsgxzdynlo.png">

A+ nodejs development environment for jump-starting web projects.
-----------------------------------------------------------------

-	[Brunch](http://brunch.io) for super-fluid development (with [some extra help](#brunch)\)
-	[Coffeescript](http://coffeescript.org) for clean, expressive JS
-	[Jade](http://jade.io) for clean, expressive HTML templates
-	[Pleeease](http://pleeease.io) for CSS optimization and autoprefixing
-	[Stylus](https://learnboost.github.io/stylus/) for awesome and powerful CSS
-	[UglifyJS](http://lisperator.net/uglifyjs) for JS minification

It features on-the-fly compilation, optimization and page reloading.

Everything is preset and ready to go. Simply follow the instructions below and start editing `index.jade`.

Installing
----------

### 1. Node.js

Install [Node.js](http://nodejs.org). Visit [the download site](http://nodejs.org/download/) and download the version appropriate to your OS. Once `node` and `npm` commmands are available on your system, run the following:

`$ npm install`

This will create a directory called `node_modules` and install its packages (using `package.json` for configuration).

### <a name="brunch"></a>2. Brunch

You can install it using the node package manager: `# npm install -g brunch`

The following brunch plugins are subsequently installed:

-	[auto-reload-brunch](https://github.com/brunch/auto-reload-brunch)
-	[coffee-script-brunch](https://github.com/brunch/coffee-script-brunch)
-	[jade-static-brunch](https://github.com/stephenhutchings/jade-static-brunch)
-	[pleeease-brunch](https://github.com/iamvdo/pleeease-brunch)
-	[javascript-brunch](https://github.com/brunch/javascript-brunch)
-	[stylus-brunch](https://github.com/brunch/stylus-brunch)
-	[uglify-js-brunch](https://github.com/brunch/uglify-js-brunch)

#### Installing packages using bower

Bower no longer comes pre-bundled, but you can easily add it by installing it using `$ npm install bower`. You can then install your bower packages like so: `$bower install --save my-package-name`. This will create a `bower_components` directory and will contain all packages defined inside `bower.json`.

Using
-----

Simply issue the following command:`$ npm start`. This will start a server on `http://localhost:3333` which you can open on your browser.

You can now edit `index.jade` for the main content, as well as `scripts/app.coffee` for the main JS and `styles/app.styl` for the CSS. Everything will be compiled in real time as soon as you save your changes.

Deploying
---------

You can deploy a production-ready version of your project by running `$ npm run deploy`. This will trigger all production-only optimizations, such as concatenation, minification, uglifyjs mangling, etc, as well as providing you with a zip file.

Extra scripts
-------------

Inside the `npm_scripts` folder are a few scripts that make life a bit easier. The `clean` script will empty out your `public` folder. The `zip` script will zip up that same folder's contents. The `wizard` script will assist you in creating a new `variables.cson` file. You can run those scripts using the standard `$ npm run <script_name>`. More scripts are planned for future versions.

Ideas FTW
---------

I will gladly consider suggestions and pull requests. This particular combo has served me really well, but of course there's always room for improvement.

Thanks!
-------
