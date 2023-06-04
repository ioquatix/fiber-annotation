# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'fiber'

class Fiber
	# A mechanism for annotating fibers.
	module Annotate
		# Annotate the current fiber with the given annotation.
		# @parameter annotation [Object] The annotation to set.
		def initialize(annotation: nil, **options, &block)
			@annotation = annotation
			super(**options, &block)
		end
		
		# Get the current annotation.
		# @returns [Object] The current annotation.
		def annotation
			@annotation
		end
		
		# Annotate the current fiber with the given annotation.
		#
		# If a block is given, the annotation is set for the duration of the block and then restored.
		#
		# This method should only be invoked on the current fiber.
		#
		# @parameter annotation [Object] The annotation to set.
		# @yields {} The block to execute with the given annotation.
		# @returns [Object] The return value of the block.
		def annotate(annotation)
			raise "Cannot annotate a different fiber!" unless Fiber.current == self
			
			if block_given?
				begin
					current_annotation = @annotation
					@annotation = annotation
					return yield
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
	
	# @scope Fiber
	# @name self.annotate
	# Annotate the current fiber with the given annotation.
	def Fiber.annotate(...)
		Fiber.current.annotate(...)
	end
end
