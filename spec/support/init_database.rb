require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:',
  verbosity: 'quiet'
)

ActiveRecord::Base.connection.create_table :users do |t|
  t.string :username
  t.integer :reputation, default: 0
  t.decimal :coins, default: 0
  t.decimal :tax, default: 30
  t.references :level
end

ActiveRecord::Base.connection.create_table :levels do |t|
  t.string :title
  t.integer :experience
end

ActiveRecord::Base.connection.create_table :privileges do |t|
  t.integer :privilege_type, nulll: false
  t.integer :amount, null: false
  t.string :description
end

ActiveRecord::Base.connection.create_table :levels_privileges do |t|
  t.references :level
  t.references :privilege
end
