# BlogRequest

This class provides a feature to get a proper html from popular blogs using redirection or frameset.

Currently supports:

  * [Naver Blog](http://blog.naver.com)
  * [Daum Blog](http://blog.daum.net)


## Dependencies

It mainly requires:

 * to get and parse html
  * [request](https://npmjs.org/package/request)
  * [cheerio](https://npmjs.org/package/cheerio)
 * to detect and convert charsets
  * [node-icu-charset-detector](https://npmjs.org/package/node-icu-charset-detector)
  * [iconv](https://npmjs.org/package/iconv)

So I guess it'll be difficult to use this on Windows environment.

    request = require 'request'
    cheerio = require 'cheerio'

    charsetDetector = require 'node-icu-charset-detector'
    Buffer = require('buffer').Buffer
    Iconv = require('iconv').Iconv

    matchers = require './matchers'


### Class

    class BlogRequest


Just `startsWith(str)` helper function.

    String.prototype.startsWith = (str) ->
      str is @.substr 0, str.length


Convert a buffer to an utf8 string from any character set automatically.
Refer to [node-icu-charset-detector](https://github.com/mooz/node-icu-charset-detector) 
and [node-iconv](https://github.com/bnoordhuis/node-iconv).

    convertToUtf8StringFromBuffer = (buffer) ->
      try
        detectedCharset = charsetDetector.detectCharset(buffer).toString()
        iconv = new Iconv detectedCharset, 'utf-8'
        convertedBuffer = iconv.convert buffer
        convertedBuffer.toString()
      catch err

Sometimes Korean 'CP949' charset is detected to 'EUC-KR' and it fails to convert.
So we should correct this.

        if err.code is 'EILSEQ' and detectedCharset is 'EUC-KR'
            iconv = new Iconv 'cp949', 'utf-8'
            convertedBuffer = iconv.convert buffer
            return convertedBuffer.toString()
        else
          throw err


The basic usage of `BlogRequest.request` is very similar to [request](https://github.com/mikeal/request).
But, it always returns an utf8 encoded string.

    BlogRequest.request = (options, callback) ->
      if typeof options is 'string'
        options =
          url: options

      options.encoding = null

      request options, (err, response, bodyBuffer) ->
        return callback err  if err?

        if response.headers['content-type']?.indexOf('html') < 0
          return callback new Error 'this url is not a html'

        try
          body = convertToUtf8StringFromBuffer bodyBuffer
        catch err
          return callback err

        $ = cheerio.load body

Try to detect a blog type and an original url using matchers.
Even if it failed to find a proper blog type then returns `'unknown'` as its type.

        for matcher in matchers
          blogInfo = matcher $

          if blogInfo?
            if blogInfo.type is 'unknown'
              response.blogType = blogInfo.type
              return callback null, response, body

            options.url = blogInfo.url

Re-requests if it needed.

            request options, (err, response, bodyBuffer) ->
              return callback err  if err?

              try
                body = convertToUtf8StringFromBuffer bodyBuffer
              catch err
                return callback err

              response.blogType = blogInfo.type
              callback null, response, body

            break



### Public

    module.exports = BlogRequest
