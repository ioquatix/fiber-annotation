# Getting Started

This guide gives shows how to add fiber-annotate to your project and annotate your fibers.

## Installation

Add the gem to your project:

~~~ bash
$ bundle add fiber-annotate
~~~

## Annotating a Fiber

~~~ ruby
Fiber.new(annotation: "My Fiber") do
	Fiber.current.annotation # => "My Fiber"
	
	Fiber.annotate("Connecting...") do
		# Connect
		Fiber.current.annotation # => "Connecting..."
	end
end
~~~
