# http://www.fandango.com/rss/moviefeed

# Description:
#   Fandango movies near me
#
# Dependencies:
#   "nodepie": "0.5.0"
#   "html-to-json": "^0.6.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot movies near me - get the top 10 movies near homeZip
#   hubot movies near [zip] - get the top 10 movies near the input zip
#   hubot top 10 movies

NodePie = require("nodepie")
htmlToJson = require("html-to-json")

baseUrl = "http://www.fandango.com/rss"
moviesNearMeFeed = "#{baseUrl}/moviesnearme_#zip#.rss"
top10BoxOfficeFeed = "#{baseUrl}/top10boxoffice.rss"

getZip = (inputZip) ->
    if (inputZip == "me") 
        inputZip = process.env.HUBOT_DEFAULT_ZIP or "48105"
    inputZip

top10MovieItemFilters =
    hrefs: htmlToJson.createParser([
        'a'
        {
          'name': ($tag) ->
            $tag.text()
          'link': ($tag) ->
            $tag.attr 'href'
        }
    ])
    images: htmlToJson.createParser([
        'img'
        {
          'location': ($img) ->
            $img.attr 'src'
        }
    ])

theatreNearMeFilters =
    address: htmlToJson.createParser([
        'p'
        {
          'name': ($tag) ->
            $tag.text()
        }
    ])
    movies: htmlToJson.createParser([
        'p ul li a'
        {
          'url': ($url) ->
            $url.attr 'href'
          'text': ($url) ->
            $url.text()
        }
    ])

getTop10MoviesItem = (msg, item) ->
    htmlToJson.batch(item.getDescription(), top10MovieItemFilters).done (result) ->
        msg.send formatTop10MoviesMessage(result, item)

formatTop10MoviesMessage = (jsonData, item) ->
    imgUrl = jsonData.images[0].location
    tixUrl = jsonData.hrefs[1].link.split('movietimes')[0] + "movietimes?location=#{getZip('me')}"
    "#{item.getTitle()}\n#{imgUrl}\nGet Tickets: #{tixUrl}"

getTheatreNearMeItem = (msg, item) ->
    htmlToJson.batch(item.getDescription(), theatreNearMeFilters).done (result) ->
        msg.send formatTheatreNearMeMessage(result, item)

formatTheatreNearMeMessage = (jsonData, item) ->
    theaterName = item.getTitle()
    theatreAddress = jsonData.address[0].name
    theatreUrl = item.getPermalink().split('?')[0]
    moviesPlaying = ("#{i + 1}. #{m.text}" for m, i in jsonData.movies).reduce (x, y) -> x + "\n" + y
    "*#{theaterName}*\n_#{theatreAddress}_\n#{theatreUrl}\n#{moviesPlaying}"    

module.exports = (robot) ->
    robot.respond /top 10 movies/i, (msg) ->
        count = 10
        msg.http(top10BoxOfficeFeed).get() (err, res, body) ->
            if res.statusCode is not 200
                msg.send "Something's gone awry"
            else
               feed = new NodePie(body)
               try
                    feed.init()
                    items = feed.getItems(0, count)                    
                    getTop10MoviesItem(msg, item) for item in items
                catch e
                    console.log(e)
                    msg.send "Something's gone awry"

    robot.respond /movies near (.+)/i, (msg) ->
        myZip = getZip(msg.match[1])        
        if !myZip.match /^\d{5}$/
            msg.send "Sorry, #{myZip} is not a valid US zip code"
        else
            feedUrl = moviesNearMeFeed.replace /#zip#/, myZip
            count = 5
            msg.http(feedUrl).get() (err, res, body) ->
              if res.statusCode is not 200
                msg.send "Something's gone awry with my Fandango feed"
              else 
                  feed = new NodePie(body)        
                try
                  feed.init()
                  items = feed.getItems(0, count)
                  getTheatreNearMeItem(msg, item) for item in items
                catch e
                  console.log(e)
                  msg.send "Something's gone awry"