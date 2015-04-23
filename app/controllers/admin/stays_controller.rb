class Admin::StaysController < ApplicationController

  public

    def show
      @stay = Stay.find params[:id]

      @booked_dates = @stay.booked_dates
    end

    def index
      
    end

end