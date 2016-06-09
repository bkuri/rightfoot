module.exports =
  conventions:
    assets: /^app\/assets\//

    ignored: [
      /[\\/]_/
      /vendor[\\/]node[\\/]/
      /^app\/partials/
    ]

  files:
    javascripts:
      joinTo:
        'js/app.min.js': /^app/
        'js/vendor.min.js': /^(?!app)/

    stylesheets:
      joinTo: 'css/app.min.css'

  overrides:
    production:
      optimize: yes
      sourceMaps: no

      plugins:
        autoReload:
          enabled: no

        jadeStatic:
          pretty: no

        pleeease:
          autoprefixer: yes
          import: yes
          minifier: yes
          mqpacker: yes
          rem: ['16px']
          variables: yes

        stylus:
          compress: yes

        uglify:
          ignored: /^_.+\.js$/
          mangle: yes

  plugins:
    coffeelint:
      useCoffeelintJson: yes

    jadeStatic:
      locals: require('fs-cson').readFileSync('app/variables.cson')
      formatPath: (path) -> path.match(/^app\/(.+)\.jade$/)[1]
      extension: '.html'

    pleeease:
      autoprefixer: yes
      import: no
      minifier: no
      mqpacker: no
      rem: no
      variables: yes

    stylus:
      compress: no

    uglify:
      ignored: /^.+$/

  watcher:
    awaitWriteFinish: yes
    usePolling: yes
