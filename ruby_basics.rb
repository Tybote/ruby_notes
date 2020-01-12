# Some bascis

# Logical value
# Everything false and nil are false
# Otherwise, all is true

# Flow of Control

if a == 3
  puts "a is 3"
elsif a == 4
  puts ""
else
  puts ""
end

unless a == 6
  puts ""
end

# Loop

3.times { puts "Hello World" } # puts : standard ruby method to print string. Returns nil

while a > 9
  puts a
  a -= 1
end

until a >= 10
  puts a
  a += 1
end

# modifier form

puts "hello" if a == 5 and b == 0

times_2 = 2
times_2 *= 2 while times_2 < 100

# Triple === : don't use it, "Equal in its own way"
# works for comparing regular expression with an entire word for example

# Switch case
# === is used with case

case # 1st flavor, similar to if statements
  when age >= 21
    puts ""
  when 1 == 0
    puts ""
  else
    puts ""
end

# 2nd flavor, specifying a target, here is age
name = 'Fisher'
case name
  when /fish/i then puts "1"
  when 'SMith' then puts "2"
end
# 1

# For Loop, not often used
# each / times preferred

for i in 0..2
  puts i
end

# Methods
# All methods belong to a class. There is not functions. Even if a method is defined outside a user class.
# The value returned is the last evaluated expression of the method.

# Parentheses are optional
def simple
  puts ""
end

def simple1()
  puts ""
end

def divide(one, two)
  return "Impossible" if two == 0
  one / two
end

# Expressive Methods
# name? : predicate methods
# name! : dangerous side effect, like modifying the current String

def can_divide_by?(numer)
  return false if number.zero?
  true
end
# can_divide_by? 3 => true

# Default arguments
def factorial(n = 5)
  n == 0? 1 : n*factorial(n-1)
end

# Splat
# used with '*' prefixing parameter inside methode def

def max(first, *numbers, last)
  numbers.max
end
# puts max("hello", 1, -89, 100, "hello") => 100

# Blocks examples

1.times { puts "Hello" } # one line block

2.times do |index| # index is a default parameter for which iteration is it currently
  if index > 0
    puts index
  end
end

2.times { |index| puts index if index > 0 }

# Using block in methods

# Implicit

def two_times_implicit
  return "No block" unless block_given? # block_given? return true if a block is passed to the method
  yield # to call the block
end
# puts two_times_implicit { print "Hello" }

# Explicit

def two_times_explicit (&a_block) # '&' is used to specify that we expect a block
  return "No block" if a_block.nil?
  a_block.call # uses of 'call' to call the block explicitly
end
# puts two_times_explicit { print "Hello" }

# Files manipulations
# Use of the class File
# Files automatically close at the end of the block

# Read all lines through a file
File.foreach( 'test.txt') do | line |
  puts line
end

# Handling exceptions
begin
  File.foreach( 'test.txt') do | line |
    puts line
  end

rescue Exception => e
  puts e.message
end

# Verifying is file exists
File.exist? 'test.txt'

# Writing into a file
File.open("test1.txt", 'w') do |file|
  file.puts "One line"
  file.puts "Another line"
end

# Read environment variables

ENV["SOME_VARIABLE"]

# Strings

# '' strings are very literal, show everythin
# "" allow string interpolation, the use of \n, \t
single_quoted = 'first line \n second line it\'s a party' #first line \n second line it's a party
double_quoted = "first line \n second line it\'s a party"
#first line
# second line it's a party

# interpolation
def multiply(one, two)
  "#{one} multiplied by #{two} equals #{one * two}" # "#{one * two} => interpolation, string to int two string
end

# methods with '!' used to a string modify directly the string itself

# Some methods with strings
my_name = " tim" # note the there's a space before
puts my_name.lstrip.capitalize # => " Tim"
puts my_name # => " tim"
my_name.lstrip! # (destructive) removes the leading space
my_name[0] = 'K' # replace the first character

cur_weather = %Q{It's a hot day outside
		 Grab your umbrellas...}

cur_weather.lines do |line|
	line.sub! 'hot', 'rainy' # subsitute 'hot' with 'rainy'
	puts "#{line.strip}"
end

"hello".include? "lo" # => true
"hello".include? "ol" # => false


# Symbols and Strings
# can be converted to a String with to_s, or from String to Symbol with to_sym
# symbols can represent methods name
# highly optimized strings, constant names, unique and immutable

# Arrays
# arrays are auto-expandable (like std::vector in c++)
# can be indexed with negative numbers or ranges
# heterogeneous types allowed in the same array

%w{str1 str2} # for string array creation

het_array = [1, "two", :three] # heterogeneous types
arr_words = %w{ what a great day today! }
puts arr_words[-2] # => day
puts "#{arr_words.first} - #{arr_words.last}" # => what - today!
puts arr_words[-3, 2] # => ["great", "day"] go back to -3 index, then take 2 elements
puts arr_words[2..4] # => ["great", "day", "today"] from index 2 to index 4

# Make a string out of array elements separeted by ','
puts arr_words.join(',') # => what,a,great,day,today!

# Modifying arrays
# Append examples
stack = []; stack << "one"; stack.push "two" # two methods : << and push
puts stack.pop # => two, delete elements last element

queue = []; queue.push "one"; queue.push "two"
p queue.shift # => one, delete first element

a = [5,3,4,2].sort!.reverse! # modifies the array
p a # => [5,4,3,2] 
p a.sample(2) # => 2 random elements

a[6] = 33
p a # => [5, 4, 3, 2, nil, nil, 33]

# Useful methods
# each : loop through array
# select : filter array by selecting
# reject : filter array by rejecting
# map : modify each element in the array

