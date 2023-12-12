# Sausage Roll Shop App

## Overview
The Sausage Roll Shop app is a Flutter-based mobile application designed for users to browse, select, and purchase various sausage rolls. It features a product listing, detailed item views, a basket system, and responsive design for different screen sizes.

## Features
- **Product Browsing**: Users can view a list of available sausage rolls.
- **Item Details**: Detailed view of each sausage roll, including pricing and description.
- **Basket Functionality**: Users can add items to their basket and view them on a separate basket page.
- **Responsive Design**: The app uses SizeConfig for a responsive UI compatible with various screen sizes.

## Dependencies Included
- **collection: ^1.18.0**
- **provider: ^6.1.1**
- **top_snackbar_flutter: ^3.1.0**
- **build_runner: ^2.4.7**
- **mockito: ^5.4.3**
- **mocktail_image_network: ^1.0.0**


## Getting Started
### Prerequisites
- Flutter SDK
- Dart SDK

## Usage
1. Clone the repo:
   ```bash
   git clone https://github.com/1TheGreatest/sausage_roll_app.git
2. Install the dependencies: flutter pub get
3. Run the app using the Flutter command: flutter run

## Screens
- **Home Page**: Displays the list of sausage rolls.
- **Item Detail Page**: Shows detailed information about a selected item.
- **Basket Page**: Users can view and manage items in their basket.

## Providers
- **ProductDataProvider**: Manages the fetching and state of product data.
- **BasketProvider**: Manages the state of the user's basket.

## Utilities
- **SizeConfig**: Utility for responsive sizing.
- **Constants**: Contains app-wide constants for theming and styling.
- **DetermineDayPart**: Determine the part of the day based on the given time.

## Models
- **SausageRoll**: Represents a sausage roll item.
- **BasketItem**: Represents an item in the user's basket.

## Contact
- **Name**: Solomon Ampomah
- **Email**: sampomahdev@gmail.com