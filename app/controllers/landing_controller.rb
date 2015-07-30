class LandingController < ApplicationController
  def landingpage
  end

  def registration
    redirect_to "/users/new"
  end
end
