#!/usr/bin/env ruby

def createLinks(path)
	Dir.foreach(path) do |d|
		next if d == '.' || d == '..' || d == '.git' || d == File.basename(__FILE__)
		if File.directory? d
			#Dir.chdir(d) do |dir|
				createLinks( d)
			#end
			return
		end
		#puts File.join(path, d)
		home = File.expand_path('~')
		source = File.join(path, d)
		target = File.join(home, (File.join(path == '.' ? '' : path, d)))

		puts "Yoloing  #{source} → #{target}"
		system "rm #{target}" if File.exists? target
		system "ln #{source} #{target}"
	end
end

createLinks '.'
