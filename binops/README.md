Bitmasking is awesome. Today I was exploring the source code of apscheduler and while checking the events code I saw a code piece like `a | b` passed in.

Intutitively I found that is for listening to events `a` and `b` but I got curious how that was implemented. How the caller knows which events that I subscribed to?

There they used this `event.code & mask (a | b)`. They have their event codes in 2 powers like 2 ** 1, 2 ** 2, etc. Using this they are calling the callbacks for the events.

A good TIL. `|` gives us the mask with the positions in which `1` occurred in the inputs. When we do `&` with the event if we get 2 positions with `1` then it is a match. 

We don't need to worry about multiple results because we are here using only values with 2 ** n.
