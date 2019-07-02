Helper = require('hubot-test-helper')
helper = new Helper('../src/dogme.coffee')
co     = require('co')
expect = require('chai').expect

describe 'hubot-dogme', ->

  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  context 'user says dog me to hubot', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', '@hubot dog me'
        yield new Promise((resolve, reject) ->
            setTimeout(resolve, 1900);
        )

    it 'should contain a url', ->
      expect(@room.messages[1][1]).to.contain('https://')

  context 'user says labradore dog me to hubot', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', '@hubot labrador dog me'
        yield new Promise((resolve, reject) ->
            setTimeout(resolve, 1900);
        )

    it 'should reply to user with a labrador', ->
        expect(@room.messages[1][1]).to.contain('labrador')


  context 'user says dog bomb to hubot', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', '@hubot dog bomb 2 - Many Doges. Such exploshun'
        yield new Promise((resolve, reject) ->
            setTimeout(resolve, 1900);
        )

    it 'should reply with 3', ->
        expect(@room.messages.length).to.equal(2 + 1)

  context 'user says labradore dog bomb 3 to hubot', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', '@hubot labrador dog bomb 3'
        yield new Promise((resolve, reject) ->
            setTimeout(resolve, 1950);
        )

    it 'should reply with 3 labradors', ->
        expect(@room.messages[3][1]).to.contain('labrador')
        expect(@room.messages[2][1]).to.contain('labrador')
        expect(@room.messages[1][1]).to.contain('labrador')

  context 'user ask what breeds to hubot', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', '@hubot what dog breeds'
        yield new Promise((resolve, reject) ->
            setTimeout(resolve, 1900);
        )

    it 'should reply more than 2 breeds', ->
        expect(@room.messages[1][1].split(",").length).to.be.above(2)