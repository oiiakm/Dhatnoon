<!DOCTYPE html>
<html>

<head>
 
</head>

<body>

<h1>Dhatnoon</h1>

<h2>Project Structure Overview</h2>

<ul>
  <li><strong>Presentation Layer:</strong> User interface and interactions. It includes folders for UI pages and reusable widgets.</li>
  <li><strong>Domain Layer:</strong> Core business logic, use cases, and repositories. The "repositories" folder is used for managing data access.</li>
  <li><strong>Data Layer:</strong> Data sources, repositories, and data models. Repositories handle data access, and data sources connect to external services or databases.</li>
  <li><strong>Core:</strong> Shared code across the project, including custom exceptions, network utilities, error handling, and utility functions.</li>
</ul>

<h2>Project Structure</h2>

<pre>
lib/
├── core/
│   ├── exceptions/
│   ├── network/
│   ├── utils/
│   └── errors/
├── config/
│   ├── routes/
│    
├── features/
│   ├── feature_name1/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   ├── domain/
│   │   │   ├── usecases/
│   │   │   ├── repositories/
│   │   └── data/
│   │   │   ├── repositories/
│   │   │   ├── data_sources/
│   ├── feature_name2/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   ├── domain/
│   │   │   ├── usecases/
│   │   │   ├── repositories/
│   │   └── data/
│   │   │   ├── repositories/
│   │   │   ├── data_sources/
└── main.dart
</pre>

<h2>Getting Started</h2>
<p>Follow these steps to get started with the project:</p>

<ol>
  <li><strong>Clone the repository from GitHub:</strong></li>
  <code>git clone https://github.com/oiiakm/Dhatnoon.git</code>

  <li><strong>Navigate to the project's root directory:</strong></li>
  <code>cd Dhatnoon</code>

  <li><strong>Install dependencies:</strong></li>
  <code>flutter pub get</code>

  <li><strong>Check for Flutter setup and connected devices:</strong></li>
  <code>flutter doctor</code>

  <li><strong>Run the app:</strong></li>
  <code>flutter run</code>
</ol>

<h2>Contributions and Bug Reporting</h2>
<p>Your contributions, whether for features, bug fixes, testing, or documentation, are highly valued. When creating pull requests, please label them as follows:</p>
<ul>
  <li><strong>feat:</strong> for new features</li>
  <li><strong>fix:</strong> for bug fixes</li>
  <li><strong>test:</strong> for testing contributions</li>
  <li><strong>docs:</strong> for documentation changes</li>
</ul>
<p>If you have questions or need assistance, please feel free to reach out! 😊</p>

</body>
</html>
