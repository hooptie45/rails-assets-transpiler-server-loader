url         = require('url')
request     = require('request-promise')
loaderUtils = require('loader-utils')
request.debug = true

wrapInModuleExport = (transpiledText) -> 'module.exports = ' + JSON.stringify(transpiledText) + ';'

exports = (content, map) ->
  @cacheable and @cacheable()
  callback = @async()
  result = null
  config =
    port: 3000
    ip: '127.0.0.1'
    moduleExport: true
    path: '/transpile'

  queryConfig = loaderUtils.getLoaderConfig(@, "railsAssetTranspilerServerLoader"
  config = Object.assign(config, queryConfig)
  requestUrl = url.format(
    protocol: 'http'
    slashes: true
    hostname: config.ip
    port: config.port
    pathname: config.path)

  if !callback
    throw new Error('Couldn\'t create async callback')

  request.post(requestUrl, form: file: @resourcePath).then((body) ->
    JSON.parse(body).text
  ).then((transpiled) ->
    transpiled = wrapInModuleExport(transpiled) if config.moduleExport
    callback null, transpiled, map
  ).catch (error) ->
    errorText = (error or '').toString()
    callback new Error(errorText), content, map

