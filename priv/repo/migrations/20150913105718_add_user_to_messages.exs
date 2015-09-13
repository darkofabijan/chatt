defmodule Chatt.Repo.Migrations.AddUserToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :user, :text
    end
  end

end
