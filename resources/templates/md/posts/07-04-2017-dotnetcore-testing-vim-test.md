{:title  "Using vim-test to run dotnet test with core cli tooling"
 :layout :post
 :date   "07-04-2017"
 :image  "http://i.imgur.com/moEuXDY.jpg"
 :tags   ["dotnet core" "vim" "workflow" "testing" "vim-test"]}


### Overview

[vim-test](https://github.com/janko-m/vim-test) is a really cool vim plugin for running tests and getting results within [neo]vim. It has support for many programming languages and test runners. 

[vim-test](https://github.com/janko-m/vim-test) also support for a range of "test execution strategies", for example, the `make` strategy will execute tests using regular `:make`, and the `dispatch` strategy will execute tests using `:Dispatch`. 

There are a number of other strategies, both synchronous and asynchronous, so there is a good chance you can fit it into your existing workflow.

### Commands

Without going into too much detail [vim-test](https://github.com/janko-m/vim-test) makes available the following commands. 

#### `:TestSuite`

This runs all the tests in the current suite. I tend to use this when I've finished working on something and want to make sure that all tests are still passing.

#### `:TestFile`

This command runs all tests in the current file. This is the command I use most frequently, followed up by a `:TestSuite` when I'm ready.

#### `:TestNearest`

This command runs the test nearest to the cursor, I find this useful when I'm debugging a single failed acceptance test, or any test that is part of a slower suite of tests, and I want to keep running that test over and over while making changes to the test body.

#### `:TestLast`

This command runs the last test that was executed, this is pretty handy if you are jumping around files trying to resolve an issue with the most recently failed tests and you want to run the tests again *without* jumping back to the test file.

#### `:TestVisit`

This command returns you to the test file where the last tests were executed from. This is particularly handy for jumping back to a failed test after modifying some code elsewhere.

### Some context

[vim-test](https://github.com/janko-m/vim-test) is very easy to extend, it is possible for the above commands to have different context based on the language and test runner being used, for instance, I recently had [a PR](https://github.com/janko-m/vim-test/pull/179) merged that adds support for `C#` and the `dotnet test` runner. The context for the above commands
becomes. 

#### `:TestSuite`

This runs all the tests in current project by walking up the directory structure until it finds a `.csproj` file to use in it's call to `dotnet test`.

Example generated commands: 
`dotnet test /home/markwoodhall/code/Project/Tests/Tests.csproj`

#### `:TestFile`

This command runs all tests in the current `.cs` file, again  walking up the directory structure until it finds a `.csproj` file to use in it's call to `dotnet test`. This time we also take the name of the current file to use in the `--filter FullyQualifiedName~` option to `dotnet test`.

Example generated commands: 
`dotnet test /home/markwoodhall/code/Project/Tests/Tests.csproj --filter FulyQualifiedName~MyTestClass`

#### `:TestNearest`

This command runs the nearest test to the cursor, again  walking up the directory structure until it finds a `.csproj` file to use in it's call to `dotnet test`. This time we also figure out the nearest test based on regex patterns for the current class or function.

Example generated commands:
`dotnet test /home/markwoodhall/code/Project/Tests/Tests.csproj --filter FulyQualifiedName~MyTestClass`

`dotnet test /home/markwoodhall/code/Project/Tests/Tests.csproj --filter FulyQualifiedName~MyTestClass.MyTestMethod`

`dotnet test /home/markwoodhall/code/Project/Tests/Tests.csproj --filter FulyQualifiedName~MyTestClass.MyTestMethodAsync`

### Screenshots

![Screenshot](http://i.imgur.com/s4MKWGG.gif)

Thanks a lot to [Janko Marohnić](https://twitter.com/jankomarohnic) for creating [vim-test](https://github.com/janko-m/vim-test) and for helping with the pull request.

