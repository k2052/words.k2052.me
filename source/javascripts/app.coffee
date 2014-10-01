#= require 'prism/prism'
#= require 'prism/plugins/line-numbers/prism-line-numbers'
#= require 'prism/components/prism-coffeescript'
#= require 'prism/components/prism-javascript'
#= require 'bigtext'

$(document).ready ->
	WebFont.load
		google:
			families: ["Lato:400,400italic,300,300italic,100,100italic,700,900"]
			
		active: ->
			console.log "loaded"
			$('.article-title').bigtext()
