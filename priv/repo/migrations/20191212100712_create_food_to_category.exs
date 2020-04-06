defmodule MultipleSelectIssue.Repo.Migrations.CreateFoodToCategory do
  use Ecto.Migration

  def change do
    create table(:food_to_category, primary_key: false) do
      add :category_id, references("categories", on_delete: :delete_all), null: false
      add :food_id, references("foods", on_delete: :delete_all), null: false
      add :active, :boolean, default: true
    end

    create unique_index(:food_to_category, [:category_id, :food_id],
             name: :food_id_category_id_unique_index
           )
  end
end
