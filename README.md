# Fitness Tracker App

A cross-platform fitness tracking application built with **Flutter**.

The project is currently under development and will serve as the mobile client for a fitness tracking platform focused on creating workouts, tracking exercises, sets, reps, weight, and RIR.

## Current Features

- Start Workout page
- Workout exercise cards
- Dynamic exercise set display
- Add new sets during a workout
- Inputs for:
  - Weight
  - Reps
  - RIR
- Basic input validation
- Responsive sizing using `MediaQuery`
- Custom color palette and reusable UI components

## Current Workout Flow

```text
Start Workout
     ↓
Workout Page
     ↓
Exercise Card
     ↓
Set | Weight | Reps | RIR
     ↓
Add Set
```

Each exercise contains its own list of sets, which can be dynamically expanded while the workout is being created.

## Tech Stack

- Flutter
- Dart
- Material UI

## Planned Features

- Add Exercise page
- Exercise search and selection
- Remove exercises
- Remove sets
- Workout name editing
- Finish Workout functionality
- Workout validation
- Backend API integration
- Authentication
- Workout history
- Exercise history
- Personal records
- Training goals
- Pagination and filtering
- Loading and error states

## Backend

The application is planned to integrate with a separate **Spring Boot REST API** responsible for authentication, workout management, exercises, personal records, and other fitness-related data.

## Project Status

🚧 **Work in Progress**

The current focus is building the workout creation flow and establishing the core Flutter architecture before connecting the application to the backend API.
