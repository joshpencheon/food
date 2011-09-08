class Bill < ActiveRecord::Base
  belongs_to :basket
    
  after_initialize :set_defaults
  
  private
  
  def set_defaults
    self.proportion ||= 0
  end
end
