require "#{Rails.root}/lib/data_importer"

namespace :app do
  namespace :db do
    namespace :load do
      desc 'Add collection data to database'
      task collection: :environment do
        DataImporter.collection_ids.each do |id|
          next if Game.where(object_id: id).exists?
          response = DataImporter.fetch_description(id)
          game = Nokogiri::XML(response.body)

          puts "Populating games table with OBJECT_ID: #{id}"
          game_info = DataImporter.game_info(game).merge!(object_id: id)

          Game.create(**game_info)
        end
      end
    end
  end
end
