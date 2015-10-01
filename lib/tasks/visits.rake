namespace :visits do
  desc "delete unconfirmed visits"
  task delete_unconfirmed_visits: :environment do
    #Visit.delete_all(confirmed: false, created_at: DateTime.now-10.minutes)
    #puts 'AAAAAAAAAAAAAAAAAAAAAAA'
    Visit.where(['updated_at < ?', DateTime.now-10.minutes]).where("patient_id IS NOT NULL").where(confirmed: false).delete_all
  end

end
