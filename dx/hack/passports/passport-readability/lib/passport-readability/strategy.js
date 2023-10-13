/**
 * Module dependencies.
 */
var util = require('util')
  , OAuthStrategy = require('passport-oauth').OAuthStrategy
  , InternalOAuthError = require('passport-oauth').InternalOAuthError;


/**
 * `Strategy` constructor.
 *
 * The Readability authentication strategy authenticates requests by delegating
 * to Readability using the OAuth protocol.
 *
 * Applications must supply a `verify` callback which accepts a `token`,
 * `tokenSecret` and service-specific `profile`, and then calls the `done`
 * callback supplying a `user`, which should be set to `false` if the
 * credentials are not valid.  If an exception occured, `err` should be set.
 *
 * Options:
 *   - `consumerKey`     identifies client to Readability
 *   - `consumerSecret`  secret used to establish ownership of the consumer key
 *   - `callbackURL`     URL to which Readability will redirect the user after obtaining authorization
 *
 * Examples:
 *
 *     passport.use(new ReadabilityStrategy({
 *         consumerKey: '123-456-789',
 *         consumerSecret: 'shhh-its-a-secret'
 *         callbackURL: 'https://www.example.net/auth/readability/callback'
 *       },
 *       function(token, tokenSecret, profile, done) {
 *         User.findOrCreate(..., function (err, user) {
 *           done(err, user);
 *         });
 *       }
 *     ));
 *
 * @param {Object} options
 * @param {Function} verify
 * @api public
 */
function Strategy(options, verify) {
  options = options || {};
  options.requestTokenURL = options.requestTokenURL || 'https://www.readability.com/api/rest/v1/oauth/request_token/';
  options.accessTokenURL = options.accessTokenURL || 'https://www.readability.com/api/rest/v1/oauth/access_token/';
  options.userAuthorizationURL = options.userAuthorizationURL || 'https://www.readability.com/api/rest/v1/oauth/authorize/';
  options.sessionKey = options.sessionKey || 'oauth:readability';

  OAuthStrategy.call(this, options, verify);
  this.name = 'readability';
}

/**
 * Inherit from `OAuthStrategy`.
 */
util.inherits(Strategy, OAuthStrategy);

/**
 * Authenticate request by delegating to Readability using OAuth.
 *
 * @param {Object} req
 * @api protected
 */
Strategy.prototype.authenticate = function(req) {
  // When a user denies authorization on Readability, they are presented with a
  // link to return to the application in the following format:
  //
  //     http://www.example.com/auth/readability/callback?error=Access%20not%20granted%20by%20user.
  //
  // Following the link back to the application is interpreted as an
  // authentication failure.
  if (req.query && req.query.error) {
    return this.fail();
  }
  
  // Call the base class for standard OAuth authentication.
  OAuthStrategy.prototype.authenticate.call(this, req);
}

/**
 * Retrieve user profile from Readability.
 *
 * This function constructs a normalized profile, with the following properties:
 *
 *   - `username`
 *   - `displayName`
 *   - `name.familyName`
 *   - `name.givenName`
 *
 * @param {String} token
 * @param {String} tokenSecret
 * @param {Object} params
 * @param {Function} done
 * @api protected
 */
Strategy.prototype.userProfile = function(token, tokenSecret, params, done) {
  this._oauth.get('https://www.readability.com/api/rest/v1/users/_current', token, tokenSecret, function (err, body, res) {
    if (err) { return done(new InternalOAuthError('failed to fetch user profile', err)); }
    
    try {
      var json = JSON.parse(body);
      
      var profile = { provider: 'readability' };
      profile.username = json.username;
      profile.displayName = json.first_name + ' ' + json.last_name;
      profile.name = { familyName: json.last_name,
                       givenName: json.first_name };
                       
      profile._raw = body;
      profile._json = json;
      
      done(null, profile);
    } catch(e) {
      done(e);
    }
  });
}


/**
 * Expose `Strategy`.
 */
module.exports = Strategy;
