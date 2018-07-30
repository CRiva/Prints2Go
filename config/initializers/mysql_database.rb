
MYSQL_DB = YAML.load_file(File.join(Rails.root, "config", "mysql_database.yml"))[Rails.env.to_s]