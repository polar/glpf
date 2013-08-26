class CreateOrgTeams < ActiveRecord::Migration
  def change
    create_table :org_teams do |t|
      t.string     :name
      t.text       :description
      t.references :category

      t.timestamps
    end

    create_table :org_teams_users do |t|
      t.references :org_team
      t.references :user

      t.timestamps
    end
  end
end
