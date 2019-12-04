*was deployed to Heroku, inactive as of 2019*

# BUNDLE POSTING
### to Twitter, LinkedIn, Facebook and Salesforce

**Preview:** deployed at https://arcane-earth-9950.herokuapp.com.

**Key feature:** has no relation to any User and/or app authentication models and behaves independtely thereof.

**Status:** Prototype. I will eventually make a gem out of it.


## INTEGRATION OVERVIEW

I realize it's not very "integrateable" as it stands now. At the very least, it illustrates how to efficiently and cleanly coordinate batch posting without interfering with any of existing authentication and/or users. Steps necessary in addition to copying all the files:

1. Set up network applications.
2. Add `identities` table.
3. Add gems to the gemfile.
4. Add OmniAuth mocking to `spec_helper.rb`.
5. Add OmniAuth initializer.


## GENERAL


A cornerstone principle of this app is that it is completely decoupled from the notion of User. It does not even has such model. In practical terms, it means that this app has no knowledge of whether and who is logged in into the parent app. As long as a person is able to log into a social network with his/her usual credential, he/she will be able to post on that network. If the user happens to be logged in the network in the same browser, then this app will simply turn it on, showing user's avatar and network name. Otherwise, the app will redirect the user to network sign-in page.



## 1. SET UP NETWORK-SPECIFIC APPS

In every network you plan to integrate with, you'll need to create an app. Just follow platform's instructions for setting up an app. It's a straightforward and well-documented process. Several things not to miss:


#### Redirect URLs
Make sure to have the following URLs in OAuth redirect/callback setting:

- http://localhost:3000/
- http://www.example.com/ (optional - if you decide to hit live APIs from your test suite at some point)
- URL of your deployed app.

  
#### App permissions

Make sure to give read and write permissions to your app:
-  in Facebook: `Client OAuth Login`, 
-  in Twitter
  -  `Allow this application to be used to Sign in with Twitter` (Settings tab)
  -  `Access - Read and Write` (Permissions tab)
- in LinkedIn: `OAuth User Agreement` - check `rw_nus`, `w_share`, `r_basicprofile`
- in Salesforce: `OAuth Scopes`:
  - "Access your basic information (id, profile, email, address, phone)"
  - "Access and manage your Chatter data (chatter_api)" 


#### App keys

Upon app setup, you will need keys from every app. They go by different name, as follows:
- Facebook (Basic tab) - `App ID` and `App Secret`
- Twitter (Keys and Access Tokens tab) - `Consumer Key (API Key)` and `Consumer Secret (API Secret)`
- LinkedIn - `Consumer Key / API Key` and `Consumer Secret / Secret Key`
- Salesforce - `Consumer Key` and `Consumer Secret`


#### Setting up keys in environment variables

The app uses environment variables to access the keys. It's up to you to choose the best way to add the keys to your environment, as long as their names are as follows:

``` 
TWITTER_KEY: "XXXXXXXXXXX"
TWITTER_SECRET: "XXXXXXXXXXX"

FACEBOOK_KEY: "XXXXXXXXXXX"
FACEBOOK_SECRET: "XXXXXXXXXXX"

SALESFORCE_KEY: "XXXXXXXXXXX"
SALESFORCE_SECRET: "XXXXXXXXXXX"

LINKEDIN_KEY: "XXXXXXXXXXX"
LINKEDIN_SECRET: "XXXXXXXXXXX"
```


For each of the providers above, `key` is the first string from "App keys" section, and `secret` is the second.


#### Using Figaro to store keys (optional)
 
I found usnig Figaro gem a hassle-free way to handle this. All you'll have to do is copy the keys into `config/application.yml` file (in the same format as above, with colons and quotes, but maybe hyphens will do instead of colons) and then make sure you have this:

```
# Ignore application configuration
/config/application.yml
```
in your `.gitignore` file.

One last thing, if you decide to use Figaro, after deployment make sure to run `$ figaro heroku:set -e production` to push the keys to Heroku.



## 2. ADD IDENTITY TABLE

To use `Identity` model, you'll need to create `identities` table with the following schema:

```ruby
  create_table "identities", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "screen_name"
    t.string   "image_url"
    t.string   "url"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "refresh_token"
    t.string   "instance_url"
  end
```


## 3. ADD GEMS

All gems in the gemfile below line 16 were added specifically for this app and you'll need to have them installed for it to work.


## 4. ADD OMNIAUTH TO `spec_helper.rb`
Make sure your `spec_helper.rb` has the following:

```
OmniAuth.config.test_mode = true
...
Spec.configure do |config|
...
  config.include(OmniauthMacros)
...
end
```

## 5. ADD OMNIAUTH INITIALIZER

Create `omniauth.rb` file in your `config/initializers` folder as follows:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"]
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"], {:scope => 'publish_actions', :image_size => 'square'}
  provider :salesforce, ENV["SALESFORCE_KEY"], ENV["SALESFORCE_SECRET"]
  provider :linkedin, ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"], {:scope => 'r_basicprofile w_share rw_nus'}
end
```

### Credits
Thanks to Stan Carver from <a href="http://www.mercuryflight.com/">Mercury Flight</a> for patience and support.
