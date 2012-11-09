
# REDIS-WRAPPER

Because I wrote this too many times already, I decided to just move it into a small module of its own.

### SETUP CLASS

Javascript:

```javascript
function MyRedisClass() { }
MyRedisClass.prototype = new require('redis-wrapper')()

// or mix into a singleton object with underscore
MySingleton = { func: function() { } };
MySingleton = _.extend(MySingleton, new require('redis-wrapper')());
```

Coffeescript:

```coffeescript
class YourClass extends require('redis-wrapper')
```

### USAGE

Setup your classes with `use()`

```javascript
MyClass.prototype = new require('redis-wrapper')();

var instance = new MyClass()
  , client = require('redis').createClient();

instance.use(client);
```

Adds `ensureClient()` before redis-related methods to ensure a client is set.

```javascript
MyClass.prototype.someMethod = function() {
  this.ensureClient();

  // do things with this.client
};
```

That's all.

### TODO

* Adds ability to use a url (via `redis-url`) or host/port combination.

### LICENSE

BSD

