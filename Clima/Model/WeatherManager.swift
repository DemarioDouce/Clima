import UIKit

protocol WeatherManagerDelegate {
   
    func didUpdateweather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error:Error)
}




struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=5c5d6e30ba72c04e9d014b3a7c6c57af"
    
    //Delegate
    var delegate:WeatherManagerDelegate?
    
    //attach the cityname to the weather url const
    func getWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
    //Networking
    func performRequest(with urlString: String)  {
        
        //1. Create a URL
        let url = URL(string: urlString)
        
        //2. Create a URLSession
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        //let task = session.dataTask(with: url!, completionHandler: handle(data:response:error:))
        
        //using closer
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            
            if let safeData = data {
                
                if let weather = self.parseJSON(safeData){
                    
                    self.delegate?.didUpdateweather(self,weather:weather)
                }
                
                
                
//                //Object of controller
//                let weatherVC = WeatherViewController()
//                
//                weatherVC.didUpdateWeather(weather: weather!)
                
            }
        }
        
        //4. Start the task
        task.resume()
    }
    
    //Parse data JSON
    func parseJSON(_ weatherData:Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do{
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherID = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(weatherID: weatherID, cityName: name, temperature: temp)
            
            return weather
            
        } catch{
            
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?) {
    //
    //        if error != nil {
    //            print(error!)
    //            return
    //        }
    //
    //        if let safeData = data {
    //
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString!)
    //        }
    //    }
    

}
