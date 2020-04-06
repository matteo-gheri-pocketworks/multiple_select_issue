use Mix.Config

# Configure your database
config :multiple_select_issue, MultipleSelectIssue.Repo,
  username: "postgres",
  password: "postgres",
  database: "multiple_select_issue_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :multiple_select_issue, MultipleSelectIssueWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
