# Rentatouille - Your Property Rental Solution
Rentatouille is a mobile application designed to connect property owners with potential tenants. It simplifies the property rental process by providing a platform for property owners to list their properties and for tenants to discover and inquire about available rental options. With a user-friendly interface and robust features, Rentatouille makes property renting a breeze.

## Features
- **User Profiling**: Rentatouille supports two types of accounts: property owners and tenants. Property owners can list their properties, answer tenant inquiries, and manage their listings. Tenants can browse property listings, read reviews, and ask questions about specific properties.
- **News Information**: Tenants can stay informed about property-related news and updates right from their dashboard. They can also read news articles in an external browser for more details.
- **Uploading Information About Apartments**: Property owners can easily upload property details, including the number of bedrooms, property area, title, description, address, lounge availability, and monthly rent. They can also add images to showcase their properties.
- **Information about Rents**: Rentatouille automates rent record keeping. Tenants can review their payment history and upcoming payments, while property owners can track rent payments received.
- **Reviews & Questions About an Apartment**: Users can rate properties and leave reviews. They can also ask questions about specific properties, receive answers, and view them conveniently.

## Technical Requirements
- **Framework**: Rentatouille is built using Flutter and Dart for cross-platform mobile app development.
- **Database**: Cloud Firestore is used as the database to store user profiles, property listings, news articles, and rent payment records.
- **Authentication**: Firebase Authentication is employed for user registration and login, supporting Gmail and email credentials.
- **Media Storage**: Firebase Storage is utilized for storing media assets such as property images.
- **State Management**: Provider, BloC, or Riverpod (any except GetX) is used for managing app state and data flow.
- **User Interface**: The UI is designed to be attractive and user-friendly, enhancing the overall user experience.

## Installation
To run Rentatouille on your local development environment, follow these steps:

- Clone the repository to your local machine: ***git clone https://github.com/zeeshan564/Rentatouille-Dexplat.git***
- Navigate to the project directory: ***cd Rentatouille-Dexplat***
- Install dependencies: ***flutter pub get***
- Configure Firebase:
  - Create a Firebase project on the **Firebase Console**.
  - Set up Firebase Authentication with Gmail and email.
  - Set up Cloud Firestore and Firebase Storage.
  - Download the Firebase configuration file (google-services.json) and place it in the android/app directory.
- Run the app on an emulator or a physical device: ***flutter run***

## Usage
Here are some basic instructions on how to use Rentatouille:

- **User Registration and Login**: Sign up as a property owner or tenant using your Gmail or email credentials.
- **Property Listing**: Property owners can add their properties, including details like the number of bedrooms, area, title, description, address, lounge availability, and monthly rent. Upload images to make your listing attractive.
- **Tenant Features**: Tenants can browse property listings, read reviews, and ask questions about properties they are interested in. They can also stay updated with property-related news.
- **Rent Tracking**: Rent payments are automatically tracked, allowing tenants to review their payment history and upcoming payments.
- **Reviews and Questions**: Leave reviews for properties you've rented, and ask questions about properties you're interested in. Property owners can respond to tenant inquiries.
- **Stay Informed**: Check out property-related news and read articles in an external browser for more information.

## Contributing
We welcome contributions to make Rentatouille even better. If you have ideas for new features, bug fixes, or improvements, please open an issue or create a pull request. Be sure to follow our code of conduct.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
