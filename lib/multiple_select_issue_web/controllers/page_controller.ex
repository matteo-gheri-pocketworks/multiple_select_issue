defmodule MultipleSelectIssueWeb.PageController do
  use MultipleSelectIssueWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
