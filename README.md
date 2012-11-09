
# REDIS-WRAPPER

Because I wrote this too many times already, I decided to just move it into a small module of its own.

### SETUP CLASS

Javascript:

    function MyRedisClass() { }
    MyRedisClass.prototype = new require('redis-wrapper')()

    // or mix into a singleton object with underscore
    MySingleton = { func: function() { } };
    MySingleton = _.extend(MySingleton, new require('redis-wrapper')());

Coffeescript:

    class YourClass extends require('redis-wrapper')

### USAGE

Setup your classes with `use()`

    MyClass.prototype = new require('redis-wrapper')();

    var instance = new MyClass()
      , client = require('redis').createClient();

    instance.use(client);

Adds `ensureClient()` before redis-related methods to ensure a client is set.

    MyClass.prototype.someMethod = function() {
      this.ensureClient();

      // do things with this.client
    };

That's all.

### TODO

* Adds ability to use a url (via `redis-url`) or host/port combination.

### LICENSE

BSD

