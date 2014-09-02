Sailboat Data
===============

This is a fast, in-browser resource for sailboat data and information. The goal is to have a completely self-contained application that can be hosted on any static-file-only CDN. No database server, no script server. For data aggregation http://cape.io is being used.

## Editable Database

* https://github.com/webmasterkai/sailboat_data_db/

### Development

This is showing off a few things.

* Gulp
* Browser Sync
* Jade
* Less

#### Usage

When installing gulp globally you may need to use sudo. `sudo npm i gulp -g`

    git clone git@github.com:webmasterkai/sailboat_data.git
    cd client-dev-demo
    npm i
    npm i gulp -g
    gulp
