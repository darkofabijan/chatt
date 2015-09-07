defmodule Chatt.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :room_id, references(:rooms)

      timestamps
    end
    create index(:messages, [:room_id])

  end
end
