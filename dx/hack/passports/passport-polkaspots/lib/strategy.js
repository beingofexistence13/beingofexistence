/**
 * Module dependencies.
 */
var uri = require('url')
  , crypto = require('crypto')
  , util = require('util')
  , OAuth2Strategy = require('passport-oauth2')
  , Profile = require('./profile')
  , InternalOAuthError = require('passport-oauth2').InternalOAuthError
  , FacebookAuthorizationError = require('./errors/facebookauthorizationerror')
  , FacebookTokenError = require('./errors/facebooktokenerror')
  , FacebookGraphAPIError = require('./errors/facebookgraphapierror');


/**
 * `Strategy` constructor.
 *
 * The Facebook authentication strategy authenticates requests by delegating to
 * Facebook using the OAuth 2.0 protocol.
 *
 * Applications must supply a `verify` callback which accepts an `accessToken`,
 * `refreshToken` and service-specific `profile`, and then calls the `done`
 * callback supplying a `user`, which should be set to `false` if the
 * credentials are not valid.  If an exception occured, `err` should be set.
 *
 * Options:
 *   - `clientID`      your Facebook application's App ID
 *   - `clientSecret`  your Facebook application's App Secret
 *   - `callbackURL`   URL to which Facebook will redirect the user after granting authorization
 *
 * Examples:
 *
 *     passport.use(new FacebookStrategy({
 *         clientID: '123-456-789',
 *         clientSecret: 'shhh-its-a-secret'
 *         callbackURL: 'https://www.example.net/auth/facebook/callback'
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
  options = options || {};
  options.authorizationURL = options.authorizationURL || 'https://auth.polkaspots.com/oauth/authorize';
  options.tokenURL = options.tokenURL || 'https://auth.polkaspots.com/oauth/token';
  options.scopeSeparator = options.scopeSeparator || ',';

  OAuth2Strategy.call(this, options, verify);
  this.name = 'polkaspots';
  this._clientSecret = options.clientSecret;
  this._enableProof = options.enableProof;
  this._profileURL = options.profileURL || 'https://api.polkaspots.com/api/v1/me.json';
  this._profileFields = options.profileFields || null;
}

/**
 * Inherit from `OAuth2Strategy`.
 */
util.inherits(Strategy, OAuth2Strategy);


/**
 * Authenticate request by delegating to Facebook using OAuth 2.0.
 *
 * @param {Object} req
 * @api protected
 */
Strategy.prototype.authenticate = function(req, options) {

  if (req.query && req.query.error_code && !req.query.error) {
    return this.error(new FacebookAuthorizationError(req.query.error_message, parseInt(req.query.error_code, 10)));
  }

  OAuth2Strategy.prototype.authenticate.call(this, req, options);
};

/**
 * Return extra Facebook-specific parameters to be included in the authorization
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

  // https://developers.facebook.com/docs/reference/dialogs/oauth/
  if (options.display) {
    params.display = options.display;
  }

  // https://developers.facebook.com/docs/facebook-login/reauthentication/
  if (options.authType) {
    params.auth_type = options.authType;
  }
  if (options.brand) {
    params.brand = options.brand;
  }
  if (options.authNonce) {
    params.auth_nonce = options.authNonce;
  }

  return params;
};

/**
 * Retrieve user profile from Facebook.
 *
 * This function constructs a normalized profile, with the following properties:
 *
 *   - `provider`         always set to `facebook`
 *   - `id`               the user's Facebook ID
 *   - `username`         the user's Facebook username
 *   - `displayName`      the user's full name
 *   - `name.familyName`  the user's last name
 *   - `name.givenName`   the user's first name
 *   - `name.middleName`  the user's middle name
 *   - `gender`           the user's gender: `male` or `female`
 *   - `profileUrl`       the URL of the profile for the user on Facebook
 *   - `emails`           the proxied or contact email address granted by the user
 *
 * @param {String} accessToken
 * @param {Function} done
 * @api protected
 */
Strategy.prototype.userProfile = function(accessToken, done) {
  var url = uri.parse(this._profileURL);
  if (this._enableProof) {
    // Secure API call by adding proof of the app secret.  This is required when
    // the "Require AppSecret Proof for Server API calls" setting has been
    // enabled.  The proof is a SHA256 hash of the access token, using the app
    // secret as the key.
    //
    // For further details, refer to:
    // https://developers.facebook.com/docs/reference/api/securing-graph-api/
    var proof = crypto.createHmac('sha256', this._clientSecret).update(accessToken).digest('hex');
    url.search = (url.search ? url.search + '&' : '') + 'appsecret_proof=' + encodeURIComponent(proof);
  }
  if (this._profileFields) {
    var fields = this._convertProfileFields(this._profileFields);
    if (fields !== '') { url.search = (url.search ? url.search + '&' : '') + 'fields=' + fields; }
  }
  url = uri.format(url);

  this._oauth2.get(url, accessToken, function (err, body, res) {
    var json;

    if (err) {
      if (err.data) {
        try {
          json = JSON.parse(err.data);
        } catch (_) {}
      }

      if (json && json.error && typeof json.error == 'object') {
        return done(new FacebookGraphAPIError(json.error.message, json.error.type, json.error.code, json.error.error_subcode));
      }
      return done(new InternalOAuthError('Failed to fetch user profile', err));
    }

    try {
      json = JSON.parse(body);
    } catch (ex) {
      return done(new Error('Failed to parse user profile'));
    }

    var profile = Profile.parse(json);
    profile.provider = 'polkaspots';
    profile._raw = body;
    profile._json = json;

    done(null, profile);
  });
};

/**
 * Parse error response from Facebook OAuth 2.0 token endpoint.
 *
 * @param {String} body
 * @param {Number} status
 * @return {Error}
 * @api protected
 */
Strategy.prototype.parseErrorResponse = function(body, status) {
  var json = JSON.parse(body);
  console.log(json)
  if (json.error && typeof json.error == 'object') {
    return new FacebookTokenError(json.error.message, json.error.type, json.error.code, json.error.error_subcode);
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
    'birthday':    'birthday',
    'profileUrl':  'link',
    'emails':      'email',
    'photos':      'picture'
  };

  var fields = [];

  profileFields.forEach(function(f) {
    // return raw Facebook profile field to support the many fields that don't
    // map cleanly to Portable Contacts
    if (typeof map[f] === 'undefined') { return fields.push(f); };

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
