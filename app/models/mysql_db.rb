class MysqlDb < ActiveRecord::Base 
	self.abstract_class = true
	establish_connection MYSQL_DB

end