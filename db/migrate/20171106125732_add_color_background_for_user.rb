class AddColorBackgroundForUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :color_background, :string
  end
end
