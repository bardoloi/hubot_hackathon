# # Description:
# #   Manage your links and bookmarks. Links get stored in the robot brain while
# #   bookmarks get stored at delicious.com. Also keeps a history of all URLs in
# #   the "urls" section of the robot brain. 
# #
# # Dependencies:
# #   "xml2js": "0.1.14"
# #
# # Configuration:
# #   DELICIOUS_USER
# #   DELICIOUS_PASSWORD
# #
# # Commands:
# #   hubot bookmark <url> as <description> - add a url to your delicious feed
# #   hubot link <url> as <description> - add a url to the robot brain
# #   hubot link me for <description> - find a link by description
# #   hubot list bookmarks - get a list of the 15 most recent bookmarks
# #   hubot list links - List all of the links that are being tracked
# #   hubot feed me - get the URL to subscribe to your bookmark rss
# #
# # Author
# #   bardoloi

# goodreads_api_key = process.env.GOODREADS_API_KEY
# goodreads_api_secret = process.env.GOODREADS_API_SECRET

# base_url = 'https://www.goodreads.com'
# book_review_by_title_url = '/book/title.xml?'

# https = require('https')

# module.exports = (robot) ->

#   robot.respond /goodreads book reviews for (.*)/i, (msg) ->
#     bookTitle = msg.match[0]
# 	options = 
# 	  key: goodreads_api_key
# 	  title: encode(bookTitle)
# 	  author: encode('arthur conan doyle')
	
#     https.get(options, (res) ->
#       if res.statusCode == 200
#         res.on 'data', (chunk) ->
#           data.push(chunk)

#         res.on 'end', () ->
#           parsedData = JSON.parse(data.join(''))
#           images = parsedData.data.images
#           image = images[parseInt(Math.random() * images.length)]

#           msg.send(image.link)
#     )

