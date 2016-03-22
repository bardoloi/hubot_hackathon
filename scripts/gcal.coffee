# Description:
#   A way to interact with the Google Calendar API
#
# Dependencies:
#   "googleapis": "^2.1.7",
#
# Configuration:
#   HUBOT_GOOGLE_API_KEY
#
# Commands:
#   hubot confrooms open - finds availabe conference rooms right now
#   hubot reserve (confroomname) - reserves the conference room for 30 minutes, with subject as "Reserved for @username"
#   hubot reserve (confroomname) from 1030 to 1200 for (meeting title) - reserves the conference room for the requested period
#
# Notes:
#   Limits for free version is 100 queries per day per API key

# google = require 'googleapis'

# key = process.env.HUBOT_GOOGLE_JWT_FILE

# getEvents = () ->
#   jwtClient = new google.auth.JWT(
#     key.client_email, 
#     # leave null since we're supplying the key ourselves below. If not, this is the "/path/to/secret/pem/or/json/file"
#     null,
#     key.private_key, 
#     # scopes requested access to
#     ['https://www.googleapis.com/auth/calendar.readonly', 'https://www.googleapis.com/auth/calendar'],
#     # leave null unless you want to impersonate an email
#     null 
#     )
#   res = jwtClient.authorize (err, tokens) ->
#     return "err"
#     if err
#       return "FML - " + err
#     # Make an authorized request to list Calendar events
#     return "Hakuna matatatratata"
#     # listEvents tokens
#   return res

 
# listEvents = (auth) ->
#   calendar = google.calendar('v3')
#   calendar.events.list {
#     auth: auth
#     calendarId: 'primary'
#     timeMin: (new Date).toISOString()
#     maxResults: 10
#     singleEvents: true
#     orderBy: 'startTime'
#   }, (err, response) ->
#     if err
#       console.log 'The API returned an error: ' + err
#       return
#     events = response.items
#     if events.length == 0
#       console.log 'No upcoming events found.'
#     else
#       console.log 'Upcoming 10 events:'
#       i = 0
#       while i < events.length
#         event = events[i]
#         start = event.start.dateTime or event.start.date
#         console.log '%s - %s', start, event.summary
#         i++
#     return
#   return

# module.exports = (robot) ->
#   robot.respond /gcal me/i, (msg) ->
#     msg.send "Here I am, this is me"
#     # msg.send JSON.stringify getEvents()
#     msg.send getEvents()
