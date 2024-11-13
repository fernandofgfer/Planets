# Astral Map Code Challenge

This repository contains my implementation of the Astral Map code challenge in Swift. The focus of this project is on handling model logic and API interactions, with a simple MVVM structure to support iOS functionality.

## Table of Contents
- [Project Structure](#project-structure)
- [Model Layer](#model-layer)
- [iOS Project](#ios-project)
- [API Logic](#api-logic)
- [Tests](#tests)
- [Future Improvements](#future-improvements)

## Project Structure

The project is structured with a basic MVVM architecture, separating the logic layers from the UI and allowing clear testability and scalability of the core functionalities. Although the MVVM pattern is kept simple in this challenge, in a production environment, this structure could be expanded to better support more complex functionalities and data flows.

## Model Layer

To represent the astral map:

- **Enum for Astral Types**: An enum has been created to encapsulate all astral types, providing a clear and type-safe way to work with each type.
- **Map Representation**: A map structure stores an array of arrays of astral types, representing the full astral map.
- **Position Model**: A model for specifying a position on the map where updates will occur, simplifying interactions with the API.

## iOS Project

Since the challenge does not focus on iOS architecture or UI, I’ve implemented a minimal MVVM structure to handle basic interactions:

- **ViewModel**: The ViewModel handles the map updates and interactions with the API. In a production setup, logic for updating the map would be abstracted into a dedicated data layer to maintain a clean separation of concerns and facilitate scaling.

## API Logic

To handle API calls, I’ve created a simple `APIClient` and two separate data sources:

1. **Map Info Data Source**: For fetching the map data.
2. **Astral Type Update Data Source**: For updating a specific astral type on the map.

### Network Throttling

Initially, I aimed to handle map updates concurrently. However, due to server constraints, concurrency led to multiple 429 HTTP (rate limit) errors. After testing various options, I switched to a serial approach for API calls to reduce errors.
For retrying failed requests, I tested two approaches:

- Adding a fixed delay between each network call.
- Adding a delay only when a 429 error occurs.

After testing, I found that the second approach, which adds a delay only when a 429 error happens, is faster. This is the method I implemented, as it optimizes speed while still minimizing the chance of hitting rate limits.

## Tests

Although testing was not required in the challenge, I added unit tests for the model layer, as it’s a key component of the project. In a production scenario, additional tests would cover all core functionalities, including network interactions and ViewModel logic.

## Future Improvements

In a real-world implementation, I would consider the following enhancements:
- **Layered Architecture**: Extracting the map update logic to a dedicated layer to keep the ViewModel lightweight.
- **Error Handling and Retries**: Adding more robust error handling, including exponential backoff for retries.
- **Comprehensive Testing**: Expanding tests to cover network and ViewModel logic, ensuring complete test coverage across the project.
