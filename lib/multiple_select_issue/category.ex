defmodule MultipleSelectIssue.FoodContext.Category do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias MultipleSelectIssue.FoodContext
  alias MultipleSelectIssue.FoodContext.Category
  alias MultipleSelectIssue.FoodContext.Food

  schema "categories" do
    field :name, :string
    field :native_name, :string

    belongs_to :parent_category, Category

    many_to_many :foods, Food, join_through: "food_to_category", on_replace: :delete
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :native_name, :parent_category_id])
    |> validate_required([:name])
    |> assoc_constraint(:parent_category)
  end
end
