def template(from, to)
  erb = File.read(File.expand_path("../../templates/#{from}", __FILE__))
  upload! StringIO.new(ERB.new(erb).result(binding)), to
end

def set_default(name, *args, &block)
  set(name, *args, &block)
end

def press_enter( ch, stream, data)
  if data =~ /Press.\[ENTER\].to.continue/
    # prompt, and then send the response to the remote process
    ch.send_data( "\n")
  else
    # use the default handler for all other text
    Capistrano::Configuration.default_io_proc.call( ch, stream, data)
  end
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    on roles(:app) do
      execute :sudo, "apt-get -y update"
      execute :sudo, "apt-get -y install python-software-properties"
      execute :sudo, "apt-get -y install libxslt-dev libxml2-dev"
    end
  end

  
end
