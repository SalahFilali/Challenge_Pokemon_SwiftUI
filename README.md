# Pokemon_SwiftUI
An iOS project collect Pokemons developped with SwiftUI. 

> ### To run this project you will need to have XCode 13 or later.

----------

## Contents

* [Code overview](#code-overview)
    * [Folders](#folders)

* [Personal choices](#Personal-choices)

----------

# Code overview

## Folders

- `Data Layer` - Contains all the Data layer related classes.
- `UI Layer` - Contains all user interfaces and UI related class.
- `Global` - Contains all classes used globally inside the project.
- `Resources` - Contains all resources files.

----------

# Personal choices

## MVVM

The MVVM pattern allows separating the View layer from the logic. This separation will make projects more clean, more maintainable and unit testing friendly.

## Repository pattern

The use of this pattern makes the code more maintainable and testable, it also helps keep the code organised and avoiding duplication, as database queries and WS calls are kept in one place. While this benefit is not immediately apparent in small projects, it becomes more observable in large-scale projects which have to be maintained for many years.

