class SearchStaysController < ApplicationController

  def index

    if params[:q]
      query = params[:q].reject {|i,j|  i == "house_nomad_house_eq_any" && j == "0"}
      @q = Stay.ransack(query)
      @stays = @q.result(distinct: true)      
    else
      @q = Stay.ransack(params[:q])
      @stays = @q.result(distinct: true)
    end

  end
end