desc 'Generate website files'
task :website_generate => :ruby_env do
  sh %{ #{RUBY_APP} script/txt2html README.rdoc > website/index.html}
end
