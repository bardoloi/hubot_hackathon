# Description:
#   ..and now lets go to Ollie Williams for our forecast
#
# Commands:
#   hubot weather dallas
#   hubot weather in dallas,tx
#   hubot weather in bengaluru

apiBase = "http://api.openweathermap.org/data/2.5"
apiKey = process.env.WEATHER_API_KEY

currentWeatherUrl = apiBase + "/weather"
forecastUrl =  apiBase + "/forecast"

module.exports = (robot) ->
  robot.respond /weather (in )?(.*)$/i, (msg) ->
    
    qs = units: 'imperial', appid: apiKey, q: msg.match[2] 
    
    robot.http(currentWeatherUrl)
      .query(qs)
      .get() (err, res, body) ->
        data = JSON.parse(body)

        if data.length == 0
          msg.send "I don't know what the weather is in #{qs.q}"
        else
          weather = data.weather[0]
          icon = weather.icon
          main = weather.main
          description = weather.description
          temp = data.main.temp
          wind = data.wind.speed
          humidity = data.main.humidity
          iconUrl = "http://openweathermap.org/img/w/#{icon}.png" 
          msg.send "#{iconUrl} #{main} (#{description})\n#{temp} °F\nWind #{wind} miles/hr\nHumidity #{humidity}%"