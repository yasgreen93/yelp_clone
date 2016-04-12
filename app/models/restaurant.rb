class Restaurant < ActiveRecord::Base

  def index
  end

  has_many :reviews

end