a = [1,3,4,7,8,10]
a.each { |num| print num } #=> 1347810 (no new line)

new_arr = a.select { |num| num > 4 }
p new_arr # => [7, 8, 10]
new_arr = a.select { |num| num < 10 }
	   .reject { |num| num.even? }
p new_arr # => [1, 3, 7]

new_arr = a.map { |x| x * 3 } # multiply each element of the array by 3 producing new_array
p new_arr # => [3, 9, 12, 21, 24, 30]


# Ranges
# ranges are efficient : only start and end stored
# can be converted to an array with to_a
# used for loops and conditions

# Two dots : all-inclusive
1..10 # 1 and 10 included
# Three dots : end-exclusive
1...10 # 1 included, 10 not included
# the more dots we add, the less we have at the end

some_range = 1..3
puts some_range.max # => 3
puts some_range.include? 2 # true
puts (1...10) === 5.3 # true
puts ('a'...'r') === "r" # false (end exclusive)
p ('k'..'z').to_a.sample(2) # ["k", "w"], sample of elements with 2 letters

age = 5
case age
	when 0..12 then puts "is a boy"
	when 13..99 then puts "teenager until the end"
	else puts "getiing older..."
end

# Hashes
# indexed collections
# created with either {} or Hash.new
# index (key) can be anything
# accessed using the [] operator, setting key value : creation with => and post creation []

hash = {"front" => "Arial", "size" => 12, "color" => "red"}
puts hash.length # 3
puts hash["front"] # Arial
hash["background"] = "Blue"

hash.each_pair do |key, value|
	puts "Key: #{key} value: #{value}"
end

hash["something"] # nil
hash = Hash.new(0)
hash["something"] # 0
hash = Hash.new(5)
hash["something"] # 5

words_frequency = Hash.new(0)
sentence = "Chicka chicka boom boom"
sentence.split.each do |word|
	word_frequency[word.downcase] += 1
end
p word_frequency # {"chicka" => 2, "boom" => 2}

# Can use symbols as keys
family = {oldest: "Jim", older: "Joe", younger: "Jack"}
family[:youngest] = "Jeremy"

# Named parameter "like" behavior...
def adjust_colors (props = {foreground: "red", background: "white"})
	p "Foreground: #{props[:foreground]}" if props[:foreground]
	p "Background: #{props[:background]}" if props[:background]
end
adjust_colors # foreground: red /n background: white
adjust_colors ({ :foreground => "green"}) # foreground: green
adjust_colors background: "yella" # background: yella
adjust_colors :background => "magenta" # background: magenta

# Confusion between blocks and hashes
hash = { :one => "one"}
puts hash # {:one=>"one"}
puts { :one => "one"} # Syntax error, ruby thinks that's a block
# BUT
puts ({ :one => "one"})  # {:one=>"one"}
# OR
puts one: "one" # {:one=>"one"}

# ============================= POO ========================== #

# Example

class Person
	# Instance variables : private
	# Methods are public by default
	# Can defined getter and setters OR
	# Use of attr_ => BETTER
	# attr_accessor : getter and setter
	# attr_reader : getter only
	# attr_writer : setter only
	# self used outside : for class methods and class variable(static methods), used INSIDE : refer to an instance method (like self.age in initialize)
	attr_accessor :name
	attr_reader :age # but can define a setter then

	def initialize (name, ageVar) # Constructor
		@name = name # instance variable. Defined at first call
		self.age = ageVar
	end
	def get_info
		@additional_info = "Interesting"
		"Name: #{@name}, age: #{@age}"
	end
	def name
		@name
	end
	def name= (new_name)
		@name = new_name
	end
	def age= (new_age)
		@age ||= 5 # default value
		@age = new_age unless new_age > 120
	end
end

person = Person.new("Joe", 14)
p person.instance_variables # :@name, :@age
p person.get_info
p person.instance_variables # :@name, :@age, :@additional_info

class MathFunctions
	def self.double(var) # 1. Using self : class method
		times_called; var * 2
	end
	def << self # 2. Using << self
		def times_called
			@@times_called ||= 0; @@times_called += 1
		end
	end
end

def MathFunctions.triple(var) # 3. Outside of class
	times_called; var * 3
end

# Inheritance
# Use of '<'

class Dog
	def to_s
		"Dog"
	end
	def bark
		"barks loudly"
	end
end

class SmallDog < Dog
	def bark # override
		"barks quietly"
	end
end

# Modules

# Module as Namespace with operator '::'
module Sports
	class Match
		attr_accessor :score
	end
end

module Patterns
	class Match
		attr_accessor :complete
	end
end

match1 = Sports::Match.new
match2 = Patterns::Match.new

# Module as Mixin (Interface)
# we can use built-in module like Enumerable : require_relative

module SayMyName
	attr_accessor :name	
	def print_name
		puts "Name: #{@name}"
	end
end

class Person
	include SayMyName
end

class Company
	include SayMyName
end

person = Person.new
person.name = "Joe"
person.print_name
# ETC

# Enumerable Module
# map, select, reject, detect, etc
# used by array class, etc
# EXAMPLE

class Player
	attr_reader :name, :age, :skill_level
	def initialize (name, age, skill_level)
		@name = name
		@age = age
		@skill_level = skill_level
	end
	def to_s
		"<#{name}: #{skill_level}(SL), #{age}(AGE)>"
	end
end

class Team
	include Enumerable
	attr_accessor :name, :players
	def initialize(name)
		@name = name
		@players = []
	end
	def add_players(*players) # splat
		@players += players
	end
	def to_s
		"#{@name} team: #{@players.join(", ")}"
	end
	def each
		@players.each { |player| yield player }
	end
end

# Access control
# Use of public, protected or private




