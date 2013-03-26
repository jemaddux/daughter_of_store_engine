module CategoriesHelper
  def category_options(categories)
    categories.collect do |category|
      [ category.name, category.id ]
    end
  end
end