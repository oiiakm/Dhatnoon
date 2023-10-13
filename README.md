<!DOCTYPE html>
<html>
<head>
  
</head>
<body>

<h1>Dhatnoon</h1>

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

<h2>Project Structure Overview</h2>

<ul>
  <li><strong>Presentation Layer:</strong> User interface and interactions. It includes folders for UI pages and reusable widgets.</li>
  <li><strong>Domain Layer:</strong> Core business logic, use cases, and repositories. The "repositories" folder is used for managing data access.</li>
  <li><strong>Data Layer:</strong> Data sources, repositories, and data models. Repositories handle data access, and data sources connect to external services or databases.</li>
  <li><strong>Core:</strong> Shared code across the project, including custom exceptions, network utilities, error handling, and utility functions.</li>
</ul>

</body>
</html>
