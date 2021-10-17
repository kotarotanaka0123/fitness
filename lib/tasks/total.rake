namespace :total do
    task delete: :environment do
        Total.destroy_all
    end
end
