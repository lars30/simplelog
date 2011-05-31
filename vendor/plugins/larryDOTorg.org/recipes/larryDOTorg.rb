
class Capistrano::Configuration

  ##
  # Print an informative message with asterisks.

  def inform(message)
    puts "#{'*' * (message.length + 4)}"
    puts "* #{message} *"
    puts "#{'*' * (message.length + 4)}"
  end

  ##
  # Read a file and evaluate it as an ERB template.
  # Path is relative to this file's directory.

  def render_erb_template(filename)
    template = File.read(filename)
    result   = ERB.new(template).result(binding)
  end

  ##
  # Run a command and return the result as a string.
  #
  # TODO May not work properly on multiple servers.

  def run_and_return(cmd)
    output = []
    run cmd do |ch, st, data|
      output << data
    end
    return output.to_s
  end

end


##
# Custom installation tasks for Larry.org.
#
# Author: Larry Cummings http://larry.org
#         January 2008

namespace :larryDotorg do
	desc "Sym link the public files to shared folder"
	task :symlink_pub_files do
		run "ln -s #{shared_path}/public/files/ #{current_path}/public/files"
		run "ln -s #{current_path}/public/files/ #{current_path}/public/uploadedImages"
	end
	after "deploy:update", "larryDotorg:symlink_pub_files"
end