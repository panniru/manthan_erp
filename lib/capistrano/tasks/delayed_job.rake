#set_default(:delayed_job_pid) { "#{fetch(:current_path)}/tmp/pids/delayed_job.pid" }
#set_default(:delayed_job_0_pid) { "#{fetch(:current_path)}/tmp/pids/delayed_job.0.pid" }
#set_default(:delayed_job_1_pid) { "#{fetch(:current_path)}/tmp/pids/delayed_job.1.pid" }
#set_default(:delayed_job_2_pid) { "#{fetch(:current_path)}/tmp/pids/delayed_job.2.pid" }
#set_default(:delayed_job_3_pid) { "#{fetch(:current_path)}/tmp/pids/delayed_job.3.pid" }

namespace :delayed_job do
  desc "Setup delayed job scripts"
  task :move_scripts do
  on roles(:web) do   
    template "delayed_job_start.sh.erb", "/tmp/delayed_job_start.sh"
    template "delayed_job_stop.sh.erb", "/tmp/delayed_job_stop.sh"
    execute "mv /tmp/delayed_job_start.sh #{fetch(:shared_path)}/config/delayed_job_start.sh"
    execute "mv /tmp/delayed_job_stop.sh #{fetch(:shared_path)}/config/delayed_job_stop.sh"
    execute "chmod a+x #{fetch(:shared_path)}/config/delayed_job_stop.sh"
    execute "chmod a+x #{fetch(:shared_path)}/config/delayed_job_start.sh"
  end          
  end


  desc "start delayed job"
  task :start do
      on roles(:app) do
        execute "#{fetch(:shared_path)}/config/delayed_job_start.sh"
      end
    end
    
  desc "stop delayed job"
  task :start do
      on roles(:app) do
        execute "#{fetch(:shared_path)}/config/delayed_job_stop.sh"
      end
    end

  desc "restart delayed job"
  task :restart do
      on roles(:app) do
        execute "#{fetch(:shared_path)}/config/delayed_job_stop.sh"
        execute "#{fetch(:shared_path)}/config/delayed_job_start.sh"
      end
    end

    after "deploy:publishing", "delayed_job:restart"
end

def template(from, to)
  erb = File.read(File.expand_path("../../templates/#{from}", __FILE__))
  upload! StringIO.new(ERB.new(erb).result(binding)), to
end