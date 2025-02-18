Pemo Demo

📌 Overview

Pemo Demo is a Flutter application that allows users to manage their cards and transactions. It follows the Clean Architecture approach with a feature-first structure, ensuring scalability and maintainability.

✨ Features

Cards Management: Add and view cards with details like name, holder name, color, and balance.

Transactions: Fetch transactions from a remote API and cache them using Hive for offline access.

🏗️ Architectural decisions

Use clean architicture to ensure hight code reliability

Remove use cases from domain layer as we already have Bloc (Business Logic Component)

Use get it in dependency injection , injecting abstractions rather than implementation to ensure Depandency inversion


🏗️ Architecture

The project is built using Clean Architecture with three layers:

Domain Layer: Contains business logic (Blocs) and core entities and repositories abstraction.

Data Layer: Has data sources(repository implementations) , Data transfer objects 

Presentation Layer: Handles UI development using Flutter widgets.



📂 Folder Structure

Pemo Demo
│── core/                # Shared utilities and configurations, dependency injection
│── features/            # Feature-based modules
│   ├── cards/           # Cards feature
│   │   ├── data/        # Data handling (repository implementations, Dtos)
│   │   ├── domain/      # state management(bloc) , abstract repository and entities
│   │   ├── presentation/# UI components (widgets, )
│   ├── transactions/    # Transactions feature
│       ├── data/        # Data handling (repository implementations (local and remote), Dtos)
│       ├── domain/      # state management(bloc) , abstract repository and entities
│       ├── presentation/# UI components for transactions
│── theme/               # App-wide styling and themes
│── home_screen.dart     # Main Page of app with 2 tabs , a tab for each feature
│── main.dart            # App initialization

🚀 Getting Started

Prerequisites

Install Flutter: [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)


Installation

Clone the repository:

git clone https://github.com/your-repo/pemo-demo.git
cd pemo-demo

Install dependencies:

flutter pub get

Run the app:

flutter run

📌 Future improvement suggestions

Add pagination to transactions as they may grow in size 

Add more details to transaction and show it in transaction details page 

Add deposit and withdraw functions to cards

Add widget test for add card widget

General ui enhancements



📌 Technologies Used

Flutter: Cross platform App development framework

Dart: Programming language

Hive: Local database for offline caching




🔹 Happy coding! 🚀