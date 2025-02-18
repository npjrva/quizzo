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
    "the secret is a #{width}-digit integer"
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
    "the secret is a multiple of #{n}"
  end

  def test(i)
    (i % n) == 0
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
      return "the first digit of the secret is greater than the last digit"
    else
      return "the first digit of the secret is less than the last digit"
    end
  end
end

class SumOfDigitsPred
  attr_reader :sum
  def initialize(sum)
    @sum = sum
  end

  def to_s
    "the digits of the secret sum to #{sum}"
  end

  def test(i)
    sum == SumOfDigitsPred.hash(i)
  end

  def self.hash(n)
    n.to_s.split(//).map{|c| c.to_i}.sum
  end
end

class HasDigitPred
  attr_reader :digit, :reverse
  def initialize(digit, reverse)
    @digit = digit.to_s
    @reverse = reverse
  end

  def to_s
    if reverse
      "the secret does NOT contain the digit '#{digit}'"
    else
      "the secret contains the digit '#{digit}'"
    end
  end

  def test(i)
    if reverse
      return !(i.to_s.include? digit)
    else
      return i.to_s.include? digit
    end
  end
end

class MultipleOfFactory
  def try_derive(universe)
    # Try to choose a factor of
    # some but not all of the numbers
    # in the universe
    pivot = universe.sample
    factors = find_nontrivial_factors(pivot)
    return nil if factors.empty?

    factor = factors.sample
    pred = MultipleOfPredicate.new(factor)

    # Confirm that at least one number in the
    # universe is excluded by this factor
    counter_example = universe.find_index {|u| !pred.test(u) }
    if counter_example
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
    if example
      counter_example = universe.find_index {|u| !pred.test(u) }
      if counter_example
        return pred
      end
    end
    nil
  end
end

class DigitsSumFactory
  def try_derive(universe)
    pivot = universe.sample
    sum = SumOfDigitsPred.hash(pivot)
    pred = SumOfDigitsPred.new(sum)
    counter_example = universe.find_index {|u| !pred.test(u) }
    if counter_example
      return pred
    end
    nil
  end
end

class HasDigitFactory
  def try_derive(universe)
    digit = rand(10)
    pred = HasDigitPred.new(digit, rand(2)==0)
    example = universe.find_index {|u| pred.test(u) }
    if example
      counter_example = universe.find_index {|u| !pred.test(u) }
      if counter_example
        return pred
      end
    end
    nil
  end
end



WIDTH=4
range = IntegerWidthPredicate.new(WIDTH)
universe = range.enumerate

preds = [range]
factories = [MultipleOfFactory.new,
             FirstDigitLessThanLastDigitFactory.new,
             DigitsSumFactory.new,
             HasDigitFactory.new]
until universe.size < 2
  #$stderr.puts "Universe size: #{universe.size}"

  pred = nil
  while true
    factory = factories.sample
    pred = factory.try_derive(universe)
    break if pred
  end

  universe = universe.keep_if {|u| pred.test(u)}
  preds << pred
end

puts "There are #{preds.size} constraints on a secret number."
puts "First, #{preds.first.to_s}"

count_guesses = 0
double_hint = false
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
    conjunct = ''
    # Reorder knowledge, for fun
    known = [known.first] + known.drop(1).shuffle
    for k in known
      hints = hints.keep_if {|u| k.test(u) }
      puts "#{conjunct}#{k.to_s}, so #{hints.size} possibilities"
      conjunct = 'and, '
    end

    # If there's a unique solution, don't reveal it unless
    # the user 'double hints'
    if hints.size==1 and !double_hint
      puts "I don't want to spoil the surpise"
      puts "type hint again if you really want to know"
      double_hint = true
    else
      few_hints = hints.shuffle.take(3)
      puts "Maybe #{few_hints.join ', '}?"
    end
    next
  end

  double_hint = false
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
      puts "Ok, I hadn't told you this before, but..."
      known << pred
      puts "Not #{guess}, because #{pred.to_s}"
      correct = false
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

  hints = known.first.enumerate
  for k in known
    hints = hints.keep_if {|u| k.test(u) }
  end
  if hints.size > 1
    puts "Given what you knew so far, there are #{hints.size} possible solutions"
    puts "Such as #{hints.take(3).join ', '}"
  end
end

