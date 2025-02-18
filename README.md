quizzo

a frustrating math puzzle game

Example transcript:

```
$ ./quizzo.rb
There are 7 constraints on a secret number.
First, the secret is a 4-digit integer

1. What is your guess (or hint or quit)? 5500
Ok, I hadn't told you this before, but...
Not 5500, because the digits of the secret sum to 14

2. What is your guess (or hint or quit)? 5522
Ok, I hadn't told you this before, but...
Not 5522, because the secret contains the digit '0'

3. What is your guess (or hint or quit)? 5504
Ok, I hadn't told you this before, but...
Not 5504, because the secret is a multiple of 7

4. What is your guess (or hint or quit)? 5503
Not 5503, because the digits of the secret sum to 14
Not 5503, because the secret is a multiple of 7
(but you already knew all that)

5. What is your guess (or hint or quit)? 5502
Not 5502, because the digits of the secret sum to 14
(but you already knew all that)

6. What is your guess (or hint or quit)? 5501
Not 5501, because the digits of the secret sum to 14
Not 5501, because the secret is a multiple of 7
(but you already knew all that)

7. What is your guess (or hint or quit)? 5500
Not 5500, because the digits of the secret sum to 14
Not 5500, because the secret is a multiple of 7
(but you already knew all that)

8. What is your guess (or hint or quit)? 5499
Not 5499, because the digits of the secret sum to 14
Not 5499, because the secret contains the digit '0'
Not 5499, because the secret is a multiple of 7
(but you already knew all that)

9. What is your guess (or hint or quit)? hint
Let's see...
the secret is a 4-digit integer, so 9000 possibilities
and, the digits of the secret sum to 14, so 465 possibilities
and, the secret contains the digit '0', so 195 possibilities
and, the secret is a multiple of 7, so 28 possibilities
Maybe 3290, 4109, 8204?

10. What is your guess (or hint or quit)? 4109
Ok, I hadn't told you this before, but...
Not 4109, because the first digit of the secret is greater than the last digit

11. What is your guess (or hint or quit)? 8204
Ok, I hadn't told you this before, but...
Not 8204, because the secret contains the digit '5'

12. What is your guess (or hint or quit)? hint
Let's see...
the secret is a 4-digit integer, so 9000 possibilities
and, the digits of the secret sum to 14, so 465 possibilities
and, the secret contains the digit '0', so 195 possibilities
and, the secret is a multiple of 7, so 28 possibilities
and, the first digit of the secret is greater than the last digit, so 18 possibilities
and, the secret contains the digit '5', so 6 possibilities
Maybe 4550, 5054, 5180?

13. What is your guess (or hint or quit)? 4550
Ok, I hadn't told you this before, but...
Not 4550, because the secret is a multiple of 1145

14. What is your guess (or hint or quit)? hint
Let's see...
the secret is a 4-digit integer, so 9000 possibilities
and, the digits of the secret sum to 14, so 465 possibilities
and, the secret contains the digit '0', so 195 possibilities
and, the secret is a multiple of 7, so 28 possibilities
and, the first digit of the secret is greater than the last digit, so 18 possibilities
and, the secret contains the digit '5', so 6 possibilities
and, the secret is a multiple of 1145, so 1 possibilities
I don't want to spoil the surpise
type hint again if you really want to know

15. What is your guess (or hint or quit)? hint
Let's see...
the secret is a 4-digit integer, so 9000 possibilities
and, the digits of the secret sum to 14, so 465 possibilities
and, the secret contains the digit '0', so 195 possibilities
and, the secret is a multiple of 7, so 28 possibilities
and, the first digit of the secret is greater than the last digit, so 18 possibilities
and, the secret contains the digit '5', so 6 possibilities
and, the secret is a multiple of 1145, so 1 possibilities
Maybe 8015?

16. What is your guess (or hint or quit)? 8015
The answer was 8015.
Great job,
You solved it in 16 guesses (versus 7 clues)
```
