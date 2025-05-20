# MazeWatch

MazeWatch is a feature-complete iOS application built for the **Jobsity iOS Developer Code Challenge**, which is based on the public [TVmaze API](https://www.tvmaze.com/api). The app demonstrates a production-grade implementation of the requested features using SwiftUI, CoreData, MVVM architecture, protocol-oriented networking, and modern iOS best practices.

---

## ✨ Features

- ✅ **TV Series Listing**
  - Paginated list of series using the TVmaze API.
  - Pull-to-refresh support.
  - Series cards styled like Apple TV with support for light/dark mode.

- ✅ **Search**
  - Search for series by name with live feedback.
  - Empty and no-results states with contextual icons and messages.

- ✅ **Series Details**
  - View full details of a selected show: name, schedule, genres, summary.
  - Displays episodes grouped by season.

- ✅ **Episode Details**
  - View episode info: name, season/number, summary, and thumbnail (if available).

- ✅ **Favorites**
  - Save/unfavorite series using Core Data.
  - Alphabetical sorting toggle.
  - Swipe-to-delete functionality.
  - Empty state messaging.

- ✅ **People Search (Bonus Feature)**
  - List people from the API with image and name.
  - View person details and list of series they participated in (with links to series details).

- ✅ **Security (Bonus Feature)**
  - App lock using a custom PIN.
  - Optional biometric authentication (Face ID / Touch ID).

---

## ▶️ How to Run the Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/MazeWatch.git
   ```

2. **Open the project in Xcode:**
   Double-click the `MazeWatch.xcodeproj` file

3. **Build & run:**
   - Ensure you are targeting an iOS 17+ simulator.
   - Hit ⌘R or use the play button in Xcode.

4. **Optional:** Enable biometric authentication in your iOS simulator under Settings > Face ID & Passcode.

---

## 🔁 Architecture & Structure

- **MVVM** with strict separation of responsibilities.
- **Protocol-Oriented Networking**: APIClient and APIClientProtocol.
- **Reusable Components**: e.g., `SeriesCardView` reused across multiple screens.
- **CoreData** used for persistent favorite storage.
- **Modular File Structure**:

```
MazeWatch/
├── App/
│   ├── AppEnvironment
│   ├── AppRouter
│   ├── ContentView
│   ├── MainTableView
│   └── MazeWatchApp
├── Core/
│   ├── Models/ (Episode, Person, Series, Shared)
│   ├── Networking/
│   │   ├── APIClient
│   │   ├── APIClientProtocol
│   │   └── Endpoints
│   └── Storage/
│       ├── FavoriteSeriesStorage
│       ├── MazeWatch.xcdatamodeld
│       └── Persistence
├── Previews/
│   └── PreviewAPIClients
├── Resources/
│   └── Assets.xcassets
├── Scenes/
│   ├── EpisodeDetail
│   ├── Favorites
│   ├── LockScreen
│   ├── PeopleSearch
│   ├── SeriesDetail
│   ├── SeriesList
│   ├── SeriesSearch
│   └── Settings
├── Tests/
│   ├── Mocks
│   ├── UITests
│   └── UnitTests
└── Utilities/
    └── Extensions
```

---

## ✅ Test Coverage

- **Unit Tests**
  - ViewModels covered with mock API clients.
  - Favorites logic tested with mock storage.

- **UI Tests**
  - Pagination behavior.
  - Empty/loading states.
  - Detail navigation flows.
  - Search and sort behaviors.

- **Previews**
  - SwiftUI previews with `PreviewAPIClientEmpty`, `PreviewAPIClientLoading`, and `MockAPIClient` for all major views.

---

## 📷 Screenshots

| TV Series Listing | Series Detail | Series Search |
|-------------------|----------------|----------------|
| screenshot | screenshot | screenshot |

| People Search | People Details | Settings |
|-------------------|----------------|----------------|
| screenshot | screenshot | screenshot |

| Lockscreen |
|-------------------|
| screenshot |

---

## ⚙ Technologies Used

- Swift 5.9+
- SwiftUI
- CoreData
- XCTest
- Biometric Authentication (Face ID / Touch ID)

---

## 🌟 Highlights

- Clean, modern UX with accessibility support.
- Fully offline-compatible favorites via CoreData.
- Testable and scalable thanks to modularity and protocol conformance.
- Elegant error/empty/loading states.
- Passed all base and bonus requirements outlined in the challenge brief.

---

## 🎓 Author

Built with care by Jesus Rojas for the Jobsity iOS Developer Challenge.
