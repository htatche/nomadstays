class SearchStaysController < ApplicationController

  def index
    @q = Stay.ransack(params[:q])
    @stays = @q.result(distinct: true)
  end
    
end
