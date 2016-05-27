# change your local variables here

locals =
  charset: 'utf-8'
  lang: 'es'
  name: 'expedia-728x90'

  banner:
    height: 90
    width: 728

  url:
    app: 'app.js'
    css: 'app.min.css'
    form: 'mailer.php'
    vendor: 'vendor.js'


# See http://brunch.io/docs

module.exports =
  conventions:
    assets: /^app\/assets\//

    ignored: [
      /[\\/]_/
      /vendor[\\/]node[\\/]/
      /vendor[\\/](j?ruby-.*|bundle)[\\/]/
      /^app\/partials/
    ]

  files:
    javascripts:
      joinTo:
        'app.js': /^app/
        'vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'app.min.css'

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
    jadeStatic:
      locals: locals
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
