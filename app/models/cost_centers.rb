class CostCenters < MysqlDb
	
	self.table_name = "<REDACTED>"
	
	def self.costcenters
		results = self.distinct.where.not(:REDACTED_COLUMN => nil).order(:REDACTED_COLUMN).map { |cc| 
			cc[:REDACTED_COLUMN]+" "+cc[:REDACTED_COLUMN] 
		}
  		return ( ["Personal - Paid at Register"] + results )
	end

end