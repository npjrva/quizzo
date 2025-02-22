#!/usr/bin/env ruby

require 'rainbow'

class IntegerWidthPredicate
  attr_reader :width
  attr_reader :min, :max_exclusive
  def initialize(width)
    @width = width
    @min = 10.pow(width-1).to_i
    @max_exclusive = 10.pow(width).to_i
  end

  def to_s
    "the secret number is a #{width}-digit integer"
  end

  def refute(i)
    "#{i} has #{i.to_s.size} digits"
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
  attr_reader :n, :polarity
  def initialize(n, polarity)
    @n = n
    @polarity = polarity
  end

  def to_s
    if polarity
      "the secret number is a multiple of #{n}"
    else
      "the secret number is NOT a multiple of #{n}"
    end
  end

  def refute(i)
    lb = (i/n).to_i
    if polarity
      "#{lb}*#{n} == #{lb*n} < #{i} < #{(lb+1)*n} == #{lb+1}*#{n}"
    else
      "#{lb}*#{n} == #{i}"
    end
  end


  def test(i)
    if polarity
      return (i % n) == 0
    else
      return (i % n) != 0
    end
  end
end

class FirstDigitsLessThanLastDigitsPred
  attr_reader :subsequence_length, :polarity
  def initialize(subsequence_length, polarity)
    @subsequence_length = subsequence_length
    @polarity = polarity
  end

  def prefix_s(i)
    i.to_s[0 ... subsequence_length]
  end


  def prefix(i)
    prefix_s(i).to_i
  end

  def suffix_s(i)
    i.to_s.reverse[0 ... subsequence_length].reverse
  end

  def suffix(i)
    suffix_s(i).to_i
  end

  def test(i)
    first_digits = prefix(i)
    last_digits = suffix(i)

    if polarity
      return first_digits < last_digits
    else
      return first_digits > last_digits
    end
  end

  def to_s
    if @subsequence_length == 1
      if polarity
        return "the first digit of the secret number is less than the last digit"
      else
        return "the first digit of the secret number is greater than the last digit"
      end
    else
      if polarity
        return "the first #{subsequence_length} digits of the secret number form a number less than the last #{subsequence_length} digits"
      else
        return "the first #{subsequence_length} digits of the secret number form a number greater than the last #{subsequence_length} digits"
      end
    end
  end

  def refute(i)
    total_length = i.to_s.size
    blanks_length = total_length - subsequence_length
    blanks = '_' * blanks_length
    first_digits = prefix_s(i)
    last_digits = suffix_s(i)
    if polarity
      "#{first_digits}#{blanks} is not less than #{blanks}#{last_digits}"
    else
      "#{first_digits}#{blanks} is not greater than #{blanks}#{last_digits}"
    end
  end

end

