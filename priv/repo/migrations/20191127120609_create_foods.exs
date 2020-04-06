defmodule MultipleSelectIssue.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string
      add :barcode, :string, null: true
      add :paid, :boolean, default: false
      add :note, :string, null: true
      add :image, :string, null: true
      add :liquid, :boolean, default: false
      add :keywords, :string
      timestamps()
    end
  end
end
