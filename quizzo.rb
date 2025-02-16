#!/usr/bin/env ruby


class IntegerWidthPredicate
  attr_reader :width
  attr_reader :min, :max_exclusive
  def initialize(width)
    @width = width
    @min = 10.pow(width-1).to_i
    @max_exclusive = 10.pow(width).to_i
  end

  def to_s
    "The number is a #{width}-digit integer"
  end

  def test(i)
    min <= i and i < max_exclusive
  end

  def enumerate
    universe = []
    u = min
    while u < max_exclusive
      universe << u
      u += 1
    end
    universe
  end
end


class MultipleOfPredicate
  attr_reader :n
  def initialize(n)
    @n = n
  end

  def to_s
    "The number is a multiple of #{n}"
  end

  def test(i)
    (i % n) == 0
  end
end

class GreaterThanPredicate
  attr_reader :n
  def initialize(n)
    @n = n
  end

  def to_s
    "The number is a greater than #{n}"
  end

  def test(i)
    i > n
  end
end

class LessThanPredicate
  attr_reader :n
  def initialize(n)
    @n = n
  end

  def to_s
    "The number is a less than #{n}"
  end

  def test(i)
    i < n
  end
end

class FirstDigitLessThanLastDigitPred
  attr_reader :reverse
  def initialize(reverse)
    @reverse = reverse
  end

  def test(i)
    first_digit = i.to_s[0].to_i
    last_digit = i.to_s[-1].to_i
    if reverse
      return first_digit > last_digit
    else
      return first_digit < last_digit
    end
  end

  def to_s
    if reverse
      return "The first digit is greater than the last digit"
    else
      return "The first digit is less than the last digit"
    end
  end
end

class GreaterThanFactory
  def try_derive(universe)
    pivot = universe[ rand(universe.size) ]
    pred = GreaterThanPredicate.new(pivot)
    # Confirm that this predicate excludes
    # at least one element from the
    # universe.  Since universe is stored
    # in ascending order, we need only check
    # the first
    return pred if pred.test(universe.last) and !pred.test(universe.first)
    nil
  end
end

class LessThanFactory
  def try_derive(universe)
    pivot = universe[ rand(universe.size) ]
    pred = LessThanPredicate.new(pivot)
    # Confirm that this predicate excludes
    # at least one element from the
    # universe.  Since universe is stored
    # in ascending order, we need only check
    # the last
    return pred if pred.test(universe.first) and !pred.test(universe.last)
    nil
  end
end

class MultipleOfFactory
  def try_derive(universe)
    return nil if universe.size < 2

    # Try to choose a factor of
    # some but not all of the numbers
    # in the universe
    pivot = universe[ rand(universe.size) ]
    #$stderr.puts "Pivot on #{pivot}"
    nt_factors = find_nontrivial_factors(pivot)
    return nil if nt_factors.empty?

    factor = nt_factors[ rand(nt_factors.size) ]
    pred = MultipleOfPredicate.new(factor)
    #$stderr.puts "Factor #{factor} -> '#{pred.to_s}'"
    #assert pred.test(pivot)

    # Confirm that at least one number in the
    # universe is excluded by this factor
    universe.each do |u|
      next if pred.test(u)
      #$stderr.puts "'#{pred.to_s}' excludes #{u} from universe"
      return pred
    end

    nil
  end

  # Determine the factors of v,
  # excluding its trivial factors 1, v
  def find_nontrivial_factors(v)
    factors = []
    i=2
    while i*i <= v
      if (v % i) == 0
        #$stderr.puts "#{i}, #{v/i} are factors of #{v}"
        factors << i
        factors << (v/i)
      end
      i += 1
    end
    factors
  end
end

class FirstDigitLessThanLastDigitFactory
  def try_derive(universe)
    pred = FirstDigitLessThanLastDigitPred.new( rand(2) == 0 )
    example = universe.find_index {|u| pred.test(u) }
    counter_example = universe.find_index {|u| !pred.test(u) }
    return pred if example and counter_example
    nil
  end
end


WIDTH=4
range = IntegerWidthPredicate.new(WIDTH)
universe = range.enumerate

preds = [range]
factories = [MultipleOfFactory.new, GreaterThanFactory.new, LessThanFactory.new, FirstDigitLessThanLastDigitFactory.new]
until universe.size < 2
  #$stderr.puts "Universe size: #{universe.size}"

  pred = nil
  while true
    factory = factories[ rand(factories.size) ]
    pred = factory.try_derive(universe)
    break if pred
  end

  universe = universe.keep_if {|u| pred.test(u)}
  preds << pred
end


puts "- #{preds.first.to_s}"

count_guesses = 0
correct = false
known = [preds.first]
until correct
  count_guesses += 1
  puts
  print "#{count_guesses}. What is your guess (or hint or quit)? "
  guess = $stdin.gets.strip.downcase
  if guess == 'quit'
    break
  elsif guess == 'hint'
    hints = known.first.enumerate
    puts "Let's see..."
    for k in known
      hints = hints.keep_if {|u| k.test(u) }
      puts "and, #{k.to_s}, so #{hints.size} possibilities"
    end

    few_hints = hints.sort{|a,b| rand(3)-1}.take(3)
    puts "Maybe #{few_hints.join ', '}?"
    next
  end

  guess = guess.to_i

  # Check the input against all the clues,
  # first the ones they've already seen
  correct = true
  known.each do |pred|
    unless pred.test(guess)
      puts "Not #{guess}, because #{pred.to_s}"
      correct = false
    end
  end
  if !correct
    puts "(but you already knew all that)"
    next
  end

  # And if the guess satisfies all the
  # clues so far, maybe divulge one more
  # clue
  preds.each do |pred|
    unless pred.test(guess)
      puts "Not #{guess}, because #{pred.to_s}"
      correct = false
      known << pred
      break
    end
  end
end

puts "The answer was #{universe.first}."
if correct
  puts "Great job, "
  if count_guesses == 1
    puts "You solved it on your first try"
  else
    puts "You solved it in #{count_guesses} guesses (versus #{preds.size} clues)"
  end
end



