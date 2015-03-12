class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.string :screen_name
      t.string :image_url
      t.string :url
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end
end