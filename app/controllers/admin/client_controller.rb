class Admin::ClientController < ApplicationController
  def index
  	@clients = SpreeUser.all
  end
end
