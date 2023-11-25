# dhis2_practical_interview

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
This project
contain Three screen 
1: Splash Screen
2: Home with search screen
3: screen to view weatther searched data

i have created file called apidata.dart which is responsible for a different functions to fetch data  ,i created a functioon to get data from api open weather called api.openweathermap.org
i handled error on the catch method to throw the error when api fail to get data
catch (error) {
      print('Error fetching weather data: $error');
      throw error;
    }
also on homepage i displayed message when failed to load data throgh
else if (snapshot.hasError) {
                    return const Text(
                      'Error fetching weather data',
                      style: TextStyle(fontSize: 16.0),
                    );
                  }
and 
Run it through flutter run
also i have attaches screenshot of the project on screenshot folder
