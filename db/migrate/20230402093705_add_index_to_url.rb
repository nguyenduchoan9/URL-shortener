class AddIndexToUrl < ActiveRecord::Migration[7.0]
  def change
    add_index :urls, %i[original_url], unique: true, name: 'index_urls_original_url'
    add_index :urls, %i[short_url original_url], unique: true, name: 'index_urls_short_url_original_url'
  end
end
