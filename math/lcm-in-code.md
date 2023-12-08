https://adventofcode.com/2023/day/8

Today while solving advent of code 2023 day 8 part 2, I found an interesting pattern,

11A 22A
11B 22B
11Z 22C
11B 22Z
11Z 22B
11B 22C
11Z 22Z

11B 22B
11Z 22C
11B 22Z
11Z 22B
11B 22C
11Z 22Z

(Repeats...)

We can see that 11A reaches 11Z after every 2 steps and 22A reaches 22Z after every 3 steps. In the 6th step they both have reached Z. 
That's the step we need to find.

I noticed this pattern but could't exactly figure out what it is at that time. So I tried different approaches to find the solution with the original input.

Eventually, a fellow learner from The Odin Porject discord pointed that it is LCM. So I took LCM for the original input logic and got the answer immediately.

Before that my code was running indefinitely ;)

So I want to note it down here for my future reference. LCM is cool. When every entity reaches or changes same number of times, they will meet at one point eventually.
That'll be LCM, minimum value at which the points meet. The answer is the step at which every node reaches Z for the first time.

So the least & common multiple of all of the given numbers is the point at which every input will meet, 
If they add by itself or a cycle through same number of appearances (11B, 11Z, 11B, 11Z).

In the example's case that is the pattern 2, 4, 6, 8,... 3, 6, 9,...
