# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'fiber/annotate'

describe Fiber do
	it "should be able to annotate a fiber" do
		fiber = Fiber.new(annotation: "foo") do
			expect(Fiber.current.annotation).to be == "foo"
		end
		
		expect(fiber.annotation).to be == "foo"
	end
	
	with '.annotate' do
		it "should annotate the current fiber" do
			Fiber.annotate("foo")
			expect(Fiber.current.annotation).to be == "foo"
		end
		
		it "should annotate the current fiber with a block" do
			Fiber.annotate("foo") do
				expect(Fiber.current.annotation).to be == "foo"
			end
		end
		
		it "should annotate the current fiber with a block and restore the previous annotation" do
			Fiber.annotate("foo") do
				Fiber.annotate("bar") do
					expect(Fiber.current.annotation).to be == "bar"
				end
				expect(Fiber.current.annotation).to be == "foo"
			end
		end
		
		it "should annotate the current fiber with a block and restore the previous annotation even if an exception is raised" do
			Fiber.annotate("foo") do
				expect do
					Fiber.annotate("bar") do
						raise "baz"
					end
				end.to raise_exception(RuntimeError)
				expect(Fiber.current.annotation).to be == "foo"
			end
		end
	end
end
