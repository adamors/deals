class InitialMigration < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.decimal :rating, precision: 3, scale: 2
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :subcategories do |t|
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end

    create_table :deals do |t|
      t.string :title
      t.text :description
      t.decimal :original_price, precision: 10, scale: 2
      t.decimal :discount_price, precision: 10, scale: 2
      t.integer :discount_percentage
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.integer :quantity_sold
      t.date :expiry_date
      t.boolean :featured_deal
      t.string :image_url
      t.text :fine_print
      t.integer :review_count
      t.decimal :average_rating, precision: 3, scale: 2
      t.integer :available_quantity
      t.timestamps
    end

    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.float :lat
      t.float :lng
      t.timestamps
    end

    create_table :deals_locations do |t|
      t.references :deal, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.string :role, null: false # 'main' or 'redemption'
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :deals_tags do |t|
      t.references :deal, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end

    add_foreign_key :subcategories, :categories
    add_foreign_key :deals, :categories
    add_foreign_key :deals, :subcategories
    add_foreign_key :deals, :merchants
    add_foreign_key :deals_locations, :deals
    add_foreign_key :deals_locations, :locations
    add_foreign_key :deals_tags, :deals
    add_foreign_key :deals_tags, :tags
  end
end
