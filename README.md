
# Exercise App Case Study

This is a simple exercise app developed as part of a case study. The app provides an exercise overview screen, allows users to favorite exercises, and offers a training session with a series of exercises displayed one by one. This README outlines the project setup, structure, and core features.

## Table of Contents

- [Features](#features)
- [Setup](#setup)
- [Usage](#usage)
- [API](#api)
- [Persistence](#persistence)

---

## Features

1. **Exercise Overview Screen**: Displays a list of exercises, each with an image and name. Users can mark exercises as favorites.
2. **Favorite Persistence**: Favorites are stored locally, allowing users to see their selections upon reopening the app.
3. **Training Session**: Users can start a training session that presents each exercise individually on an Exercise Screen, automatically progressing every 5 seconds.
4. **Exercise Screen**: Displays an image of the exercise, allows users to mark/unmark it as a favorite, and provides the option to cancel the training session.

---

## Setup

### Prerequisites

- **iOS 15 or higher** (adjust as needed depending on deployment target)
- **Xcode 13+**
- **Swift Package Manager** or **CocoaPods** (if external libraries are required)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/kaia-exercise-app.git
   cd kaia-exercise-app
   ```

2. Open the project in Xcode:
   ```bash
   open KaiaExerciseApp.xcodeproj
   ```

3. Build and run the app on the iOS simulator or a connected device.

---

## Usage

1. **Exercise Overview**:
   - Upon opening the app, users are presented with a list of exercises from the provided API.
   - Users can favorite exercises by tapping the star icon next to each exercise. Favorites are stored locally.

2. **Start Training Session**:
   - By tapping the “Start Training” button, a session begins where exercises are shown one at a time on the Exercise Screen.
   - Each exercise screen displays for 5 seconds before automatically transitioning to the next exercise.

3. **Exercise Screen**:
   - While on the Exercise Screen, users can favorite/unfavorite the current exercise and cancel the session to return to the Exercise Overview screen.

4. **Session Completion**:
   - After the last exercise, the app returns to the Exercise Overview screen.

---

## API

The exercises are loaded from an API endpoint. The response format should resemble the following:

```json
[
  {
    "id": "1",
    "name": "Push-Up",
    "image_url": "https://example.com/pushup.png"
  },
  {
    "id": "2",
    "name": "Squat",
    "image_url": "https://example.com/squat.png"
  }
]
```

- **Endpoint**: [Endpoint](https://jsonblob.com/api/jsonBlob/027787de-c76e-11eb-ae0a-39a1b8479ec2)
- **Method**: GET
- **Response**: JSON array of exercise objects with `id`, `name`, and `image_url` properties.

---

## Persistence

Favorite states are stored locally, enabling users to retain their selections across app sessions. This is implemented using UserDefaults.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

If you have questions, please contact [letaief.aymen@gmail.com](mailto:letaief.aymen@gmail.com).
