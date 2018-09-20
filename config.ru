require './main'

map('/healthz') { run HealthzController }
map('/urls') { run UrlController }
map('/') { run HomeController }
