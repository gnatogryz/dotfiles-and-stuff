#!/usr/bin/env ruby

`which lsd`
`which ruby`
`which thefuck`
`which npm`
`which autojump`

def createLinks(path)
	Dir.foreach(path) do |d|
		next if d == '.' || d == '..' || d == '.git' || d == File.basename(__FILE__) || d == '.local'
		# how do paths work in ruby o_O
		return createLinks(d) if File.directory? d

		home = File.expand_path('~')
		source = File.join(path, d)
		target = File.join(home, (File.join(path == '.' ? '' : path, d)))

		puts "Yoloing  #{source} → #{target}"
		system "rm #{target}" if File.exists? target
		system "ln #{source} #{target}"
	end
end

createLinks '.'
