quizzo

A frustrating math puzzle game.


Example transcript:

```
$ ./quizzo.rb
There are 10 constraints on a secret number.
First, the secret is a 4-digit integer

1. What is your guess (or hint or quit)? 5500

Ok, I hadn't told you this before, but...
It's not 5500, because the secret is a multiple of 9

2. What is your guess (or hint or quit)? 5502

Not 5502, because the secret is a multiple of 9
(but you already knew all that)

3. What is your guess (or hint or quit)? 5505

Not 5505, because the secret is a multiple of 9
(but you already knew all that)

4. What is your guess (or hint or quit)? 5508

Ok, I hadn't told you this before, but...
It's not 5508, because the first digit of the secret is greater than the last digit

5. What is your guess (or hint or quit)? 8055

Ok, I hadn't told you this before, but...
It's not 8055, because the secret's proper divisors are abundant

6. What is your guess (or hint or quit)? hint

Let's see...
the secret is a 4-digit integer, so 9000 possibilities
and, the secret is a multiple of 9, so 1000 possibilities
and, the secret's proper divisors are abundant, so 517 possibilities
and, the first digit of the secret is greater than the last digit, so 287 possibilities
Maybe 9936, 9846, 6372?

7. What is your guess (or hint or quit)? 6372

Ok, I hadn't told you this before, but...
It's not 6372, because the secret is NOT a multiple of 36

8. What is your guess (or hint or quit)? 9846

Ok, I hadn't told you this before, but...
It's not 9846, because the secret does NOT contain the digit '4'

9. What is your guess (or hint or quit)? 9936

Not 9936, because the secret is NOT a multiple of 36
(but you already knew all that)

10. What is your guess (or hint or quit)? hint

Let's see...
the secret is a 4-digit integer, so 9000 possibilities
and, the secret's proper divisors are abundant, so 2244 possibilities
and, the first digit of the secret is greater than the last digit, so 1369 possibilities
and, the secret does NOT contain the digit '4', so 822 possibilities
and, the secret is NOT a multiple of 36, so 743 possibilities
and, the secret is a multiple of 9, so 86 possibilities
Maybe 9702, 5022, 8262?

11. What is your guess (or hint or quit)? 8262

Ok, I hadn't told you this before, but...
It's not 8262, because the secret is a multiple of 4815

12. What is your guess (or hint or quit)? 4815

Not 4815, because the secret's proper divisors are abundant
Not 4815, because the first digit of the secret is greater than the last digit
Not 4815, because the secret does NOT contain the digit '4'
(but you already knew all that)

13. What is your guess (or hint or quit)? 9630

The answer was 9630.
Great job, 
You solved it in 13 guesses (versus 10 clues)
```
