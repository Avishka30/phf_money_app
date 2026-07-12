# PHF Money Management App

## Overview
Offline-first Flutter money management app built using Clean Architecture. The application is designed to help users track personal or small-business income and expenses.

## Features Completed
- **Accounts**: Create and view accounts (Cash, Bank, Wallet).
- **Transactions**: Add income/expense transactions and view the history list.
- **Dashboard**: Real-time updates for total balance and financial overview.
- **Local Persistence**: Data is successfully saved locally using SharedPreferences, ensuring data remains intact after app restarts (MVP requirement met).
- **Budget Tracking**: UI implementation for monthly budget monitoring.
- **Clean Architecture**: Structured into Presentation, Domain, and Data layers for scalability.

## Tech Stack
Flutter, Riverpod, GoRouter, shared_preferences, intl, fl_chart, uuid, equatable.

## How to Run
1. `flutter pub get`
2. `flutter run` (or `flutter run -d edge` for web testing)

## How to Build APK
`flutter build apk --release`

## Known Issues
- **Database Implementation**: The integration of Drift/SQLite is pending. To meet the offline-first MVP deadline seamlessly, `shared_preferences` was utilized as a reliable alternative to ensure local data persistence.
- **Reports**: Advanced category breakdown charts are pending final integration.

## Handover Notes
- **Completed**: Core UI, Navigation, State Management (Riverpod), Account/Transaction logic, and Local Data Persistence (via SharedPreferences).
- **Pending**: Migration to Drift/SQLite for advanced relational querying and advanced reporting charts.
