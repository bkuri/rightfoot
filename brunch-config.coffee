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
        'app.min.js': /^app/
        'vendor.min.js': /^(?!app)/

    stylesheets:
      joinTo: 'app.min.css'

  overrides:
    production:
      optimize: yes
      sourceMaps: no

      plugins:
        autoReload:
          enabled: no

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

    marko:
      data: require('fs-cson').readFileSync('app/variables.cson')

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
