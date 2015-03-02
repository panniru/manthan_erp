set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { application }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
set_default(:postgresql_database) { "#{fetch(:application)}_production" }
set_default(:postgresql_pid) { "/var/run/postgresql/9.3-main.pid" }

namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install  do
    on roles(:db) do
      execute :sudo, "add-apt-repository ppa:pitti/postgresql" do |ch, stream, data|
        press_enter( ch, stream, data)
      end
    execute :sudo, "apt-get -y update"
    execute :sudo, "apt-get -y install postgresql libpq-dev"

    end
  end

  desc "Create a database for this application."
  task :create_database do
    on roles(:db) do
      run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
      run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
    end
  end

  desc "Generate the database.yml configuration file."
  task :setup do
    on roles(:db) do
      template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
    end
  end
  
end
