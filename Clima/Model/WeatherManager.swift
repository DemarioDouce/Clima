
struct WeatherManager {
    
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?units=metric&appid=5c5d6e30ba72c04e9d014b3a7c6c57af"
    
    func getWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        print(urlString)
    }
}
