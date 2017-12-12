SimpleCov.start 'rails' do
	add_filter "/coverage/"
	add_filter "bootstrap"
	add_filter "/spec/"
	add_filter "/features"
	add_filter "/config/"
	add_filter "/db/"
	add_filter "/tmp/"
	add_filter "/log/"
	add_filter "/vendor/"
	add_filter "/iterations/"
end