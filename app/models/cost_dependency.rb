class CostDependency < ApplicationRecord

	belongs_to :cost 

	validates :per_job, numericality: true
  	validates :per_page, numericality: true

end
