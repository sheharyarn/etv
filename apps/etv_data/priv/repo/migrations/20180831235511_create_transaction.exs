defmodule ETV.Data.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    # Create Table
    create table(:transactions) do
      add :tx_hash,  :string,    null: false
      add :status,   :integer,   null: false,  default: 0

      timestamps()
    end


    # Create indices
    create index(:transactions, [:tx_hash], unique: true)
  end
end
