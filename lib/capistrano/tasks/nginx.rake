namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install do
    on roles(:web) do  
       execute :sudo, "add-apt-repository ppa:nginx/stable" do |ch, stream, data|
                press_enter( ch, stream, data)
         end 
    execute :sudo, "apt-get -y update"
    execute :sudo, "apt-get -y install nginx"
     end      
  end
    

  desc "Setup nginx configuration for this application"
  task :setup do
    on roles(:web) do  
       template "nginx_unicorn.erb", "/tmp/nginx_conf"
       execute :sudo, "mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
       execute :sudo, "rm -f /etc/nginx/sites-enabled/default"
       restart
    end    
  end
        
  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command do
      on roles(:web) do
        excecute :sudo, "service nginx #{command}"
      end
    end 
  end
end
