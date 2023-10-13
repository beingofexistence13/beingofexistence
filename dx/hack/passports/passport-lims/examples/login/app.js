var express = require('express')
  , passport = require('passport')
  , util = require('util')
  , LimsStrategy = require('../../').Strategy
  , logger = require('morgan')
  , session = require('express-session')
  , bodyParser = require("body-parser")
  , cookieParser = require("cookie-parser")
  , methodOverride = require('method-override');


var options = {
  clientID: 100,
  clientSecret: 'secret',
  authorizationURL: 'http://localhost:8000/oauth/authorize',
  tokenURL: 'http://localhost:8000/oauth/token',
  userProfileURL: 'http://localhost:8000/auth/user',
  callbackURL: "http://localhost:3001/auth/lims/callback"
};


// Passport session setup.
//   To support persistent login sessions, Passport needs to be able to
//   serialize users into and deserialize users out of the session.  Typically,
//   this will be as simple as storing the user ID when serializing, and finding
//   the user by ID when deserializing.  However, since this example does not
//   have a database of user records, the complete Lims profile is serialized
//   and deserialized.
passport.serializeUser(function (user, done) {
  done(null, user);
});

passport.deserializeUser(function (obj, done) {
  done(null, obj);
});

// Use the LimsStrategy within Passport.
//   Strategies in Passport require a `verify` function, which accept
//   credentials (in this case, an accessToken, refreshToken, and Lims
//   profile), and invoke a callback with a user object.
passport.use(new LimsStrategy(options,
  function (accessToken, refreshToken, profile, done) {
    // asynchronous verification, for effect...
    process.nextTick(function () {

      // To keep the example simple, the user's Lims profile is returned to
      // represent the logged-in user.  In a typical application, you would want
      // to associate the Lims account with a user record in your database,
      // and return that user instead.
      return done(null, profile);
    });
  }
));


var app = express();

// configure Express
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(logger('combined'));
app.use(cookieParser());
app.use(bodyParser.json());
app.use(methodOverride());
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true
}));
// Initialize Passport!  Also use passport.session() middleware, to support
// persistent login sessions (recommended).
app.use(passport.initialize());
app.use(passport.session());
app.use(express.static(__dirname + '/public'));


app.get('/', function (req, res) {
  res.render('index', {user: req.user, detail: JSON.stringify(req.user, null, '  ')});
});

app.get('/account', ensureAuthenticated, function (req, res) {
  res.render('account', {user: req.user});
});

app.get('/login', function (req, res) {
  res.render('login', {user: req.user});
});

// GET /auth/lims
//   Use passport.authenticate() as route middleware to authenticate the
//   request.  The first step in Lims authentication will involve
//   redirecting the user to lims.com.  After authorization, Lims will
//   redirect the user back to this application at /auth/lims/callback
app.get('/auth/lims',
  passport.authenticate('lims'),
  function (req, res) {
    // The request will be redirected to Lims for authentication, so this
    // function will not be called.
  });

// GET /auth/lims/callback
//   Use passport.authenticate() as route middleware to authenticate the
//   request.  If authentication fails, the user will be redirected back to the
//   login page.  Otherwise, the primary route function function will be called,
//   which, in this example, will redirect the user to the home page.
app.get('/auth/lims/callback',
  passport.authenticate('lims', {failureRedirect: '/login'}),
  function (req, res) {
    res.redirect('/');
  });

app.get('/logout', function (req, res) {
  req.logout();
  res.redirect('/');
});

var server = app.listen(3001, function () {
  var host = server.address().address;
  var port = server.address().port;

  if (host[0] === ':') {
    host = 'localhost';
  }

  console.log('Passport-Lims strategy example app listening at http://%s:%s', host, port);
});


// Simple route middleware to ensure user is authenticated.
//   Use this route middleware on any resource that needs to be protected.  If
//   the request is authenticated (typically via a persistent login session),
//   the request will proceed.  Otherwise, the user will be redirected to the
//   login page.
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/login')
}
