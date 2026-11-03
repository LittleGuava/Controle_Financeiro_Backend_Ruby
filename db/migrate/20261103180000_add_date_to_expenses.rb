# Bancos criados pelo db/schema.rb antigo não têm expenses.date, embora
# a migration create_expenses crie a coluna.
class AddDateToExpenses < ActiveRecord::Migration[7.2]
  def change
    add_column :expenses, :date, :date, if_not_exists: true
  end
end
