class ApplicationController < ActionController::API
  def query_params
    {}
  end

  #using a no-op here for this dummy application
  def protect_from_forgery
  end
end
