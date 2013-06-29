should = require 'should'
async = require 'async'

BlogRequest = require '../lib/index'


describe 'BlogRequest', ->
  describe '.request(...)', ->

    describe 'naver blog', ->
      describe 'naver domain', ->
        it 'should be done', (done) ->
          url = 'http://blog.naver.com/rikish/60194709439'

          BlogRequest.request url, (err, response, body) ->
            should.not.exist err
            should.exist response
            response.blogType.should.equal 'naver'
            should.exist body
            done()

      describe 'own domain', ->
        it 'should be done', (done) ->
          url = 'http://hcr333.blog.me/120193039757'

          BlogRequest.request url, (err, response, body) ->
            should.not.exist err
            should.exist response
            response.blogType.should.equal 'naver'
            should.exist body
            done()


    describe 'daum blog', ->
      it 'should be done', (done) ->
        url = 'http://blog.daum.net/happymeals/404'

        BlogRequest.request url, (err, response, body) ->
          should.not.exist err
          should.exist response
          response.blogType.should.equal 'daum'
          should.exist body
          done()


    describe 'unknown', ->
      it 'should be done', (done) ->
        url = 'http://indigotale.tistory.com/68'

        BlogRequest.request url, (err, response, body) ->
          should.not.exist err
          should.exist response
          response.blogType.should.equal 'unknown'
          should.exist body
          done()
