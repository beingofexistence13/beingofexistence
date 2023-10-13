/* global describe, it, expect, before */
/* jshint expr: true */

var fs    = require('fs'),
    parse = require('../lib/profile').parse;

describe('profile.parse', function () {
    
    describe('example profile', function () {
        var profile;

        before(function (done) {
            fs.readFile('test/data/example.json', 'utf8', function (err, data) {
                if (err) {
                    return done(err);
                }
                profile = parse(data);
                done();
            });
        });

        it('should parse profile', function () {
            expect(profile.id).to.equal('1');
            expect(profile.username).to.equal('user@base.com');
            expect(profile.displayName).to.equal('BaseUser');
            expect(profile.profileUrl).to.equal('https://app.futuresimple.com/settings/profile');
            expect(profile.emails).to.have.length(1);
            expect(profile.emails[0].value).to.equal('user@base.com');
        });
    });

    describe('example profile with null email', function () {
        var profile;

        before(function (done) {
            fs.readFile('test/data/example-null-email.json', 'utf8', function (err, data) {
                if (err) {
                    return done(err);
                }
                profile = parse(data);
                done();
            });
        });

        it('should parse profile', function () {
            expect(profile.id).to.equal('1');
            expect(profile.username).to.be.null;
            expect(profile.displayName).to.equal('BaseUser');
            expect(profile.profileUrl).to.equal('https://app.futuresimple.com/settings/profile');
            expect(profile.emails).to.be.undefined;
        });
    });
});
