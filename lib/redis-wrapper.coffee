
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
      unless not client or 'sadd' of client and 'smembers' of client
        throw new RedisWrapperError('Object does not looks like a redis client.')
      @client = client

    ensureClient: =>
      throw new RedisWrapperError('Redis client not set.') unless @client

  RedisWrapper.RedisWrapperError = RedisWrapperError
  return RedisWrapper

