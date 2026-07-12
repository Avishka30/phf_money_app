# PHF Money Management App

## Overview
[cite_start]Offline-first Flutter money management app built using Clean Architecture. [cite_start]The application is designed to help users track personal or small-business income and expenses[cite: 29].

## Features Completed
- **Accounts**: Create and view accounts (Cash, Bank, Wallet).
- **Transactions**: Add income/expense transactions and view the history list.
- **Dashboard**: Real-time updates for total balance and financial overview.
- **Budget Tracking**: UI implementation for monthly budget monitoring.
- [cite_start]**Clean Architecture**: Structured into Presentation, Domain, and Data layers for scalability[cite: 68].

## Tech Stack
[cite_start]Flutter, Riverpod, GoRouter, intl, fl_chart, uuid, equatable.

## How to Run
1. `flutter pub get`
2. `flutter run`

## How to Build APK
`flutter build apk --release`

## Known Issues
- **Local Persistence**: The integration of Drift/SQLite is currently incomplete. [cite_start]Data is handled via in-memory state management during the current MVP phase.
- **Reports**: Advanced category breakdown charts are pending final integration.

## Handover Notes
- **Completed**: Core UI, Navigation, State Management (Riverpod), Account/Transaction logic.
- **Pending**: Full local database persistence (Drift) and advanced reporting charts.
