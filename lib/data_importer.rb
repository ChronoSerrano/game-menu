require 'nokogiri'
require 'faraday'

# Helper methods for app:db:load tasks
module DataImporter
  class << self
    def collection_ids
      ids = []
      collection = attempt_fetch(collection_url)
      response = Nokogiri::XML(collection.body)

      response.css('item').each do |node|
        ids << node['objectid']
      end

      ids
    end

    def fetch_description(id)
      attempt_fetch("#{base_url}/thing?id=#{id}")
    end

    def attribute_value(attribute)
      attribute.attribute('value').value
    end

    def game_info(game)
      {
        name: attribute_value(game.css('name')),
        object_type: game.css('item').attribute('type').value,
        description: game.css('description').inner_text
      }.merge!(players(game)).merge!(time(game))
    end

    private

    def base_url
      @base_url ||= Rails.application.config.bgg[:base_url]
    end

    def username
      @username ||= Rails.application.config.bgg[:username]
    end

    def collection_url
      @collection_url ||= "#{base_url}/collection?username=#{username}&own=1"
    end

    def attempt_fetch(url)
      response = Faraday.get(url)

      while response.status.eql?(202)
        response = Faraday.get(url)
        sleep 10
      end

      response
    end

    def players(game)
      {
        min_players: attribute_value(game.css('minplayers')),
        max_players: attribute_value(game.css('maxplayers')),
        min_age: attribute_value(game.css('minage'))
      }
    rescue NoMethodError => err
      puts "Error: #{err.backtrace} #{err.message}"
    end

    def time(game)
      {
        min_playtime: attribute_value(game.css('minplaytime')),
        max_playtime: attribute_value(game.css('maxplaytime')),
        play_time: attribute_value(game.css('playingtime'))
      }
    end
  end
end
