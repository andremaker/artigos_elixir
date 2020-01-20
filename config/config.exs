import Config

config :regevents, Eventos.Repo,
  database: "bd_eventos",
  username: "bot",
  password: "S3nhabraba",
  hostname: "localhost"


config :regevents, Regevents.Guardian,
       issuer: "regevents",
       secret_key: "UUL/JL/r8zXxqUlWoyHs7YFn5upxWMB1PwBmYISjA15E8sLCUtEPQ+LIjHgbEKZB" 