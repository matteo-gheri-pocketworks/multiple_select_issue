# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MultipleSelectIssue.Repo.insert!(%MultipleSelectIssue.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
%MultipleSelectIssue.FoodContext.Category{}
|> MultipleSelectIssue.FoodContext.Category.changeset(%{name: "test category 1"})
|> MultipleSelectIssue.Repo.insert()

%MultipleSelectIssue.FoodContext.Category{}
|> MultipleSelectIssue.FoodContext.Category.changeset(%{name: "test category 2"})
|> MultipleSelectIssue.Repo.insert()
