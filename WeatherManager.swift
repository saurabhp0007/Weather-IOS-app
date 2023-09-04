//  WeatherManager.swift
//  Clima
//  Created by Saurabh  on 09/08/23.

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherData, weather: weatherModel)
    func didFailWithError(error: Error)
}
struct WeatherData {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=eb6a4a1da1b6666841490dfa437a3b55&units=metric"
    var delegate:   WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performURL(with: urlString)
    }
    func fetchWeather(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performURL(with: urlString)
    }
    //external and internal name use
    func performURL(with urlString: String) {
        if  let url = URL(string: urlString){
            
            //CRETE SESSION
            let session = URLSession(configuration: .default)
            
            //give seesaion a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if  let Weather = self.parseJson(  safeData){
                        delegate?.didUpdateWeather( self,weather: Weather)
                    }
                }
            }
            
            //perform task
            task.resume()
        }
      
    }
    func parseJson(_ weatherData: Data)-> weatherModel? {
        let decoder = JSONDecoder()
        do{
           let decodedData  = try decoder.decode(Weather.self , from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = weatherModel(conditionId: id, Temperature: temp, cityName: name)
            return weather  
        } catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
     
    func didFailWithError(error: Error){
        print(error)
    }
   
} 

