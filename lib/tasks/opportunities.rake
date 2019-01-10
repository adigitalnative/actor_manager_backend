namespace :opportunities do
  desc "TODO"
  task scan: :environment do
    Opportunity.source_global_opportunities
  end

end
