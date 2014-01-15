SimpleCov.start 'rails' do
	coverage_dir('tmp/coverage')
	
	add_group 'Decorators', 'app/decorators'
	groups.delete('Plugins')

end
