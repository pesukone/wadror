class MakeStylesIntoTable < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.string :style
      t.text :description
    end
    
    Beer.all.pluck(:style).uniq.each do |style| 
      Style.create(style: style, description: '')
    end

    change_table :beers do |t|
      t.rename :style, :old_style
      t.references :style, index: true, foreign_key: true
    end

    #add_foreign_key :beers, :styles
    
    #Beer.all.each do |beer| 
    #  Style.all.each do |style| 
    #    if style.style == beer.old_style
    #      beer.style_id = style.id
    #	  beer.save
    #	end
    #  end
    #end

    #change_table :beers do |t|
    #  t.remove :old_style
    #end
  end
end
