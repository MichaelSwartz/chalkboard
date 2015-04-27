[![Build Status](https://travis-ci.org/MichaelSwartz/chalkboard.svg?branch=master)](https://travis-ci.org/MichaelSwartz/chalkboard) [![Code Climate](https://codeclimate.com/github/MichaelSwartz/chalkboard.png)](https://codeclimate.com/github/MichaelSwartz/chalkboard) [![Coverage Status](https://coveralls.io/repos/MichaelSwartz/chalkboard/badge.png)](https://coveralls.io/r/MichaelSwartz/chalkboard)

# Chalkboard

Score rock climbing competitions using the latest rules. Record climbers attempts on routes organized by round. Chalkboard will automatically generate ranking scores for each route and round. Scoreboards are available for each route, round, and overall competition.

Currently uses rules for onsight bouldering competitions; support for sport, speed, and redpoint competitions may be added in the future.

## Scoring Rules Source

Uses [USA Climbing] (http://usaclimbing.net/rockcomps/resources/2014-1130%20USA%20Climbing%20Rule%20Book.pdf) rules, from November 30, 2014 update.

## Usage

Chalkboard is available at https://comp-chalkboard.herokuapp.com

Chalkboard is still in development and will continue to change drastically. If you use this to record an actual competition, please save the results locally, as the database may need to be reset as the app changes.

Sign up for an account to create your own competition. Other users will be able to see the competition, but not change it or record scores.

Follow the Athletes link in the top bar to add new athletes to the database.

Create a competition:

![alt text](http://i.imgur.com/btXW2GD.jpg)

Register athletes for your competition:

![alt text](http://i.imgur.com/CjFQ3A5.png)

Create rounds as needed, such as qualifier, semifinal, and final. Add routes and enter the maximum score for each route. Maximum score is determined by counting the number of hand holds, after the starting holds, that are on the route.

Record attempts for each athlete in turn. Determine score on an attempt by counting the hand holds leading up to the highest hold the athlete controlled. Record every attempt, even if it is not the athlete's best, as ties on a route are awarded to whichever athlete achieved the score in fewer attempts (which Chalkboard automatically calculates). If an athlete achieves the maximum score, record it normally; Chalkboard will recognize it as a "top." Only an athlete's highest score on each route will be used. 

![alt text](http://i.imgur.com/5uQPnCY.png)

Route rank and round rank are determined as follows, from the [USA Climbing] (http://usaclimbing.net/rockcomps/resources/2014-1130%20USA%20Climbing%20Rule%20Book.pdf) rulebook:

"Competitors shall be ranked based on the following:
  a) The total number of routes completed, or 'TOPS.'
  b) Each competitor shall be awarded Ranking Points for each route as follows:
    i. Where the competitor has a unique ranking on the route, equal to the ranking of the competitor in their Starting Group; or
    ii. Where two or more competitors are tied on the route, equal to the average ranking of the tied competitors in their Starting Group.
    Example: Where there are 6 ties at 1st place then the Ranking Points awarded to each tied competitor will be equal to (1 + 2 + 3 + 4 + 5 + 6) / 6 = 21 / 6 = 3.50
    Example: Where there are 4 ties at 2nd place then the Ranking Points awarded to each tied competitor will be equal to (2 + 3 + 4 + 5) / 4 = 14 / 4 = 3.50
  c) The ranking of competitors within their Starting Group shall be in descending order of the total number of “TOPS.” Those competitors with the same number of TOPS shall then be listed in ascending order of the Total Points awarded to each competitor (i.e. lower Total Points is better), calculated according to the following:
  TP = nth√ (R1 * R2 * R3)
  TP = Total Points
  R1 = Ranking Points on first route.
  R2 = Ranking Points on second route.
  R3 = Ranking Points on third route (included only if applicable)."

![alt text](http://i.imgur.com/mITKg7e.png)
