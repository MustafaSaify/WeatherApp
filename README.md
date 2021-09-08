# WeatherApp
Simple weather app to view weather forecast for a city

## Code Overview

The code is implemented in below layers

- Network Layer (Responsible for making network request)
- Data Layer (Responsible for providing data in pages)
- Presentation Layer (Responsible for displaying data)
- Domain Layer (Usecases and entities )

The app consists of below modules

- Scenes:
    - Weather List - Fetches and displays weather forecast for next 3 days.
    - Weather Details - Displays hourly weather forecast for selected day.

- Network Module : 
    - Responsible for making network request.

- Data Module : 
    - Responsible for fetching data in pages.
    - Repository, Datasources.
    
- Presentation Module : 
    - Responsible for presentation logic.
    - Views, ViewModels, DisplayModelMappers.



## Architecture Design Pattern

The app is architected using the MVVM Architecture following the SOLID principles and responsibilities divided across different layers.


## Testability

- Unit Tests.   


## Future Enhancements:

- Better test coverage.
- To allow user to select a city from a list and load data accordingly.
- Support for different enviornments.

