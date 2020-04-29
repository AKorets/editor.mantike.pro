#--------- Hem setup options

defaultHem =
	baseAppRoute: "/"
	#tests:		runner: "browser"

proxyHem =
	baseAppRoute: "/"
	tests:
		runner: "browser"
	proxy:
		"/proxy":
			"host": "www.yoursite.com"
			"path": "/proxy"

#--------- main configuration setup

config =

	# main hem configuration
	hem: defaultHem

	# appliation configuration

	application:
		defaults: "spine"
		static:
			"static-js": "static.mantike.pro/js",
			"css-jquery":"static.mantike.pro/css/jquery-ui/pepper-grinder",
			"img-suit":"static.mantike.pro/img",
			"jscolor-img":"static.mantike.pro/img",
			"decks":"static.mantike.pro/decks"
		#css:
        
        #css : './css/index'
		#	src: 'static.mantike.pro/css/'
		js:
			libs: [
				'static.mantike.pro/js/jquery.min.js',
				'static/js/modernizr.mq.js',
				'lib/jade_runtime.js'
				'public/application.js'
			]
			modules: [
				"spine",
				"spine/lib/ajax",
				"spine/lib/route",
				"spine/lib/manager",
				"spine/lib/local",
				"jqueryify",
				"json2ify",
				"es5-shimify"
			]

#--------- export the configuration map for hem

module.exports.config = config

#--------- customize hem

module.exports.customize = (hem) ->
	# provide hook to customize the hem instance,
	# called after config is parsed/processed.
	return
