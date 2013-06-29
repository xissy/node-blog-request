url = require 'url'
querystring = require 'querystring'


module.exports = ($) ->
  alternateTag = $('link[type="application/rss+xml"]')

  if alternateTag.length is 0
    return null

  alternateHref = alternateTag.attr('href')
  isDaumBlog = alternateHref?.startsWith 'http://blog.daum.net/'

  frameSrc = $('frameset frame')?.attr('src')

  if frameSrc?
    parsedUrl = url.parse frameSrc
    parsedQuery = querystring.parse parsedUrl.query
    blogId = parsedQuery.blogid
    articleNo = parsedQuery.articleno
  else
    return null

  type: 'daum'
  url: "http://blog.daum.net/_blog/BlogTypeView.do?blogid=#{blogId}&articleno=#{articleNo}&admin="
