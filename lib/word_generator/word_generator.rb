module WordGenerator 
	class WordGenerator
	  
	  Vowel = %w{ a e i }
	  Final = %w{ n m l }
	  Normal = %w{ p b r t }
	  Double = %w{ st ph sh }
	  
	  def initialize
		 
	  end
	  
	  private
	  #converts a string to an array
	  def to_rule s
		out = []
		s.each_char do |c|
		  if (out.last == 'C' && c == 'C')
			out.delete_at(-1)
			out << 'CC'
		  else
			out << c
		  end
		end
		out
	  end
	  #parses each rule in a file
	  def open_rules 
		File.open("rules.txt") do |f|
		  while line = f.gets
			parse(line.chomp)
		  end
		end
	  end
	  
	  public
	  # runs the program with the given rules-file
	  def generate
		open_rules
	  end
		
	  #manually invoke the parse function
	  def parse s
		if (s == nil || s == "")
		  abort
		end
		out_a = [nil]
		rule = to_rule(s)
		ri = rule.size
		rule.each_with_index do |r, i|
		  if r == 'V'
			out_a = out_a.product(Vowel)
		  elsif (r == 'C')
			if (i+1 == rule.size)
			  out_a = out_a.product(Final)
			else
			  out_a = out_a.product(Normal)
			end
=begin
		  elsif (r == 'N')
			out_a = out_a.product(n_sound_array)
=end
		  else
			out_a = out_a.product(Double)
		  end
		end
		b = out_a.flatten(ri)
		help = ""
		b.each do |c|
		  if c == nil
			help << "\n"
		  else
			help << c
		  end
		end
		result = help.split("\n")
		result.delete_at(0)
		File.open("output.txt", "a+") do |f|
		  result.each do |token|
			f.write("\n")
			f.write(token)
		  end
		end
	  end #parse
	end
end