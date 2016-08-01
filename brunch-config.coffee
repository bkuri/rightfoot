module.exports =
  conventions:
    assets: /^app\/assets\//

    ignored: [
      /[\\/]_/
      /^lib\/npm/
      /^lib\/tags/
      /^lib\/templates/
      /^public/
      /^saved/
      /^test/
      /vendor[\\/]node[\\/]/
    ]

    vendor: /(^node_modules|vendor)/

  files:
    javascripts:
      joinTo:
        'app.js': /^app/
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
            require('postcss-base64')(extensions: ['.jpg', '.png'])
            require 'csswring'
            require 'pixrem'
          ]

  plugins:
    coffeelint:
      useCoffeelintJson: yes

    marko:
      data: require('fs-cson').readFileSync('app/variables.cson')

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
