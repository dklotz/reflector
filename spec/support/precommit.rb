# frozen_string_literal: true

# Remind developers to install pre-commit
ENV["PRECOMMIT"] ||= "true"
if ENV["PRECOMMIT"] == "true"
  hook_file = File.join(File.dirname(__FILE__), "../../.git/hooks/pre-commit")
  if !File.readable?(hook_file) || File.read(hook_file)&.empty?
    puts "Please install pre-commit hooks by running"
    puts "pre-commit install"
    exit 1
  end
end
