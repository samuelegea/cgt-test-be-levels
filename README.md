# CGTrader Level System

The goal of this task is to test your ability to test, refactor and implement new functionality on a given system. Note
that this repository does not represent the actual code of CGTrader, but only acts as a testing ground.

## New Functionality

Imagine the situation where management assigns you a task. Management wants that the system would automatically reward
users or reduce their tax rate when they level up. Users are supposed to have a combination of rewards and privileges
based on their user level. The only privilege in this case is tax reduction. However, management is not sure if that
will always be the case, so you, as a developer, should make changes with the idea that requirements for this may change
and the functionality should be flexible.

## Tasks

1. Make sure test suite runs through all of the tests successfully. Hint: it won't at first.
2. Refactor implementation code and tests where you see fit. You have as much freedom here as you wish.
3. Implement new functionality.

## Notes & Requirements

* You can spend as much time as you want.
* You may refactor not only the application code, but the tests too. Keep in mind that test code is still code that
needs to be maintained.
* Use git to track your changes. **Fork or clone this repository** and commit often.
* When finished, send us the link or the zip of the project via e-mail.

Good luck!


## FEEDBACK

Also, I am sharing feedback about your task. If you have some counter-feedback, that’s warmly welcome :)

### Pros

* Code does what is expected ✅
* All specs pass ✅
* Used lets in specs ✅
* Decent specs ✅
* Gem versions unlocked in gemspec ✅
* Nice organization of models and associations (`has_and_belongs_to_many`) ✅
* Replaced attr_reader `:level` with association ✅
* Code is easy to understand ✅


### Cons

* Level up does increase coins, but by a constant amount - this should be configurable in Privilege. Furthermore, tax_reduction is unaffected. It feels like the implementation is incomplete. Did you stop because of time pressure? 🤔
  * Corrected in this new version. It is now not only configurable but it has a suggestions about how could it be, regarding progression, altough it has a basic implementation
  * The tests for this implementations could be better
* Multi-level upgrades do not work
  * I works now! 😁
* Level-down does not work, although it's not mentioned explicitly in readme requirements either
  * I works now! 😁

### Nitpicks

* Database could use some more null: falses
  * Really nice tip, implemented ✅
* Instead of self.level_id = matching_level.id, one could skip the _id part: self.level = matching_level
  * Really nice tip, implemented ✅
* Could use the new beginless range ruby syntax in CgtraderLevels::Level.where(experience: ..reputation)
  * Really nice tip, implemented ✅
* Did not use rubocop for cody styling (but did use in GH actions)
  * Sorry for that, it is now configured and correctly used 😅
* One could argue a simple update_column is preferable to the somewhat rare (at least from my experience) self.class.update_counters method
  * There's a good discussion around it, and it goes down by preference in most cases, but I wasn't really happy either with the `update_counters`, and exchanged to `self.increment`, that it is a instance method and it's suits well in some edge cases, such as when value is `nil`.
* The 2 DB tranasactions in set_new_level could be merged for better performance
  * Good point, I changed so there's no transactions in this method, and it runs before saving, which scapes any transaction, since the database commit will have the increments and column alterings from memory instead directly from previous transactions.
  * That being said, there's other gaps in performance, that could be issued, and some memoization techniques could be applied, such as geting `matching_level` several times in one operation.

### Notes

* GitHub actions is a nice touch!
* There's still room for code and performance improvement, and more flexibility in the tests as well, but I choose to stop here for the moment.
* Corrected issues pointed and implemented level-ups and downs. It's somewhat extensible code, allowing other types of benefits and punishments for leveling down (for instance)

Conclusion
7/10. Nice and easy to understand code. But incomplete(?) and missing multi-level upgrades (and level-downs).
