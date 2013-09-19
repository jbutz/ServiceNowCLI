# Service-Now Script CLI

I created this application so that I could easily download the scripts from ServiceNow so they could be saved into a git repository. Currently it only works for business rules. Eventually I would like to have it work with all script types and be able to upload them as well.

## Setup

In ServiceNow you shouldn't have to make any changes. The application does use the XML Web Service, which I believe is enabled by default. On your computer you can choose to create a config file with some or all of your credentials if you with, but that is up to you.

### Installation

The application is packaged as a ruby gem. Just download the gem and install it like below:

```
gem install sncli-0.0.0.gem
```

### Config File

All configuration options in the config file are optional. For example you can specify everything but your password so that you only have to type in your password when running the application.

The config file needs to be created in your home directory and called `.sncli`. It should be in [YAML](https://en.wikipedia.org/wiki/YAML) format.

| Configuration Option    | Name in YAML | Explanation                                |
| --------------------    | ------------ | ------------------------------------------ |
| ServiceNow Instance URL | `sn_url`     | HTTPS base URL to your ServiceNow instance |
| ServiceNow Username     | `username`   | Username used to access ServiceNow         |
| ServiceNow Password     | `password`   | Password used to access ServiceNow         |

Below is an example:

```yaml
sn_url: https://demo.service-now.com
username: admin
password: admin
```

## Usage

### Business Rules

To download all of the buisness rules associated with a table use the command below. In the example we are downloading the business rules from `task`.

```
sncli br task
```

All of the business rules associated with that table will be downloaded. `.br.js` will be appended to the script's name to create the filename. A header similar to the one below will be added to the top of the file.

```js
/*!
 * Type: Business Rule
 * Name: Process SLAs
 * Created: 2009-10-05 23:01:00 by glide.maint
 * Updated: 2011-10-27 12:14:32 by james.grinter
 * Table: task
 * Order: 101
 * Client callable: false
 * Active: true
 * When: async
 * Insert: true
 * Update: true
 * Delete: false
 * Query: false
 * Run at: server
 * Condition: (gs.getProperty('com.snc.sla.engine.version','2010') == '2010')
 */
```
