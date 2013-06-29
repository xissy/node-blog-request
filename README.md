# node-blog-request

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


## Installation

Via [npm](https://npmjs.org):

    $ npm install blog-request


## Usage

The basic usage of `BlogRequest.request` is very similar to [request](https://github.com/mikeal/request).
But, it always returns an utf8 encoded string.

### Load in the module
```javascript
  var BlogRequest = require('blog-request');
```

### Detect a blog type and get its body
  
  * blogType (detected blog type)
    * 'naver'
    * 'daum'
    * 'unknown'
  * blogProperUrl (detected proper url)
  * body (re-requested html string)

```javascript
  var url = 'http://blog.naver.com/rikish/60194709439'; // a blog page url

  BlogRequest.request(url, function(err, response, body) {
    var blogType = response.blogType;
    var blogUrl = response.blogUrl;
    var html = body;
    ...
  });
```


## License

Released under the MIT License

Copyright (c) 2013 Taeho Kim <xissysnd@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
