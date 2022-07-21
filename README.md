This is a copy of the [latest Postfacto
release](https://github.com/pivotal/postfacto/releases) with the following
changes applied:

-   Set the Ruby version in the `Gemfile` to `2.7.6`.
-   Add the [`activerecord-nulldb-adapter`](https://github.com/nulldb/nulldb)
    dependency and use it for the `production` database configuration.
-   Default the `secret_key_base` secret for `production` when the corresponding
    environment variable is not set.

These changes are enough to build Postfacto with Kpack, which currently is [not
passing environment variables to the build
step](https://github.com/pivotal/kpack/issues/995), preventing us from passing
the `DATABASE_URL` and `SECRET_KEY_BASE` environment variables which would
allow us to build vanilla Postfacto.
