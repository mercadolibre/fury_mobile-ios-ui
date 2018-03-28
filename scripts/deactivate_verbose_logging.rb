# frozen_string_literal: true

COCOAPODS_CONFIG_PATH = "#{Dir.home}/.cocoapods/config.yaml"

def deactivate_verbose_logging
  server_config = File.read(COCOAPODS_CONFIG_PATH)
  modified_config = server_config.gsub(/(verbose:\s)(true)/, '\1false')
  File.open(COCOAPODS_CONFIG_PATH, 'w') { |file| file.puts modified_config }

  puts 'Cocoapods verbose logging deactivated'
end

def should_deactivate_verbose?
  readable = File.readable?(COCOAPODS_CONFIG_PATH)
  writable = File.writable?(COCOAPODS_CONFIG_PATH)

  readable && writable && ENV['CI']
end

##
# Deactivates debug logging if Cocoapods config file is present
##
deactivate_verbose_logging if should_deactivate_verbose?