import Foundation

struct WeatherManager {

    public static let shared = WeatherManager()
    
    func fetchWeather(for city: String, completion: @escaping ([DailyWeatherForecast]) -> Void) {
        let apiKey = "7109bc48d1b945eab4b105923240809"
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=10&aqi=no"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                
                var dailyForecasts: [DailyWeatherForecast] = []
                
                for forecastDay in weatherData.forecast.forecastDay {
                    let dayOfWeek = dayOfWeek(from: forecastDay.date)
                    
                    let hourlyTemps: [HourlyTemp] = forecastDay.hour.filter { hour in
                        let hourString = hour.time.split(separator: " ").last ?? ""
                        return ["00:00", "06:00", "12:00", "18:00", "23:00"].contains(hourString)
                    }.map { hour in
                        HourlyTemp(time: hour.time, tempC: hour.tempC, condition: hour.condition.text)
                    }
                    
                    let dailyForecast = DailyWeatherForecast(
                        cityName: weatherData.location.name, 
                        date: forecastDay.date,
                        dayOfWeek: dayOfWeek,
                        condition: forecastDay.day.condition.text,
                        minTempC: forecastDay.day.minTempC,
                        maxTempC: forecastDay.day.maxTempC,
                        hourlyTemps: hourlyTemps
                    )
                    
                    dailyForecasts.append(dailyForecast)
                }
                
                DispatchQueue.main.async {
                    completion(dailyForecasts)
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }



    func dayOfWeek(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "Unknown" }
        
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    
}
