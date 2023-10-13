var express = require('express')
var passport = require('passport')
var util = require('util')
var TradierStrategy = require('../lib/strategy');

var TRADIER_APP_ID = "<TRADIER_CONSUMER_KEY>"
var TRADIER_APP_SECRET = "<TRADIER_CONSUMER_SECRET>";


// Passport session setup.
//   To support persistent login sessions, Passport needs to be able to
//   serialize users into and deserialize users out of the session.  Typically,
//   this will be as simple as storing the user ID when serializing, and finding
//   the user by ID when deserializing.  However, since this example does not
//   have a database of user records, the complete Tradier profile is serialized
//   and deserialized.
passport.serializeUser(function(user, done) {
  done(null, user);
});

passport.deserializeUser(function(obj, done) {
  done(null, obj);
});


// Use the TradierStrategy within Passport.
//   Strategies in Passport require a `verify` function, which accept
//   credentials (in this case, an accessToken, refreshToken, and Tradier
//   profile), and invoke a callback with a user object.
passport.use(new TradierStrategy({
    clientID: TRADIER_APP_ID,
    clientSecret: TRADIER_APP_SECRET,
    callbackURL: "http://localhost:3000/auth/tradier/callback",
    scope: "read,write,trade,market,stream"
  },
  function(accessToken, refreshToken, profile, done) {
    // asynchronous verification, for effect...
    process.nextTick(function () {

      // To keep the example simple, the user's Tradier profile is returned to
      // represent the logged-in user.  In a typical application, you would want
      // to associate the Tradier account with a user record in your database,
      // and return that user instead.
      return done(null, profile);
    });
  }
));




var app = express();

// configure Express
app.configure(function() {
  app.set('views', __dirname + '/views');
  app.set('view engine', 'ejs');
  app.use(express.logger());
  app.use(express.cookieParser());
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.session({ secret: 'peterman' }));
  // Initialize Passport!  Also use passport.session() middleware, to support
  // persistent login sessions (recommended).
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.locals.inspect = require('util').inspect;


app.get('/', function(req, res){
  res.render('index', { user: req.user });
});

app.get('/account', ensureAuthenticated, function(req, res){
  res.render('account', { user: req.user });
});

app.get('/login', function(req, res){
  res.render('login', { user: req.user });
});

// GET /auth/tradier
//   Use passport.authenticate() as route middleware to authenticate the
//   request.  The first step in Tradier authentication will involve
//   redirecting the user to brokerage.tradier.com.  After authorization, Tradier will
//   redirect the user back to this application at /auth/tradier/callback
app.get('/auth/tradier',
  passport.authenticate('tradier'),
  function(req, res){
    // The request will be redirected to Tradier for authentication, so this
    // function will not be called.
  });

// GET /auth/tradier/callback
//   Use passport.authenticate() as route middleware to authenticate the
//   request.  If authentication fails, the user will be redirected back to the
//   login page.  Otherwise, the primary route function function will be called,
//   which, in this example, will redirect the user to the home page.
app.get('/auth/tradier/callback',
  passport.authenticate('tradier', { failureRedirect: '/login' }),
  function(req, res) {
    res.redirect('/');
  });

app.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

app.listen(3000);


// Simple route middleware to ensure user is authenticated.
//   Use this route middleware on any resource that needs to be protected.  If
//   the request is authenticated (typically via a persistent login session),
//   the request will proceed.  Otherwise, the user will be redirected to the
//   login page.
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/login')
}
