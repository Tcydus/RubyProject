class Class
	def attr_accessor_with_history(*attr_names)

		attr_names.each do |attr_name|

			attr_name = attr_name.to_s
			attr_hist = attr_name + "_history"

			self.class_eval %Q{

				def #{attr_name}
					@#{attr_name}
				end
	  
				def #{attr_name}=(new_value)
					@#{attr_hist} = [] if @#{attr_hist}.nil?
					@#{attr_hist} << new_value

					@#{attr_name} = new_value
				end

				def #{attr_hist}=( new_value )
					@#{attr_hist} = new_value
				end

				def #{attr_hist}
					@#{attr_hist}
				end
			}

		end

		self.class_eval %Q{
		def history(attr)	
			self.send(attr.to_s + "_history") 
		end	
		}	
	end
end

class Foo
  attr_accessor_with_history :gay, :bar
end

f = Foo.new
f.bar = "Hello"
f.bar = :dds
f.gay = :Tor

puts "Inside Class"
puts "bar_history  : #{f.bar_history}"
puts "history(:bar): #{f.history(:bar)}"
puts "gay_history  :  #{f.gay_history}"
puts "history(:gay): #{f.history(:gay)}"
