# frozen_string_literal: true

require_relative "lib/fiber/annotate/version"

Gem::Specification.new do |spec|
	spec.name = "fiber-annotate"
	spec.version = Fiber::Annotate::VERSION
	
	spec.summary = "A mechanism for annotating fibers."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/ioquatix/fiber-annotate"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
	}
	
	spec.files = Dir.glob(['{lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 2.7"
end
