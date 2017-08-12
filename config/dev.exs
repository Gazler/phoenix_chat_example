use Mix.Config

priv_dir = Path.join([__DIR__, "..", "priv"])
certfile = Path.join(priv_dir, "server.pem")
keyfile = Path.join(priv_dir, "server.key")

unless File.exists?(keyfile) do
  raise """
  No SSL key/cert found. Please run the following command:
  openssl req -new -newkey rsa:4096 -days 365 -nodes -x509  \
  -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
  -keyout priv/server.key -out priv/server.pem
  """
end


# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :chat, Chat.Endpoint,
  https: [
    port: 4001,
    certfile: certfile,
    keyfile: keyfile,
  ],
  handler: Phoenix.Endpoint.Cowboy2Handler,
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]

# Watch static and templates for browser reloading.
config :chat, Chat.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
