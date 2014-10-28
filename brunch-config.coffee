# See http://brunch.io/#documentation for docs.

exports.config =
  conventions:
    assets: /^app\/assets\//

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^(bower_components|vendor)/

    stylesheets:
      joinTo:
        'css/app.min.css': /^(app|bower_components|vendor)/
      order:
        before: ['app/app.css']

    templates:
      joinTo:
        '.compile-jade': /^app/

  modules:
    definition: false
    wrapper: false

  optimize: true

  overrides:
    minifier:
      sourceMaps: false

      plugins:
        pleeease:
          optimizers:
            minifier: true
            mqpacker: true

  paths:
    jadeCompileTrigger: '.compile-jade'

  plugins:
    jadePages:
      htmlmin: false

      jade:
        pretty: yes

    pleeease:
      fallbacks:
        autoprefixer: true
        rem: false
        variables: true

      optimizers:
        import: false
        minifier: false
        mqpacker: false

    uglify:
      compress:
        global_defs:
          DEBUG: false

      mangle: false
