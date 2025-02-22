quizzo

A frustrating math puzzle game.

Prerequisites

  $ gem install rainbow  # provides terminal colors



Example transcript:

```
$ ./quizzo.rb 
There are 19 constraints on a secret number.
The first constraint: the secret is a 4-digit integer
Make some guesses, and I'll reveal more constraints.

1. What is your guess (or hint or quit)? 1234

Ok, I hadn't told you this before, but...
It's not 1234, because (the digits of the secret sum to 19; or, the secret's proper divisors are abundant)
 but none hold: the digits of 1234 sum to 10 == 1 + 2 + 3 + 4; and, 1234 is not less than the sum 620 of its proper divisors 1 + 2 + 617

2. What is your guess (or hint or quit)? 5554

Ok, I hadn't told you this before, but...
It's not 5554, because (the secret contains the digit '1'; or, the secret's proper divisors are abundant)
 but none hold: 5554 doesn't include '1'; and, 5554 is not less than the sum 2780 of its proper divisors 1 + 2 + 2777

3. What is your guess (or hint or quit)? 6661

Ok, I hadn't told you this before, but...
It's not 6661, because the secret does NOT contain the digit '1'
 but 6661 includes '1'

4. What is your guess (or hint or quit)? 8820

Ok, I hadn't told you this before, but...
It's not 8820, because the digits of the secret sum to 15
 but the digits of 8820 sum to 18 == 8 + 8 + 2 + 0

5. What is your guess (or hint or quit)? 7710

Not 7710, because the secret does NOT contain the digit '1'
 but 7710 includes '1'
(but you already knew all that)

6. What is your guess (or hint or quit)? 7755

Not 7755, because (the digits of the secret sum to 19; or, the secret's proper divisors are abundant)
 but none hold: the digits of 7755 sum to 24 == 7 + 7 + 5 + 5; and, 7755 is not less than the sum 6069 of its proper divisors 1 + 3 + 5 + 11 + 15 + 33 + 47 + 55 + 141 + 165 + 235 + 517 + 705 + 1551 + 2585
Not 7755, because (the secret contains the digit '1'; or, the secret's proper divisors are abundant)
 but none hold: 7755 doesn't include '1'; and, 7755 is not less than the sum 6069 of its proper divisors 1 + 3 + 5 + 11 + 15 + 33 + 47 + 55 + 141 + 165 + 235 + 517 + 705 + 1551 + 2585
Not 7755, because the digits of the secret sum to 15
 but the digits of 7755 sum to 24 == 7 + 7 + 5 + 5
(but you already knew all that)

7. What is your guess (or hint or quit)? 4443

Not 4443, because (the digits of the secret sum to 19; or, the secret's proper divisors are abundant)
 but none hold: the digits of 4443 sum to 15 == 4 + 4 + 4 + 3; and, 4443 is not less than the sum 1485 of its proper divisors 1 + 3 + 1481
Not 4443, because (the secret contains the digit '1'; or, the secret's proper divisors are abundant)
 but none hold: 4443 doesn't include '1'; and, 4443 is not less than the sum 1485 of its proper divisors 1 + 3 + 1481
(but you already knew all that)

8. What is your guess (or hint or quit)? 3444

Ok, I hadn't told you this before, but...
It's not 3444, because the first 2 digits of the secret form a number greater than the last 2 digits
 but 34__ is not greater than __44

9. What is your guess (or hint or quit)? 4434

Ok, I hadn't told you this before, but...
It's not 4434, because the secret contains the digit '2'
 but 4434 doesn't include '2'

10. What is your guess (or hint or quit)? 4236

Ok, I hadn't told you this before, but...
It's not 4236, because the secret does NOT contain the digit '6'
 but 4236 includes '6'

11. What is your guess (or hint or quit)? 4038

Not 4038, because the secret contains the digit '2'
 but 4038 doesn't include '2'
(but you already knew all that)

12. What is your guess (or hint or quit)? 5206

Not 5206, because (the digits of the secret sum to 19; or, the secret's proper divisors are abundant)
 but none hold: the digits of 5206 sum to 13 == 5 + 2 + 0 + 6; and, 5206 is not less than the sum 3074 of its proper divisors 1 + 2 + 19 + 38 + 137 + 274 + 2603
Not 5206, because (the secret contains the digit '1'; or, the secret's proper divisors are abundant)
 but none hold: 5206 doesn't include '1'; and, 5206 is not less than the sum 3074 of its proper divisors 1 + 2 + 19 + 38 + 137 + 274 + 2603
Not 5206, because the digits of the secret sum to 15
 but the digits of 5206 sum to 13 == 5 + 2 + 0 + 6
Not 5206, because the secret does NOT contain the digit '6'
 but 5206 includes '6'
(but you already knew all that)

13. What is your guess (or hint or quit)? 7206

Not 7206, because the secret does NOT contain the digit '6'
 but 7206 includes '6'
(but you already knew all that)

14. What is your guess (or hint or quit)? 9204

Ok, I hadn't told you this before, but...
It's not 9204, because the secret is NOT a multiple of 4
 but 2301*4 == 9204

15. What is your guess (or hint or quit)? 9402

Ok, I hadn't told you this before, but...
It's not 9402, because the secret is a multiple of 3014
 but 3*3014 == 9042 < 9402 < 12056 == 4*3014

16. What is your guess (or hint or quit)? 6028

Not 6028, because (the digits of the secret sum to 19; or, the secret's proper divisors are abundant)
 but none hold: the digits of 6028 sum to 16 == 6 + 0 + 2 + 8; and, 6028 is not less than the sum 5564 of its proper divisors 1 + 2 + 4 + 11 + 22 + 44 + 137 + 274 + 548 + 1507 + 3014
Not 6028, because (the secret contains the digit '1'; or, the secret's proper divisors are abundant)
 but none hold: 6028 doesn't include '1'; and, 6028 is not less than the sum 5564 of its proper divisors 1 + 2 + 4 + 11 + 22 + 44 + 137 + 274 + 548 + 1507 + 3014
Not 6028, because the digits of the secret sum to 15
 but the digits of 6028 sum to 16 == 6 + 0 + 2 + 8
Not 6028, because the secret does NOT contain the digit '6'
 but 6028 includes '6'
Not 6028, because the secret is NOT a multiple of 4
 but 1507*4 == 6028
(but you already knew all that)

17. What is your guess (or hint or quit)? 9042

The secret was 9042.
Great job, You solved it in 17 rounds (versus 10 known / 19 constraints)
```
