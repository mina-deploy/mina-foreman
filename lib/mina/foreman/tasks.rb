set :foreman_app, -> { "#{fetch(:domain)}_#{fetch(:rails_env)}" }
set :foreman_user, -> { fetch(:user) }
set :foreman_log,  -> { "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/log" }
set :foreman_sudo, true
set :foreman_format, 'upstart'
set :foreman_location, '/etc/init'
set :foreman_procfile, 'Procfile'

namespace :foreman do
  desc 'Export the Procfile to Ubuntu upstart scripts'
  task :export do
    sudo_cmd = "sudo" if fetch(:foreman_sudo)
    export_cmd = "#{sudo_cmd} bundle exec foreman export #{fetch(:foreman_format)} #{fetch(:foreman_location)} -a #{fetch(:foreman_app)} -u #{fetch(:foreman_user)} -d #{fetch(:deploy_to)}/#{fetch(:current_path)} -l #{fetch(:foreman_log)} -f #{fetch(:foreman_procfile)}"

    command %{
      echo "-----> Exporting foreman procfile for #{fetch(:foreman_app)}"
      #{echo_cmd %[cd #{fetch(:deploy_to)}/#{fetch(:current_path)} ; #{export_cmd}]}
    }
  end

  desc "Start the application services"
  task :start do
    command %{
      echo "-----> Starting #{fetch(:foreman_app)} services"
      #{echo_cmd %[sudo start #{fetch(:foreman_app)}]}
    }
  end

  desc "Stop the application services"
  task :stop do
    command %{
      echo "-----> Stopping #{fetch(:foreman_app)} services"
      #{echo_cmd %[sudo stop #{fetch(:foreman_app)}]}
    }
  end

  desc "Restart the application services"
  task :restart do
    command %{
      echo "-----> Restarting #{fetch(:foreman_app)} services"
      #{echo_cmd %[sudo start #{fetch(:foreman_app)} || sudo restart #{fetch(:foreman_app)}]}
    }
  end
end
