class MakeStylesIntoTable2 < ActiveRecord::Migration[5.0]
  def change
    Beer.all.each do |beer|
      Style.all.each do |style|
        if style.style == beer.old_style
	  beer.style_id = style.id
	  beer.save
	end
      end
     end

     change_table :beers do |t|
       t.remove :old_style
     end
  end
end
