import UIKit

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=5c5d6e30ba72c04e9d014b3a7c6c57af"
    
    //attach the cityname to the weather url const
    func getWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        
    }
    
    //Networking
    func performRequest(urlString: String)  {
        
        //1. Create a URL
        let url = URL(string: urlString)
        
        //2. Create a URLSession
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        let task = session.dataTask(with: url!, completionHandler: handle(data:response:error:))
        
        //4. Start the task
        task.resume()
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
