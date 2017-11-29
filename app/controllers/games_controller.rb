class GamesController < ApplicationController
  before_action :set_game, only: %i[show]

  # GET /games
  # GET /games.json

  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show; end

  def create
    @games = Game.all
    @games = filter_games(params)
    @filters = remove_unused_params(params)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:object_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.fetch(:game, {})
  end

  # rubocop:disable Metrics/MethodLength
  def filter_games(params)
    @games.select do |x|
      x.min_age >= params[:min_age].to_i &&
        x.min_players >= params[:min_players].to_i &&
        x.min_playtime >= params[:min_playtime].to_i &&
        x.max_players <= params[:max_players].to_i &&
        x.max_playtime <= params[:max_playtime].to_i
    end
  end
  # rubocop:enable Metrics/MethodLength

  def remove_unused_params(params)
    params.delete(:min_age) if params[:min_age].to_i.zero?
    params.delete(:min_players) if params[:min_players].to_i.zero?
    params.delete(:min_playtime) if params[:min_playtime].to_i.zero?
    params.delete(:max_playtime) if params[:max_playtime].to_i == 999
    params.delete(:max_players) if params[:max_players].to_i == 999

    params.except('utf8', 'authenticity_token',
                  'controller', 'action', 'commit')
  end
end
