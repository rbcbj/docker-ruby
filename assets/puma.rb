# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

# app_dir = File.expand_path("../..", __FILE__)
app_dir = "/var/www"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Logging
stdout_log = "#{app_dir}/log/puma.stdout.log"
stderr_log = "#{app_dir}/log/puma.stderr.log"
stdout_redirect stdout_log, stderr_log, true

# Set up socket location
run_dir = "/var/run"
bind "unix://#{run_dir}/puma.sock"

# Set master PID and state locations
pidfile "#{run_dir}/puma.pid"
state_path "#{run_dir}/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end