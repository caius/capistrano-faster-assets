# Capistrano::FasterAssets

This gem speeds up asset compilation by skipping the assets:precompile task if none of the assets were changed
since last release.

Works *only* with Capistrano 3+.

### Installation

Add this to `Gemfile`:

    group :development do
      gem 'capistrano', '~> 3.1'
      gem 'capistrano-rails', '~> 1.1'
      gem 'capistrano-faster-assets', '~> 1.0'
    end

And then:

    $ bundle install

### Setup and usage

Add this line to `Capfile`, after `require 'capistrano/rails/assets'`

    require 'capistrano/faster_assets'
    
### Warning

Please keep in mind, that if you use ERB in your assets, you might run into cases where Capistrano won't recompile assets when needed. For instance, let's say you have a CoffeeScript file like this:

```coffee
text = <%= helper.get_text %>
```

The assets might not get recompiled, even if they have to, as this gem only checks if the asset file has changed (which is probably the only safe/fast way to do this).

### `diff` and `cp` behaviour

Both `diff` and `cp` used by this gem expect certain behaviour and break if you use a tool that doesn't provide those behaviours. These have both been observed on
SmartOS, where `gdiff` and `gcp` provide the behaviour required, but the built in `diff` and `cp` don't.

If you're running into errors with diff, make sure you're using a diff binary that supports the `-Nqr` arguments. If not, you can point this gem at the correct diff binary  
to use on your nodes by setting the `:faster_assets_diff` variable in your deploy config:

    set :faster_assets_diff, :gdiff

`cp` on the other hand, expects `cp -r` to preserve symlinks. If your cp binary doesn't, then you can point at a binary that does by setting `:faster_assets_cp` in your
deploy config:

    set :faster_assets_cp, :gcp

### More Capistrano automation?

If you'd like to streamline your Capistrano deploys, you might want to check
these zero-configuration, plug-n-play plugins:

- [capistrano-unicorn-nginx](https://github.com/bruno-/capistrano-unicorn-nginx)<br/>
no-configuration unicorn and nginx setup with sensible defaults
- [capistrano-postgresql](https://github.com/bruno-/capistrano-postgresql)<br/>
plugin that automates postgresql configuration and setup
- [capistrano-rbenv-install](https://github.com/bruno-/capistrano-rbenv-install)<br/>
would you like Capistrano to install rubies for you?
- [capistrano-safe-deploy-to](https://github.com/bruno-/capistrano-safe-deploy-to)<br/>
if you're annoyed that Capistrano does **not** create a deployment path for the
app on the server (default `/var/www/myapp`), this is what you need!

### Bug reports and pull requests

...are very welcome!

### Thanks

[@athal7](https://github.com/athal7) - for the original idea and implementation. See https://coderwall.com/p/aridag
for more details
