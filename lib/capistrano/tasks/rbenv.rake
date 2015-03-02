set_default :ruby_version, "2.1.2"
set_default :rbenv_bootstrap, "bootstrap-ubuntu-12-04"

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install do
    on roles(:app) do
      execute :sudo, "apt-get -y install curl git-core"
      execute "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
      bashrc = <<-BASHRC
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
BASHRC
      io   = StringIO.new(bashrc)
      #upload! io, "/tmp/rbenvrc"
      #execute "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
      #execute "mv ~/.bashrc.tmp ~/.bashrc"
      #execute %q{export PATH="$HOME/.rbenv/bin:$PATH"}
      #execute %q{eval "$(rbenv init -)"}
      execute "rbenv #{fetch(:rbenv_bootstrap)}"
      execute "rbenv install #{fetch(:ruby_version)}"
      execute "rbenv global #{fetch(:ruby_version)}"
      execute "gem install bundler --no-ri --no-rdoc"
      execute "rbenv rehash"
    end
  end

  desc "Update Ruby"
  task :update_ruby do
    on roles(:app) do  
      execute "rbenv install #{fetch(:ruby_version)}"
      execute "rbenv global #{fetch(:ruby_version)}"
      execute "gem install bundler --no-ri --no-rdoc"
      execute "rbenv rehash"
    end
  end
end
