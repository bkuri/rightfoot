<img src="http://i1039.photobucket.com/albums/a472/bkuri/g4204_zpsgxzdynlo.png">

A+ nodejs development environment for jump-starting web projects.
-----------------------------------------------------------------

-	[Brunch](http://brunch.io) for super-fluid development (with [some extra help](#brunch)\)
-	[Coffeescript](http://coffeescript.org) for clean, expressive JS
-	[Marko](http://markojs.com) for clean, expressive HTML templates
-	[PostCSS](http://postcss.org) for awesome CSS manipulation powers
-	[Stylus](https://learnboost.github.io/stylus/) for powerful CSS precompilation
-	[UglifyJS](http://lisperator.net/uglifyjs) for JS minification

It features on-the-fly compilation, optimization and page reloading.

Everything is preset and ready to go. Simply follow the instructions below and start editing `index.marko`.

Installing
----------

### 1. Node.js

Install [Node.js](http://nodejs.org). Visit [the download site](http://nodejs.org/download/) and download the version appropriate to your OS. Once `node` and `npm` commands are available on your system, run the following:

### 2. Other NPM packages

Install Brunch & Coffeescript globally (you may need root permissions):

`# npm i -g brunch coffee-script`

Clone this repo and run the following command inside the `rightfoot` directory:

`$ npm install`

This will create a directory called `node_modules` and install its packages (using `package.json` for configuration).

<a name="brunch"></a>The following brunch plugins are subsequently installed:

-	[auto-reload-brunch](https://github.com/brunch/auto-reload-brunch)
-	[coffee-script-brunch](https://github.com/brunch/coffee-script-brunch)
-	[marko-brunch](https://github.com/bkuri/marko-brunch)
-	[postcss-brunch](https://github.com/iamvdo/postcss-brunch)
-	[javascript-brunch](https://github.com/brunch/javascript-brunch)
-	[stylus-brunch](https://github.com/brunch/stylus-brunch)
-	[uglify-js-brunch](https://github.com/brunch/uglify-js-brunch)

### 3. External binaries

You will need to install both GraphicsMagick and RSync in a matter appropriate to your OS in order to generate images and load/save your projects, respectively.

#### Bower packages

Bower no longer comes pre-bundled, but you can easily add it by installing it using `$ npm install bower`. You can then install your bower packages like so: `$bower install --save my-package-name`. This will create a `bower_components` directory and will contain all packages defined inside `bower.json`.

Using
-----

The idea behind this toolkit is to provide everything you need to create a weborama-certified ad in record time. From a live dev server which auto-reloads on every file change, to a QA tester, backup image and zip file generators, this toolkit strives to have everything you need.

In order to start using rightfoot is to issue the following command:`$ npm start`, which will start the wizard automatically. Simply follow the on-screen instructions to generate a valid `variables.cson` and other required files.

The wizard will let you choose from the available templates, as well as choosing libraries from weborama's CDN.

Once the wizard has finished generatin said files, you can proceed to creating your banner by editing files inside the `app` directory. Rightfoot comes bundled with stylus, marko and coffeescript interpreters, which are excellent RAD tools that allow you to generate css, html, and js respectively. You can also just use css/html/js files if you prefer.

finally, you can add your assets (images, videos, non-CDN libraries, audio files, etc) inside the `app/assets` subdirectory and they will be integrated into your project automatically.

Building
--------

You can build a production-ready version of your project by running `$ npm run build`. This will trigger all production-only optimizations, such as concatenation, minification, uglifyjs mangling, etc, as well as providing you with a zip file of all contents.

Extra scripts
-------------

Inside the `npm_scripts` folder are a few scripts that make life a bit easier.

-	`wizard` will assist you in creating a new project or modifying an existing one.
-	`clean` will empty out your `public` folder.
-	`backup` will backup your live project to the `saved` folder.
-	`images` will generate your backup images.
-	`scrub` will reset everything to its original state.
-	`test` will run a battery of tests.
-	`zip` will compress your `public` folder along with its contents.
-	`snapshot` will generate a developer-oriented compiled version of your project.
-	`build` will minify, concatenate and get everything ready for production use.

You can run those scripts using the standard `$ npm run <script_name>`. More scripts are planned for future versions.

Ideas FTW
---------

I will gladly consider suggestions and pull requests. This particular combo has served me really well, but of course there's always room for improvement.

Thanks!
-------
