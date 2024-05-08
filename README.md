## Weather forecast application

This is a review of the My Weather Forecast app, introducing its main features and functions.

### App reviews

<table>
    <tr>
      <td><img src="https://github.com/BrianNguyen1507/weather-forecast-app/blob/main/assets/review/weather.gif" alt="home" width="200"></td >
    </tr>
</table>

### Project Overview

In this Weather Forecast app, users can get weather forecasts for their location. Here are the main features:

#### Home screen

The home screen shows current weather conditions, including temperature, weather icons, and location.
Users can view detailed weather information for the current day and upcoming days, including temperature, humidity, wind speed, and weather description.

#### Detailed screen

Allows users to view low and high-temperature predictions overtime periods.

### Implementation details

- Use [Open-meteo's](https://open-meteo.com/) weather API to get weather data, weather prediction, and [Geoapify](https://www.geoapify.com/ ) to get location data from longitude and latitude.
- Implement a clean and intuitive user interface using Flutter and Material Design.
- Handles location detection to automatically retrieve weather data for the user's current location.
- Implement error handling for network requests and location permissions.

### Begin
To get started with the Weather Forecast app:

1. Clone the repository:

``` bash
git clone https://github.com/BrianNguyen1507/weather-forecast-app.git
