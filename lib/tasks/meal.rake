namespace :meal do
    task delete: :environment do
        Meal.where.not(meal_type: nil).destroy_all
    end
end
