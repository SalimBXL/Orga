class ChangeNumeroSemaineFormatInHebdos < ActiveRecord::Migration[5.1]
  def change
    change_column :hebdos, :numero_semaine, 'integer USING CAST(numero_semaine AS integer)'
  end
end
