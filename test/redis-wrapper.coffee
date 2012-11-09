
# test/redis-wrapper.coffee - Tests the redis-wrapper class
do ->

  expect = require('chai').expect

  # use a mock client in TEST env, otherwise throw a real one at it
  CLIENT = if process.env.NODE_ENV is 'test'
    { sadd: (->), smembers: (->) }
  else
    require('redis').createClient()


  describe 'RedisWrapper', ->
    before ->
      @klass = require('../')
      @instance = new @klass()
    after ->
      delete @klass
      delete @instance

    it 'should be exported', -> expect(@klass).to.be.a('function')

    describe 'client property', ->
      it 'should be exported', -> expect(@instance).to.have.property('client')
      it 'should initially be null', -> expect(@instance.client).to.be.null

    describe 'use() method', ->
      before ->
        @prev = @instance.client
        @use = @instance.use
      after ->
        @instance.client = @prev
        delete @use
        delete @prev

      it 'should be exported', -> expect(@use).to.be.a('function')

      it 'should sets the client property', ->
        @use CLIENT
        expect(@instance.client).to.eq(CLIENT)

      it "should throws when given something that doesn't looks like a redis client.", ->
        expect(=> @use { }).to.throw(@klass.RedisWrapperError)

    describe 'RedisWrapperError class', ->
      before -> @Error = @klass.RedisWrapperError
      after -> delete @Error

      it 'should be exported', -> expect(@Error).to.be.a('function')
      it 'should be instanceof Error', ->
        expect(new @Error()).to.be.instanceof(Error)

      it 'should saves message', ->
        expect(new @Error('msg')).to.have.property('message')
          .that.is.eq('msg')

      it 'should have a default message', ->
        expect(new @Error()).to.have.property('message')
          .that.is.not.empty

      it 'should captures stack trace', ->
        expect(new @Error('msg')).to.have.property('stack')
          .that.not.match(/_Class\.Error/i)

    describe 'ensureClient() method', ->
      before -> @ensure = @instance.ensureClient
      after -> delete @ensure

      it 'should be exported', -> expect(@ensure).to.be.a('function')

      it 'should throws if client not set', ->
        expect(=> @ensure()).to.throw(@klass.RedisWrapperError)

      it 'should *not* throws if client set', ->
        prev = @instance.client
        @instance.use CLIENT
        expect(=> @ensure()).to.not.throw()
        @instance.client = prev

