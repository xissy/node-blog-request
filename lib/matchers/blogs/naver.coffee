url = require 'url'
querystring = require 'querystring'


module.exports = ($) ->
  wlwmanifestTag = $('link[rel="wlwmanifest"]')

  if wlwmanifestTag.length is 0
    return null

  wlwmanifestHref = wlwmanifestTag.attr('href')
  isNaverBlog = wlwmanifestHref?.startsWith 'http://blog.naver.com/'

  screenFrameSrc = $('frameset frame#screenFrame')?.attr('src')
  mainFrameSrc = $('frameset frame#mainFrame')?.attr('src')

  if screenFrameSrc?
    parsedUrl = url.parse screenFrameSrc
    splittedPathname = parsedUrl.pathname.split('/')
    blogId = splittedPathname[1]
    logNo = splittedPathname[2]
  else if mainFrameSrc?
    parsedUrl = url.parse mainFrameSrc
    parsedQuery = querystring.parse parsedUrl.query
    blogId = parsedQuery.blogId
    logNo = parsedQuery.logNo
  else
    return null

  type: 'naver'
  url: "http://blog.naver.com/PostView.nhn?blogId=#{blogId}&logNo=#{logNo}&redirect=Dlog&widgetTypeCall=true"
