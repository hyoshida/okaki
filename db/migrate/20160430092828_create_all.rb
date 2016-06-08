class CreateAll < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nickname
      t.string :title
      t.text :profile
      t.boolean :admin, null: false, default: false

      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      ## Confirmable
      # t.string :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false

      t.index :email, unique: true
      t.index :reset_password_token, unique: true
      # t.index :confirmation_token, unique: true
      # t.index :unlock_token, unique: true
    end

    create_table :entries do |t|
      t.boolean :draft, null: false, default: false, index: true
      t.integer :user_id, null: false, index: true
      t.integer :category_id, index: true
      t.string :slug, null: false
      t.string :title, null: false
      t.text :headline
      t.text :body, null: false
      t.integer :impressions_count, default: 0
      t.boolean :doruby, null: false, default: false, index: true

      t.timestamps null: false
    end

    create_table :blogs do |t|
      t.string :title, null: false
      t.string :meta_keywords
      t.string :meta_description
      t.string :facebook_page_url
      t.string :twitter_uid
      t.timestamps null: false
    end

    create_table :advertisements do |t|
      t.boolean :active, null: false, default: true, index: true
      t.string :title
      t.string :url, null: false
      t.string :image, null: false
      t.timestamps null: false
    end

    create_table :categories do |t|
      t.string :name, null: false
      t.string :ancestry, index: true
      t.integer :position
      t.timestamps null: false
    end

    create_table :assets do |t|
      t.integer :user_id, null: false, index: true
      t.string :title
      t.string :file, null: false
      t.string :original_filename
      t.timestamps null: false
    end

    create_table :impressions do |t|
      t.string :impressionable_type
      t.integer :impressionable_id
      t.integer :user_id
      t.string :controller_name
      t.string :action_name
      t.string :view_name
      t.string :request_hash
      t.string :ip_address
      t.string :session_hash
      t.text :message
      t.text :referrer
      t.timestamps null: false

      t.index [:impressionable_type, :message, :impressionable_id], name: 'impressionable_type_message_index', unique: false, length: { message: 255 }
      t.index [:impressionable_type, :impressionable_id, :request_hash], name: 'poly_request_index', unique: false
      t.index [:impressionable_type, :impressionable_id, :ip_address], name: 'poly_ip_index', unique: false
      t.index [:impressionable_type, :impressionable_id, :session_hash], name: 'poly_session_index', unique: false
      t.index [:controller_name, :action_name, :request_hash], name: 'controlleraction_request_index', unique: false
      t.index [:controller_name, :action_name, :ip_address], name: 'controlleraction_ip_index', unique: false
      t.index [:controller_name, :action_name, :session_hash], name: 'controlleraction_session_index', unique: false
      t.index :user_id
    end

    create_table :trackers do |t|
      t.boolean :active, null: false, default: true
      t.string :name, null: false
      t.string :tracker_id
      t.text :code, null: false
      t.string :location, null: false
      t.timestamps null: false
    end

    create_table :navigations do |t|
      t.boolean :active, null: false, default: true, index: true
      t.string :name, null: false
      t.string :url, null: false
      t.string :location, null: false, index: true
      t.integer :position
      t.timestamps null: false
    end
  end
end
