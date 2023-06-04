# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'fiber'

class Fiber
	module Annotate
		def initialize(annotation: nil, **options, &block)
			@annotation = annotation
			super(**options, &block)
		end
		
		def annotation
			@annotation
		end
		
		def __annotate__(annotation)
			if block_given?
				begin
					current_annotation = @annotation
					@annotation = annotation
					yield
				ensure
					@annotation = current_annotation
				end
			else
				@annotation = annotation
			end
		end
	end
end

unless Fiber.method_defined?(:annotation)
	Fiber.prepend(Fiber::Annotate)
	
	def Fiber.annotate(...)
		Fiber.current.__annotate__(...)
	end
end
