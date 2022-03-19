import UIKit

// Enumerations
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain:
        return "hate"
    case .snow:
        return "meh"
    }
}

getHaterStatus(weather: .cloud)


// Enums with additional values
enum WType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHStatus(weather: WType) -> String? {
    switch weather {
        case .sun:
            return nil
        case .wind(let speed) where speed < 10:
            return "meh"
        case .cloud, .wind:
            return "dislike"
        case .rain, .snow:
            return "hate"
    }
}
