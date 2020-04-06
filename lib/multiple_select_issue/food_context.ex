defmodule MultipleSelectIssue.FoodContext do
  @moduledoc """
  The FoodContext context.
  """

  import Ecto.Query, warn: false
  alias MultipleSelectIssue.Repo

  alias MultipleSelectIssue.FoodContext
  alias MultipleSelectIssue.FoodContext.Food
  alias MultipleSelectIssue.FoodContext.Category

  # -------- FOOD -------- #

  @list_food_opts []

  @doc """
  Returns the list of foods.
  """
  def list_foods() do
    from(f in Food)
    |> Repo.all()
  end

  @doc """
  Gets a single food.

  Raises `Ecto.NoResultsError` if the Food does not exist.
  """
  def get_food!(id, preload \\ [:categories]) do
    Repo.get!(Food, id) |> Repo.preload(preload)
  end

  def get_food(id, preload \\ [:categories]) do
    Repo.get(Food, id) |> Repo.preload(preload)
  end

  defp convert_ids_to_model(attrs, []), do: attrs

  defp convert_ids_to_model(attrs, [:categories | _rest]) do
    if attrs["categories"] != nil do
      cats =
        case Enum.at(attrs["categories"], 0) do
          %Category{} ->
            attrs["categories"]

          _ ->
            from(c in Category, where: c.id in ^attrs["categories"])
            |> Repo.all()
        end

      Map.merge(attrs, %{"categories" => cats})
    else
      attrs
    end
  end

  @doc """
  Creates a food.
  """
  def create_food(%{"image" => _image} = attrs) do
    attrs = attrs |> convert_ids_to_model([:categories])

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:insert, Food.changeset(%Food{}, attrs))
    |> Ecto.Multi.update(:upload_image, fn %{insert: food} ->
      Portion.changeset_only_image(food, attrs)
    end)
    |> Repo.transaction(timeout: :infinity)
    |> case do
      {:ok, transaction} ->
        {:ok, transaction[:upload_image]}

      transaction ->
        transaction
    end
  end

  def create_food(attrs) do
    attrs = attrs |> convert_ids_to_model([:categories])

    %Food{}
    |> Food.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food.
  """
  def update_food(%Food{} = food, attrs) do
    attrs = attrs |> convert_ids_to_model([:categories])

    food
    |> Repo.preload([:categories])
    |> Food.changeset_with_image(attrs)
    |> Repo.update()
    |> case do
      {:ok, food} ->
        {:ok, food}

      response ->
        response
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food changes.
  """
  def change_food(%Food{} = food, attrs \\ %{}) do
    food
    |> Repo.preload([:categories])
    |> Food.changeset(attrs)
  end

  def list_categories(), do: from(c in Category) |> Repo.all()
end
