class AddSalesforceToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :refresh_token, :string
    add_column :identities, :instance_url, :string
  end
end
