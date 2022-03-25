#!/usr/bin/env ruby

class String
	# colorization
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end

	def red
		colorize(31)
	end

	def green
		colorize(32)
	end

	def check
		puts system("which #{self}", :err => File::NULL, :out => File::NULL) ? "#{self} ✔".green : "#{self} ☒".red
	end
end

['npm', 'lsd', 'thefuck', 'rg', 'autojump'].each do |_|
	_.check
end

puts ''

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
