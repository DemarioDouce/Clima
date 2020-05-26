import UIKit

//JSON weather structor
struct WeatherData: Codable {
    
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main:Codable {
    
    var temp: Double
    
}

struct Weather:Codable {
    
    var id: Int
}

