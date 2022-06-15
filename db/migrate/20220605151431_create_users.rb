class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :hobbies
      t.string :job_title
      t.string :job_company
      t.string :highest_education
      t.string :crypto_wallet_1
      t.string :crypto_wallet_2
      t.string :crypto_wallet_3
      t.string :facebook
      t.string :twitter
      t.string :github
      t.string :stackoverflow
      t.string :other_site
      t.string :cell
      t.string :marital_status
      t.string :sex
      t.string :interested_in

      t.timestamps
    end
  end
end
