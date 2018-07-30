class Cost < ApplicationRecord

	has_many :cost_dependencies, dependent: :destroy

	validates :per_job, numericality: true
  	validates :per_page, numericality: true

  	accepts_nested_attributes_for :cost_dependencies
end 