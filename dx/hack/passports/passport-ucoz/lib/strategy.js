/**
 * Module dependencies.
 */
var parse = require('./profile').parse
  , util = require('util')
  , XML = require('xtraverse')
  , OAuthStrategy = require('passport-oauth1')
  , InternalOAuthError = require('passport-oauth1').InternalOAuthError
  , APIError = require('./errors/apierror');


/**
 * `Strategy` constructor.
 *
 * The ucoz authentication strategy authenticates requests by delegating to
 * ucoz using the OAuth protocol.
 *
 * Applications must supply a `verify` callback which accepts a `token`,
 * `tokenSecret` and service-specific `profile`, and then calls the `done`
 * callback supplying a `user`, which should be set to `false` if the
 * credentials are not valid.  If an exception occured, `err` should be set.
 *
 * Options:
 *   - `consumerKey`     identifies client to ucoz
 *   - `consumerSecret`  secret used to establish ownership of the consumer key
 *   - `callbackURL`     URL to which ucoz will redirect the user after obtaining authorization
 *
 * Examples:
 *     var ucozStrategy = require('passport-ucoz').Strategy;
 *     passport.use(new ucozStrategy({
 *         consumerKey: '123-456-789',
 *         consumerSecret: 'shhh-its-a-secret'
 *         callbackURL: 'https://www.example.net/auth/ucoz/callback'
 *       },
 *       function(req, accessToken, tokenSecret, profile, done) {
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
  options.requestTokenURL = options.requestTokenURL || 'http://uapi.ucoz.com/account/OAuthGetRequestToken';
  options.accessTokenURL = options.accessTokenURL || 'http://uapi.ucoz.com/account/OAuthGetAccessToken';
  options.userAuthorizationURL = options.userAuthorizationURL || 'http://uapi.ucoz.com/account/OAuthAuthorizeToken';
  options.sessionKey = options.sessionKey || 'oauth:ucoz';
  
  OAuthStrategy.call(this, options, verify);
  this.name = 'ucoz';
  this._userProfileURL = options.userProfileURL || 'http://uapi.ucoz.com/accounts/GetUserInfo';
  this._skipExtendedUserProfile = (options.skipExtendedUserProfile !== undefined) ? options.skipExtendedUserProfile : false;
}

/**
 * Inherit from `OAuthStrategy`.
 */
util.inherits(Strategy, OAuthStrategy);


/**
 * Authenticate request by delegating to Twitter using OAuth.
 *
 * @param {Object} req
 * @api protected
 */
Strategy.prototype.authenticate = function(req, options) {
  // When a user denies authorization on Twitter, they are presented with a link
  // to return to the application in the following format (where xxx is the
  // value of the request token):
  //
  //     http://www.example.com/auth/ucoz/callback?denied=xxx
  //
  // Following the link back to the application is interpreted as an
  // authentication failure.
  if (req.query && req.query.denied) {
    return this.fail();
  }
  
  // Call the base class for standard OAuth authentication.
  OAuthStrategy.prototype.authenticate.call(this, req, options);
};

/**
 * Retrieve user profile from Twitter.
 *
 * This function constructs a normalized profile, with the following properties:
 *
 *   - `id`        (equivalent to `user_id`)
 *   - `username`  (equivalent to `screen_name`)
 *
 * Note that because Twitter supplies basic profile information in query
 * parameters when redirecting back to the application, loading of Twitter
 * profiles *does not* result in an additional HTTP request, when the
 * `skipExtendedUserProfile` is enabled.
 *
 * @param {String} token
 * @param {String} tokenSecret
 * @param {Object} params
 * @param {Function} done
 * @api protected
 */
Strategy.prototype.userProfile = function(token, tokenSecret, params, done) {
  if (!this._skipExtendedUserProfile) {
    var json;
    
    this._oauth.get(this._userProfileURL + '?user_id=' + params.user_id, token, tokenSecret, function (err, body, res) {
      if (err) {
        if (err.data) {
          try {
            json = JSON.parse(err.data);
          } catch (_) {}
        }
        
        if (json && json.errors && json.errors.length) {
          var e = json.errors[0];
          return done(new APIError(e.message, e.code));
        }
        return done(new InternalOAuthError('Failed to fetch user profile', err));
      }
      
      try {
        json = JSON.parse(body);
      } catch (ex) {
        return done(new Error('Failed to parse user profile'));
      }
      
      var profile = parse(json);
      profile.provider = 'ucoz';
      profile._raw = body;
      profile._json = json;
  
      done(null, profile);
    });
  } else {
    var profile = { provider: 'ucoz' };
    profile.id = params.user_id;
    profile.username = params.screen_name;

    done(null, profile);
  }
};

/**
 * Return extra ucoz-specific parameters to be included in the user
 * authorization request.
 *
 * @param {Object} options
 * @return {Object}
 * @api protected
 */
Strategy.prototype.userAuthorizationParams = function(options) {
  var params = {};
  if (options.forceLogin) {
    params.force_login = options.forceLogin;
  }
  if (options.screenName) {
    params.screen_name = options.screenName;
  }
  return params;
};

/**
 * Parse error response from ucoz OAuth endpoint.
 *
 * @param {String} body
 * @param {Number} status
 * @return {Error}
 * @api protected
 */
Strategy.prototype.parseErrorResponse = function(body, status) {
  var xml = XML(body)
    , msg = xml.children('error').t();
  return new Error(msg || body);
};


/**
 * Expose `Strategy`.
 */
module.exports = Strategy;
