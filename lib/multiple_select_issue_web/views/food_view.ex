defmodule MultipleSelectIssueWeb.FoodView do
  use MultipleSelectIssueWeb, :view

  def entities_for_select(entities, key, value \\ :id) do
    for entity <- entities do
      [key: Map.get(entity, key), value: Map.get(entity, value)]
    end
  end
end
