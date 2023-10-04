resource "shoreline_notebook" "high_number_of_idle_workers_in_apache_server" {
  name       = "high_number_of_idle_workers_in_apache_server"
  data       = file("${path.module}/data/high_number_of_idle_workers_in_apache_server.json")
  depends_on = [shoreline_action.invoke_apache_idle_workers]
}

resource "shoreline_file" "apache_idle_workers" {
  name             = "apache_idle_workers"
  input_file       = "${path.module}/data/apache_idle_workers.sh"
  md5              = filemd5("${path.module}/data/apache_idle_workers.sh")
  description      = "Adjust the Apache server configuration to reduce the maximum number of idle workers allowed. This will prevent the server from becoming overloaded with idle connections and help to free up resources for incoming requests."
  destination_path = "/agent/scripts/apache_idle_workers.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_idle_workers" {
  name        = "invoke_apache_idle_workers"
  description = "Adjust the Apache server configuration to reduce the maximum number of idle workers allowed. This will prevent the server from becoming overloaded with idle connections and help to free up resources for incoming requests."
  command     = "`chmod +x /agent/scripts/apache_idle_workers.sh && /agent/scripts/apache_idle_workers.sh`"
  params      = ["MAX_IDLE_WORKERS"]
  file_deps   = ["apache_idle_workers"]
  enabled     = true
  depends_on  = [shoreline_file.apache_idle_workers]
}

