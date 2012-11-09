
# lib/redis_wrapper.coffee - RedisWrapper class
module.exports = do ->

  class RedisWrapperError extends Error
    constructor: (msg) ->
      Error.call this, arguments
      Error.captureStackTrace this, arguments.callee
      @message = msg or 'Redis client not set, call use() first.'

  class RedisWrapper
    client: null
    use: (client) =>
      unless 'sadd' of client and 'hmset' of client
        throw new RedisWrapperError('Invalid redis client.')
      @client = client

    ensureClient: =>
      throw new RedisWrapperError('Redis client not set.') unless @client

  RedisWrapper.RedisWrapperError = RedisWrapperError
  return RedisWrapper
