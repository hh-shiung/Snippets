class CreateImpressionsTable < ActiveRecord::Migration
  def self.up
    create_table :impressions, :force => true do |t|
      t.string :impressionable_type   # model type: widget
      t.integer :impressionable_id    # model instance ID: @widget.id
      t.integer :user_id              # automatically logs @current_user.id
      t.string :controller_name       # logs the controller name
      t.string :action_name           # logs the action_name
      t.string :view_name             # logs individual views (as well as partials and nested partials)
      t.string :request_hash          # unique ID per request, in case multiple impressions are logged and grouped
      t.string :ip_address            # request.remote_ip
      t.string :session_hash          # logs the rails session
      t.text :message                 # custom message to be added
      t.text :referrer                # request.referrer
      t.timestamps
    end
    add_index :impressions, [:impressionable_type, :message, :impressionable_id], :name => "impressionable_type_message_index", :unique => false, :length => {:message => 255 }
    add_index :impressions, [:impressionable_type, :impressionable_id, :request_hash], :name => "poly_request_index", :unique => false
    add_index :impressions, [:impressionable_type, :impressionable_id, :ip_address], :name => "poly_ip_index", :unique => false
    add_index :impressions, [:impressionable_type, :impressionable_id, :session_hash], :name => "poly_session_index", :unique => false
    add_index :impressions, [:controller_name,:action_name,:request_hash], :name => "controlleraction_request_index", :unique => false
    add_index :impressions, [:controller_name,:action_name,:ip_address], :name => "controlleraction_ip_index", :unique => false
    add_index :impressions, [:controller_name,:action_name,:session_hash], :name => "controlleraction_session_index", :unique => false
    add_index :impressions, :user_id
  end

  def self.down
    drop_table :impressions
  end
end
