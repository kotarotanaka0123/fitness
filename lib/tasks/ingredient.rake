namespace :ingredient do
    task delete: :environment do
        Ingredient.last.delete
    end
end