class SumOfDigitsPred
  attr_reader :sum
  def initialize(sum)
    @sum = sum
  end

  def to_s
    "the digits of the secret number sum to #{sum}"
  end

  def test(i)
    sum == SumOfDigitsPred.hash(i)
  end

  def self.hash(n)
    n.to_s.split(//).map{|c| c.to_i}.sum
  end

  def refute(i)
    "the digits of #{i} sum to #{SumOfDigitsPred.hash(i)} == #{i.to_s.split(//).join(' + ')}"
  end
end

class HasDigitPred
  attr_reader :digit, :polarity
  def initialize(digit, polarity)
    @digit = digit.to_s
    @polarity = polarity
  end

  def to_s
    if polarity
      "the secret number contains the digit '#{digit}'"
    else
      "the secret number does NOT contain the digit '#{digit}'"
    end
  end

  def refute(i)
    if polarity
      return "#{i} doesn't include '#{digit}'"
    else
      return "#{i} includes '#{digit}'"
    end
  end

  def test(i)
    if polarity
      return i.to_s.include? digit
    else
      return !(i.to_s.include? digit)
    end
  end
end

class Disjunct
  def initialize(clauses)
    @clauses = clauses
  end

  def to_s
    "(" + (@clauses.map{|c| c.to_s}.join "; or, ") + ")"
  end

  def refute(i)
    refutes = @clauses.map{|c| c.refute i}
    "none hold: #{refutes.join('; and, ')}"
  end

  def test(i)
    @clauses.each do |c|
      return true if c.test i
    end
    false
  end
end

def find_factors(v)
  factors = []
  i=1
  while i*i <= v
    if (v % i) == 0
      factors << i
      j = v/i
      factors << j unless j==i
    end
    i += 1
  end
  factors
end

def find_nontrivial_factors(v)
  all_factors = find_factors(v)
  raise "Error" unless 1==all_factors.shift
  raise "Error" unless v==all_factors.shift
  all_factors
end

def find_proper_divisors(v)
  find_nontrivial_factors(v) << 1
end

class AbundantPred
  attr_reader :polarity
  def initialize(polarity)
    @polarity = polarity
  end

  def to_s
    if polarity
      return "the secret number's proper divisors are abundant"
    else
      return "the secret number's proper divisors are deficient"
    end
  end

  def refute(i)
    pds = find_proper_divisors(i).sort
    if polarity
      "#{i} is not less than the sum #{pds.sum} of its proper divisors #{pds.join ' + '}"
    else
      "#{i} is not greater than the sum #{pds.sum} of its proper divisors #{pds.join ' + '}"
    end
  end

  def test(i)
    if polarity
      return find_proper_divisors(i).sum > i
    else
      return find_proper_divisors(i).sum < i
    end
  end
end

class MultipleOfFactory
  def try_derive(universe)
    pivot = universe.sample
    factors = find_nontrivial_factors(pivot)
    return nil if factors.empty?
    factor = factors.sample
    MultipleOfPredicate.new(factor, [false,true].sample)
  end
end

class AbundantFactory
  def try_derive(universe)
    AbundantPred.new([false,true].sample)
  end
end

class FirstDigitsLessThanLastDigitsFactory
  attr_reader :width
  def initialize(width)
    @width = width
  end

  def try_derive(universe)
    subsequence_length = 1 + rand(width-1)
    FirstDigitsLessThanLastDigitsPred.new(subsequence_length, [false,true].sample)
  end
end

class DigitsSumFactory
  def try_derive(universe)
    pivot = universe.sample
    sum = SumOfDigitsPred.hash(pivot)
    SumOfDigitsPred.new(sum)
  end
end

class HasDigitFactory
  def try_derive(universe)
    HasDigitPred.new(rand(10), [false,true].sample)
  end
end

class DisjunctionFactory
  def initialize(factories)
    @factories = factories
  end

  def try_derive(universe)
    ps = @factories.sample(2).map{|f| f.try_derive universe}
    return nil if ps.include? nil
    return Disjunct.new(ps)
  end
end


width=4
unless ARGV.empty?
  width = ARGV.first.to_i
end
range = IntegerWidthPredicate.new(width)
universe = range.enumerate

preds = [range]
base_factories = [MultipleOfFactory.new,
             FirstDigitsLessThanLastDigitsFactory.new(width),
             DigitsSumFactory.new,
             HasDigitFactory.new,
             AbundantFactory.new]
compound_factories = [ DisjunctionFactory.new(base_factories) ]
factories = base_factories + compound_factories

print "...thinking...\r"
until universe.size < 2
  # Ask a random factory to derive a predicate
  # and confirm that the predicate refines the
  # universe into a smaller (but non-empty) universe
  refined_universe = nil
  pred = nil
  while true
    pred = factories.sample.try_derive(universe)
    next if pred==nil
    refined_universe = universe.select {|u| pred.test u}
    next if refined_universe.empty?
    next if refined_universe.size == universe.size
    break
  end

  universe = refined_universe
  preds << pred
end

puts "There are #{preds.size} secret constraints that define a unique, secret number."

known = [preds.first]
puts "The first constraint: " + Rainbow(known.first.to_s).bg(:green)
puts "Guess at the number and I'll reveal more constraints."

count_rounds = 0
double_hint = false
correct = false
until correct
  count_rounds += 1
  puts
  print "#{count_rounds}. What is your guess (or hint or quit)? "
  guess = $stdin.gets.strip.downcase
  puts
  if guess == 'quit'
    break
  elsif guess == 'hint'
    hints = known.first.enumerate
    puts "Let's see..."
    conjunct = ''
    # Reorder knowledge, for fun
    known = [known.first] + known.drop(1).shuffle
    for k in known
      print "...thinking...\r"
      hints = hints.select {|u| k.test(u) }
      puts(conjunct + Rainbow(k.to_s).bg(:yellow) + ", so #{hints.size} possibilities")
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
      puts("Maybe " + Rainbow(few_hints.join ', ').bg(:yellow) + "?")
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
      puts("Not #{guess}, because " + Rainbow(pred.to_s).bg(:red))
      puts " but #{pred.refute(guess)}"
      correct = false
    end
  end
  if !correct
    puts "You already knew all that"
    next
  end

  # And if the guess satisfies all the
  # clues so far, maybe divulge one more
  # clue
  preds.each do |pred|
    unless pred.test(guess)
      puts "Good!  #{guess} passes all the constraints you knew already..."
      puts "So I reveal another constraint:"
      known << pred
      puts("It's not #{guess}, because " + Rainbow(pred.to_s).bg(:green))
      puts " but #{pred.refute(guess)}"
      correct = false
      break
    end
  end
end

puts "The secret number was #{universe.first}."
if correct
  print(Rainbow("Great job").bg(:green) + ", ")
  if count_rounds == 1
    puts "You solved it on your first try"
  else
    puts "You solved it in #{count_rounds} rounds (versus #{known.size} known / #{preds.size} constraints)"
  end
end

hints = known.first.enumerate
for k in known
  hints = hints.keep_if {|u| k.test(u) }
end
if hints.size > 1
  puts "Given the constraints you know so far, there are #{hints.size} possible secret numbers"
  hints.delete universe.first
  puts "Such as #{hints.shuffle.take(3).join ', '}"
end

