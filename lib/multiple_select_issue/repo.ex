defmodule MultipleSelectIssue.Repo do
  use Ecto.Repo,
    otp_app: :multiple_select_issue,
    adapter: Ecto.Adapters.Postgres
end
