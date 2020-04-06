defmodule MultipleSelectIssue.FoodContext.Food do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias MultipleSelectIssue.FoodContext.Category

  schema "foods" do
    field :barcode, :string
    field :name, :string
    field :paid, :boolean
    field :note, :string
    field :liquid, :boolean
    field :keywords, :string

    many_to_many :categories, Category, join_through: "food_to_category", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [
      :name,
      :barcode,
      :paid,
      :note,
      :liquid,
      :keywords
    ])
    |> validate_required([:name])
    |> change_categories_if_needed(attrs)
  end

  def changeset_only_image(food, attrs) do
    food
    |> cast_attachments(attrs, [:image], allow_paths: true)
    |> validate_required([:image])
  end

  def changeset_with_image(food, attrs) do
    food
    |> validate_image_if_present(attrs)
    |> changeset(attrs)
  end

  def validate_image_if_present(food, %{"image" => _image} = attrs) do
    food
    |> cast_attachments(attrs, [:image], allow_paths: true)
    |> validate_required([:image])
  end

  def validate_image_if_present(food, _), do: food

  def change_categories_if_needed(changeset, %{"categories" => categories}) do
    changeset
    |> put_assoc(:categories, categories, required: true)
  end

  def change_categories_if_needed(changeset, _), do: changeset
end
