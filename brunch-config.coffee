module.exports =
  conventions:
    assets: /^app\/assets\//

    ignored: [
      /[\\/]_/
      /^app\/assets\/logos/
      /^app\/assets\/templates/
      /^app\/partials/
      /vendor[\\/]node[\\/]/
    ]

  files:
    javascripts:
      joinTo:
        'banner.js': /^app\/scripts\/banner/
        'layer.js': /^app\/scripts\/layer/
        'vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'app.css'

  modules:
    definition: no
    wrapper: no

  npm:
    enabled: no

  overrides:
    production:
      optimize: yes
      sourceMaps: no

      plugins:
        autoReload:
          enabled: no

        marko:
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

    keyword:
      filePattern: /\.js$/

      map:
        format: -> 'banner'

    marko:
      data: require('fs-cson').readFileSync('app/variables.cson')
      pretty: yes

    pleeease:
      autoprefixer: yes
      import: no
      minifier: no
      mqpacker: no
      rem: no
      variables: yes

    stylus:
      compress: no
      plugins: ['axis']

    uglify:
      ignored: /^.+$/

  watcher:
    awaitWriteFinish: yes
    usePolling: yes
