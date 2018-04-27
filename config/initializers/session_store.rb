# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_myblog_session'

# Rails.application.config.session_store :redis_store, {
#   servers: [
#     {
#       host: "127.0.0.1",
#       port: 6379,
#       db: 0,
#       namespace: "session"
#     },
#   ],
#   expire_after: 120.minutes,
#   key: "_myblog_session"
# }