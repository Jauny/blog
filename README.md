The blog lives at jypepin.com.

### Deploys
The blog is hosted on a Digital Ocean Droplet. Served by nginx and Puma (see `shared/config/puma.rb` on the droplet).

It uses Capistrano to automated developments.  
See `config/deploy.rb` for Capistrano config. Run `bin/rake deploy` to push to master and deploy.

### Reqs
- Rails 5.1
- ruby 2.4
- psql 10.3
