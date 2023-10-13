var chai = require('chai')
  , EvernoteStrategy = require('../lib/strategy');


describe('Strategy', function() {
  
  describe('constructed', function() {
    var strategy = new EvernoteStrategy({
      consumerKey: 'ABC123',
      consumerSecret: 'secret'
    }, function(){});
    
    it('should be named fitbit', function() {
      expect(strategy.name).to.equal('evernote');
    });
  })
  
  describe('constructed with undefined options', function() {
    it('should throw', function() {
      expect(function() {
        var strategy = new EvernoteStrategy(undefined, function(){});
      }).to.throw(Error);
    });
  })
  
  describe('error caused by invalid consumer secret sent to request token URL', function() {
    var strategy = new EvernoteStrategy({
      consumerKey: 'ABC123',
      consumerSecret: 'invalid-secret'
    }, function verify(){});
    
    strategy._oauth.getOAuthRequestToken = function(params, callback) {
      callback({ statusCode: 401, data: require('fs').readFileSync('./test/fixtures/errors/unexpected.html', 'utf8') });
    }
    
    
    var err;
  
    before(function(done) {
      chai.passport.use(strategy)
        .error(function(e) {
          err = e;
          done();
        })
        .req(function(req) {
          req.session = {};
        })
        .authenticate();
    });
  
    it('should error', function() {
      expect(err).to.be.an.instanceOf(Error);
      expect(err.constructor.name).to.equal('InternalOAuthError');
      expect(err.message).to.equal("Failed to obtain request token");
    });
  });
  
  describe('error caused by invalid request token sent to access token URL', function() {
    var strategy = new EvernoteStrategy({
      consumerKey: 'ABC123',
      consumerSecret: 'invalid-secret',
      callbackURL: 'http://www.example.test/callback'
    }, function verify(){});
    
    strategy._oauth.getOAuthAccessToken = function(token, tokenSecret, verifier, callback) {
      callback({ statusCode: 401, data: require('fs').readFileSync('./test/fixtures/errors/unexpected.html', 'utf8') });
    }
    
    
    var err;
  
    before(function(done) {
      chai.passport.use(strategy)
        .error(function(e) {
          err = e;
          done();
        })
        .req(function(req) {
          req.query = {};
          req.query['oauth_token'] = 'x-hh5s93j4hdidpola';
          req.query['oauth_verifier'] = 'hfdp7dh39dks9884';
          req.session = {};
          req.session['oauth:evernote'] = {};
          req.session['oauth:evernote']['oauth_token'] = 'x-hh5s93j4hdidpola';
          req.session['oauth:evernote']['oauth_token_secret'] = 'hdhd0244k9j7ao03';
        })
        .authenticate();
    });
  
    it('should error', function() {
      expect(err).to.be.an.instanceOf(Error);
      expect(err.constructor.name).to.equal('InternalOAuthError');
      expect(err.message).to.equal("Failed to obtain access token");
    });
  });
  
});
