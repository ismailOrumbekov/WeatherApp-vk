import Foundation


struct DailyWeatherForecast {
    let cityName: String
    let date: String
    let dayOfWeek: String 
    let condition: String
    let minTempC: Double
    let maxTempC: Double
    let hourlyTemps: [HourlyTemp]
    
    
    var formattedTempC: String {
            return formatTemp((maxTempC + minTempC)/2)
        }
    var progressValue: Float {
        let clampedTemp = min(maxTempC, max(minTempC, (minTempC + maxTempC)/2))
        let range = maxTempC - minTempC
        let progress = (clampedTemp - minTempC) / range
        return Float(progress)
    }

    var iconName: String {
        let trimmedCondition = condition.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        switch trimmedCondition {
            
        case "clear", "sunny", "bright":
            return "sun.max.fill"
        case "partly cloudy", "mostly clear", "mostly sunny", "partly cloudy":
            return "cloud.sun.fill"
        case "cloudy", "overcast", "partly cloudy":
            return "cloud.fill"
        case "patchy rain nearby", "light rain", "showers", "moderate rain":
            return "cloud.rain.fill"
        case "heavy rain":
            return "cloud.heavyrain.fill"
        case "snow", "light snow", "moderate snow", "heavy snow":
            return "snow"
        case "sleet", "light sleet", "heavy sleet":
            return "cloud.sleet.fill"
        case "hail":
            return "cloud.hail.fill"
        case "thunderstorm", "storm", "thunder":
            return "cloud.bolt.rain.fill"
        case "fog", "mist", "haze":
            return "cloud.fog.fill"
        case "dust", "smoke":
            return "smoke"
        case "windy", "breezy":
            return "wind"
        case "hot":
            return "sun.max.fill"
        case "cold":
            return "snow"
        default:
            print(trimmedCondition)
            return "questionmark"
        }
    }

}


struct HourlyTemp {
    let time: String
    let tempC: Double
    let condition: String
    
    var formattedTempC: String {
            return formatTemp(tempC)
        }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Исходный формат времени
        
        guard let date = dateFormatter.date(from: time) else { return "Unknown Time" }
        
        // Устанавливаем формат для отображения времени
        dateFormatter.dateFormat = "ha" // Формат времени с AM/PM
        return dateFormatter.string(from: date).uppercased()
    }
    
    var iconName: String {
        let trimmedCondition = condition.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)


        switch trimmedCondition {
        case "clear", "sunny", "bright":
            return "sun.max.fill"
        case "partly cloudy", "mostly clear", "mostly sunny", "partly cloudy":
            return "cloud.sun.fill"
        case "cloudy", "overcast", "partly cloudy":
            return "cloud.fill"
        case "patchy rain nearby", "light rain", "showers", "moderate rain":
            return "cloud.rain.fill"
        case "heavy rain":
            return "cloud.heavyrain.fill"
        case "snow", "light snow", "moderate snow", "heavy snow":
            return "snow"
        case "sleet", "light sleet", "heavy sleet":
            return "cloud.sleet.fill"
        case "hail":
            return "cloud.hail.fill"
        case "thunderstorm", "storm", "thunder":
            return "cloud.bolt.rain.fill"
        case "fog", "mist", "haze":
            return "cloud.fog.fill"
        case "dust", "smoke":
            return "smoke"
        case "windy", "breezy":
            return "wind"
        case "hot":
            return "sun.max.fill"
        case "cold":
            return "snow"
        default:
            print(trimmedCondition)
            return "questionmark"
        }
    }
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMb: Double
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let windchillC: Double
    let windchillF: Double
    let heatindexC: Double
    let heatindexF: Double
    let dewpointC: Double
    let dewpointF: Double
    let visKm: Double
    let visMiles: Double
    let uv: Double
    let gustMph: Double
    let gustKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

struct ForecastDay: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

struct Day: Codable {
    let maxTempC: Double
    let maxTempF: Double
    let minTempC: Double
    let minTempF: Double
    let avgTempC: Double
    let avgTempF: Double
    let maxWindMph: Double
    let maxWindKph: Double
    let totalPrecipMm: Double
    let totalPrecipIn: Double
    let totalSnowCm: Double
    let avgVisKm: Double
    let avgVisMiles: Double
    let avgHumidity: Int
    let dailyWillItRain: Int
    let dailyChanceOfRain: Int
    let dailyWillItSnow: Int
    let dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case maxTempF = "maxtemp_f"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case avgTempC = "avgtemp_c"
        case avgTempF = "avgtemp_f"
        case maxWindMph = "maxwind_mph"
        case maxWindKph = "maxwind_kph"
        case totalPrecipMm = "totalprecip_mm"
        case totalPrecipIn = "totalprecip_in"
        case totalSnowCm = "totalsnow_cm"
        case avgVisKm = "avgvis_km"
        case avgVisMiles = "avgvis_miles"
        case avgHumidity = "avghumidity"
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
    let isMoonUp: Int
    let isSunUp: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMb: Double
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let snowCm: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let windchillC: Double
    let windchillF: Double
    let heatindexC: Double
    let heatindexF: Double
    let dewpointC: Double
    let dewpointF: Double
    let willItRain: Int
    let chanceOfRain: Int
    let willItSnow: Int
    let chanceOfSnow: Int
    let visKm: Double
    let visMiles: Double
    let gustMph: Double
    let gustKph: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case snowCm = "snow_cm"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
}

struct Forecast: Codable {
    let forecastDay: [ForecastDay]

    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct WeatherData: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

func formatTemp(_ value: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .none
    numberFormatter.maximumFractionDigits = 0 
    return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
}
