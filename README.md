# BabbelCodeChallengeiOS

Hello! I really enjoyed this challenge and greatly appreciate being considering for this position at Babbel. Please feel free reach out if you have any questions about my solution. Cheers! -Doug

## Summary
### How much time was invested?
Approximately 4 hours, with a couple coffee breaks :)

### How was the time distributed? (concept, model layer, view(s), game mechanics)
Around 15 minutes were spent at the start of the challenge to briefly brainstorm / get familiar with the project and how it should be architected and implemented.

The model and repository layers took around 45 minutes to implement, including writing the tests. This could have been achieved quicker, but I initially opted to implement a `FileService` that would abstract the loading of data from the file system to a separate architecture layer - a bit overkill for a project of this size, but useful if we wanted to extend app functionality and replace data loaded from file with an API service that would load data via HTTP. 

The next hour was spent implementing the view model, specifically the methods to fetch correct or incorrect word pairs from the word list (with a 25% rate of correctness), and tests for these methods. Writing tests as I went, along with each architecture layer, allowed me to correctly implement and iterate on business logic without a UI layer.

Another hour was spent implementing the UI layer, doing a small amount of layout/styling, adding counters for the correct/wrong attempts, and reviewing/finalizing the code I had written so far. At this point I was ready to commit milestone one.

The last remaining chunk of time was spent on milestone two, implementing the timer and “end conditions” for when the game would end+exit. I felt the implementation of these extra features was actually fairly straightforward, but I also see how my approach (specifically the timer implementation) would lead to problems in the future when attempting milestone three.

Finally some small code cleanup + UI styling was added after committing milestone two.

### Decisions made to solve certain aspects of the game
Architecture: knowing the scale of this challenge, and it’s relative small level of complexity, I opted for a straightforward MVVM architecture, with a separate/distinct data layer (`WordsRepository`) for loading the JSON. As previously mentioned, I originally wanted to implement another file service layer to abstract the loading of the raw data, which would allow for easy substitution in the future for either a different file system/database or API service. This MVVM pattern also allowed for straightforward testing, allowing me to mock the repository and easily test the view model.

Model: Using the `Decodable` protocol allowed me to easily decode+model the JSON structure in swift as `WordPair`, including using custom `CodingKeys` to easily implement more descriptive property names for `englishText` and `spanishText`.

Game logic: During my brief brainstorming/planning phase at the start of the project, I identified two main challenges when implementing the game logic: generating random incorrect pairs from the supplied list of correct pairs, and generating pairs at a 25% correctness rate. The latter problem proved more trivial to solve, my implementation generates a random `Int` between 1 and 4, and if the `Int` equals 1 then a correct word pair is generated, otherwise an incorrect pair in generated.

To generate the word pairs themselves I’ve implemented two methods, `getRandomCorrectPair()` and `getRandomIncorrectPair()`. `getRandomCorrectPair()` picks a new pair from the supplied wordlist (where all pairs are correct) but makes sure to check it against the previously displayed word pair to avoid repeats. `getRandomIncorrectPair()` gets two random pairs from the supplied wordlist, checks to make sure they’re not equal, then returns a new (and incorrect) word pair using the `englishText` of the first pair and the `spanishText` of the second pair.

Timer: I don’t have very much experience using the swift `Timer`, but I’m satisfied with the implementation I’ve written here. timer exists as a private property on the view model, allowing all the timer logic to stay in the VM layer.

### Decisions made because of restricted time
I made the decision early on to only implement up to milestone two, which put less time pressure on my implementation, so I don’t feel as if I had to cut corners in my implementation due to time constraints. The biggest decision made due to the time restriction however was choosing not to pursue a FileService and instead loading the file directly in the repository. I also ran out of time before I could write test coverage for the end conditions (i.e. making sure the game ends after 3 incorrect answers / 15 word pairs)

### What would be the first thing to improve or add if there had been more time?
I would love to implement milestone three, especially because it’s so UI-focused. I find UI work to be some of the most finicky but rewarding work in iOS development.

If instead I focused on improving my implementation for milestone two, my first priorites would be:
- Moving the “game constants”, i.e. timer length and end condition values, to stored properties on the VM - this would make them easier to change in the future, or make it easier to implement a settings screen where the user could define the game rules.
- Test coverage for the “end conditions” (making sure the game ends after 3 incorrect attempts / 15 word pairs)
- Handling errors in the VM (i.e. when unwrapping word pairs), and implementing UI to display these errors to the user. I implemented a `@Published` property on the VM for this purpose but never used it in the UI.
- Implementing a custom extension of the swift `Timer` class.
