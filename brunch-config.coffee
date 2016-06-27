module.exports =
  conventions:
    assets: /^app\/assets\//

    ignored: [
      /[\\/]_/
      /^app\/assets\/init/
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

        postcss:
          processors: [
            require('autoprefixer')(['last 8 versions'])
            require('csswring')
            require('pixrem')
          ]

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
      pretty: yes

    postcss:
      processors: [
        require('autoprefixer')(['last 8 versions'])
        require('pixrem')
      ]

    stylus:
      compress: no
      plugins: ['axis']

    uglify:
      ignored: /^.+$/

  watcher:
    awaitWriteFinish: yes
    usePolling: yes
