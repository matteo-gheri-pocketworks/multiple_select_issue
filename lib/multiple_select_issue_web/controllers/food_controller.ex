defmodule MultipleSelectIssueWeb.FoodController do
  use MultipleSelectIssueWeb, :controller

  alias MultipleSelectIssue.FoodContext
  alias MultipleSelectIssue.FoodContext.Food

  @show_preload [
    :categories
  ]

  def index(conn, _params) do
    foods = FoodContext.list_foods()
    render(conn, "index.html", foods: foods)
  end

  def new(conn, _params) do
    changeset = FoodContext.change_food(%Food{})
    view_entries = add_brand_restaurant_category_tags_cutlery_lists(%{changeset: changeset})
    render(conn, "new.html", view_entries)
  end

  def create(conn, %{"food" => food_params}) do
    case FoodContext.create_food(food_params) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food created successfully.")
        |> redirect(to: Routes.food_path(conn, :show, food))

      {:error, %Ecto.Changeset{} = changeset} ->
        view_entries = add_brand_restaurant_category_tags_cutlery_lists(%{changeset: changeset})
        render(conn, "new.html", view_entries)
    end
  end

  def show(conn, %{"id" => id}) do
    food = FoodContext.get_food!(id, @show_preload)

    render(conn, "show.html",
      food: food,
      csrf_token: get_csrf_token()
    )
  end

  def edit(conn, %{"id" => id}) do
    food = FoodContext.get_food!(id)
    changeset = FoodContext.change_food(food)

    view_entries =
      add_brand_restaurant_category_tags_cutlery_lists(%{changeset: changeset, food: food})

    render(conn, "edit.html", view_entries)
  end

  def update(conn, %{"id" => id, "food" => food_params}) do
    food = FoodContext.get_food!(id)

    case FoodContext.update_food(food, food_params) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food updated successfully.")
        |> redirect(to: Routes.food_path(conn, :show, food))

      {:error, %Ecto.Changeset{} = changeset} ->
        view_entries =
          add_brand_restaurant_category_tags_cutlery_lists(%{changeset: changeset, food: food})

        render(conn, "edit.html", view_entries)
    end
  end

  defp add_brand_restaurant_category_tags_cutlery_lists(entities) do
    categories = FoodContext.list_categories()

    Map.merge(
      %{
        categories: categories
      },
      entities
    )
  end
end
