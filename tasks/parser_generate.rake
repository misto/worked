desc 'Generate Treetop Parser'
task :parser_generate do
  sh %{ tt lib/worked/inputgrammar.treetop }
end
