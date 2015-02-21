namespace :nodejs do
  desc "Install the latest relase of Node.js"
  task :install do
    on roles(:db) do
      execute :sudo, "add-apt-repository ppa:chris-lea/node.js" do |ch, stream, data|
        press_enter( ch, stream, data)
      end
      execute :sudo, "apt-get -y update"
      execute :sudo, "apt-get -y install nodejs"
    end
  end
end
