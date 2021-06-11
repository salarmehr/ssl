# ssl
Scripts to create SSL cert/key for each of your local websites using your test Cert Authority

1. run `root.bash` to create your root certificate
2. add the created certificate to your trusted root authorities
3. run `site.bash foo.dev` to create cert/key for a local site named foo.dev
4. a folder named foo.dev will be created, copy server.crt and server.key to user desired location.



## Examples
Below are some examples of the tools which you need to add a local cert to have a valid SSL connection.

### Apache
````apacheconf
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile    "/srv/docker/ssl/server.crt"
    SSLCertificateKeyFile "/srv/docker/ssl/server.key"
</VirtualHost>
````

### Laravel Mix
````js
const mix = require('laravel-mix')
const fs = require('fs')

mix.webpackConfig({
    devServer: {
        host: '0.0.0.0',
        port: 8080,
        https: {
            key: fs.readFileSync("/srv/docker/ssl/server.key"),
            cert: fs.readFileSync("/srv/docker/ssl/server.crt")
        }
    }
})
````

# Credit
Based on https://stackoverflow.com/a/60516812/752603 answer. 
