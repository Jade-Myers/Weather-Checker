//
//  WeatherManager.swift
//  Clima
//
//  Created by Jade Myers on 12/01/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel);
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=e0ee89713db9a48d15aebe240bbe03d6"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(_ lat: Double,_ lon: Double){
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        if let url = URL(string:  urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { ( data, response, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather)
                    }
                    
                }
            }
            
            task.resume()
            
            
        }
        
        
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id;
            let temp = decodedData.main.temp;
            let name = decodedData.name;
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
        } catch{
            print(error)
            return nil
        }
        
    }
    
    
    
    
    
}
