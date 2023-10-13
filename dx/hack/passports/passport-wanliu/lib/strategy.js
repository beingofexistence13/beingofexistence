/**
 * Module dependencies.
 */
var parse = require('./profile').parse
  , util = require('util')
  , OAuth2Strategy = require('passport-oauth2')
  , InternalOAuthError = require('passport-oauth2').InternalOAuthError
  , WanliuAuthorizationError = require('./errors/wanliuauthorizationerror')
  , WanliuTokenError = require('./errors/wanliutokenerror')
  , WanliuGraphAPIError = require('./errors/wanliugraphapierror');


/**
 * `Strategy` constructor.
 *
 * The Wanliu authentication strategy authenticates requests by delegating to
 * Wanliu using the OAuth 2.0 protocol.
 *
 * Applications must supply a `verify` callback which accepts an `accessToken`,
 * `refreshToken` and service-specific `profile`, and then calls the `done`
 * callback supplying a `user`, which should be set to `false` if the
 * credentials are not valid.  If an exception occured, `err` should be set.
 *
 * Options:
 *   - `clientID`      your Wanliu application's App ID
 *   - `clientSecret`  your Wanliu application's App Secret
 *   - `callbackURL`   URL to which Wanliu will redirect the user after granting authorization
 *
 * Examples:
 *
 *     passport.use(new WanliuStrategy({
 *         clientID: '123-456-789',
 *         clientSecret: 'shhh-its-a-secret'
 *         callbackURL: 'https://www.example.net/auth/wanliu/callback'
 *       },
 *       function(accessToken, refreshToken, profile, done) {
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
  var options = options || {},
    baseSite = options.baseSite || 'http://accounts.wanliu.biz/',
    authorizationURL = baseSite + (options.authorizationURL || 'auth/wanliu_id/authorize'),
    tokenURL = baseSite + (options.tokenURL || 'auth/wanliu_id/access_token'),
    profileURL = baseSite + (options.profileURL || '/auth/wanliu_id/user');

  options.baseSite = baseSite;
  options.authorizationURL = authorizationURL;
  options.tokenURL = tokenURL;
  options.scopeSeparator = options.scopeSeparator || ',';
  options.state = 'undefined' !== typeof options.state ? options.state : true;

  OAuth2Strategy.call(this, options, verify);
  this.name = 'wanliu';
  this._profileURL = profileURL;
  this._profileFields = options.profileFields || null;
  this._oauth2.setAccessTokenName("oauth_token");
}

/**
 * Inherit from `OAuth2Strategy`.
 */
util.inherits(Strategy, OAuth2Strategy);


/**
 * Authenticate request by delegating to Wanliu using OAuth 2.0.
 *
 * @param {Object} req
 * @api protected
 */
Strategy.prototype.authenticate = function(req, options) {
  // Wanliu doesn't conform to the OAuth 2.0 specification, with respect to
  // redirecting with error codes.
  //
  //   FIX: https://github.com/jaredhanson/passport-oauth/issues/16
  if (req.query && req.query.error_code && !req.query.error) {
    return this.error(new WanliuAuthorizationError(req.query.error_message, parseInt(req.query.error_code, 10)));
  }

  OAuth2Strategy.prototype.authenticate.call(this, req, options);
};

/**
 * Return extra Wanliu-specific parameters to be included in the authorization
 * request.
 *
 * Options:
 *  - `display`  Display mode to render dialog, { `page`, `popup`, `touch` }.
 *
 * @param {Object} options
 * @return {Object}
 * @api protected
 */
Strategy.prototype.authorizationParams = function (options) {
  var params = {};

  // https://developers.wanliu.com/docs/reference/dialogs/oauth/
  if (options.display) {
    params.display = options.display;
  }

  // https://developers.wanliu.com/docs/wanliu-login/reauthentication/
  if (options.authType) {
    params.auth_type = options.authType;
  }
  if (options.authNonce) {
    params.auth_nonce = options.authNonce;
  }

  return params;
};

/**
 * Retrieve user profile from Wanliu.
 *
 * This function constructs a normalized profile, with the following properties:
 *
 *   - `provider`         always set to `wanliu`
 *   - `id`               the user's Wanliu ID
 *   - `username`         the user's Wanliu username
 *   - `displayName`      the user's full name
 *   - `name.familyName`  the user's last name
 *   - `name.givenName`   the user's first name
 *   - `name.middleName`  the user's middle name
 *   - `gender`           the user's gender: `male` or `female`
 *   - `profileUrl`       the URL of the profile for the user on Wanliu
 *   - `emails`           the proxied or contact email address granted by the user
 *
 * @param {String} accessToken
 * @param {Function} done
 * @api protected
 */
Strategy.prototype.userProfile = function(accessToken, done) {
  var url = this._profileURL;
  if (this._profileFields) {
    var fields = this._convertProfileFields(this._profileFields);
    url += (fields !== '' ? '?fields=' + fields : '');
  }
  this._oauth2.get(url, accessToken, function (err, body, res) {
    if (err) {
      if (err.data) {
        try {
          var json = JSON.parse(err.data);
          if (json.error && typeof json.error == 'object') {
            return done(new WanliuGraphAPIError(json.error.message, json.error.type, json.error.code, json.error.error_subcode));
          }
        } catch (_) {}
      }
      return done(new InternalOAuthError('Failed to fetch user profile', err));
    }

    try {
      var json = JSON.parse(body);
      var profile = parse(json);
      profile.provider = 'wanliu';
      profile._raw = body;
      profile._json = json;

      done(null, profile);
    } catch (ex) {
      done(new Error('Failed to parse user profile'));
    }
  });
};

/**
 * Parse error response from Wanliu OAuth 2.0 token endpoint.
 *
 * @param {String} body
 * @param {Number} status
 * @return {Error}
 * @api protected
 */
Strategy.prototype.parseErrorResponse = function(body, status) {
  var json = JSON.parse(body);
  if (json.error && typeof json.error == 'object') {
    return new WanliuTokenError(json.error.message, json.error.type, json.error.code, json.error.error_subcode);
  }
  return OAuth2Strategy.prototype.parseErrorResponse.call(this, body, status);
};

Strategy.prototype._convertProfileFields = function(profileFields) {
  var map = {
    'id':          'id',
    'username':    'username',
    'displayName': 'name',
    'name':       ['last_name', 'first_name', 'middle_name'],
    'gender':      'gender',
    'profileUrl':  'link',
    'emails':      'email',
    'photos':      'picture'
  };

  var fields = [];

  profileFields.forEach(function(f) {
    if (typeof map[f] === 'undefined') { return; }

    if (Array.isArray(map[f])) {
      Array.prototype.push.apply(fields, map[f]);
    } else {
      fields.push(map[f]);
    }
  });

  return fields.join(',');
};

/**
 * Expose `Strategy`.
 */
module.exports = Strategy;