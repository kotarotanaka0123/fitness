namespace :meal do
    task delete: :environment do
        Meal.where.not(meal_type: nil).last.delete
    end
end
