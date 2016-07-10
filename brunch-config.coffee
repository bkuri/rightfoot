module.exports =
  conventions:
    assets: /^app\/assets\//

    ignored: [
      /[\\/]_/
      /^app\/assets\/init/
      /^app\/assets\/logos/
      /^app\/assets\/tags/
      /^app\/assets\/templates/
      /^app\/components/
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
      plugins:
        postcss:
          processors: [
            require('autoprefixer')(['last 8 versions'])
            require('postcss-base64')(extensions: ['.jpg'])
            require 'csswring'
            require 'pixrem'
          ]

  plugins:
    coffeelint:
      useCoffeelintJson: yes

    marko:
      data: require('fs-cson').readFileSync('app/variables.cson')
      pretty: yes

    postcss:
      processors: [
        require('autoprefixer')(['last 8 versions'])
        require 'pixrem'
      ]

    stylus:
      compress: no
      plugins: ['axis']

  watcher:
    awaitWriteFinish: yes
    usePolling: yes
