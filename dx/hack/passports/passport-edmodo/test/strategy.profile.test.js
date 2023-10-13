/* global describe, it, expect, before */
/* jshint expr: true */

var EdmodoStrategy = require('../lib/strategy');

describe('Strategy#userProfile', function() {

	var strategy =  new EdmodoStrategy({
			clientID: 'ABC123',
			clientSecret: 'secret'
		},
		function() {});

	// mock
	strategy._oauth2.get = function(url, accessToken, callback) {
		if (url != 'https://api.edmodo.com/users/me') { return callback(new Error('wrong url argument')); }
		if (accessToken != 'token') { return callback(new Error('wrong token argument')); }

		var body = '{ "username": "cstigler602", "id": 41423353, "first_name": "Charlie", "last_name": "Stigler", "email": "charlie@zaption.com", "type": "teacher" }';

		callback(null, body, undefined);
	};

	describe('loading profile', function() {
		var profile;

		before(function(done) {
			strategy.userProfile('token', function(err, p) {
				if (err) { return done(err); }
				profile = p;
				done();
			});
		});

		it('should parse profile', function() {
			expect(profile.provider).to.equal('edmodo');

			expect(profile.id).to.equal('41423353');
			expect(profile.username).to.equal('cstigler602');
			expect(profile.displayName).to.equal('Charlie Stigler');
			expect(profile.emails).to.have.length(1);
			expect(profile.emails[0].value).to.equal('charlie@zaption.com');
			expect(profile.role).to.equal('teacher');
		});

		it('should set raw property', function() {
			expect(profile._raw).to.be.a('string');
		});

		it('should set json property', function() {
			expect(profile._json).to.be.an('object');
		});
	});

	describe('encountering an error', function() {
		var err, profile;

		before(function(done) {
			strategy.userProfile('wrong-token', function(e, p) {
				err = e;
				profile = p;
				done();
			});
		});

		it('should error', function() {
			expect(err).to.be.an.instanceOf(Error);
			expect(err.constructor.name).to.equal('InternalOAuthError');
			expect(err.message).to.equal('Failed to fetch user profile');
		});

		it('should not load profile', function() {
			expect(profile).to.be.undefined;
		});
	});

});
