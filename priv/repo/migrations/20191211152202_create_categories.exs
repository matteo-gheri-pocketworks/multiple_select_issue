defmodule MultipleSelectIssue.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :native_name, :string
      add :image, :string, null: true
      add :parent_category_id, references("categories", on_delete: :delete_all), null: true
    end
  end
end
