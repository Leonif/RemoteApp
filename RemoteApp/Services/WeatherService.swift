//
//  WeatherService.swift
//  RemoteApp
//
//  Created by Leonid Nifantyev on 25.09.2020.
//

import Foundation
import Alamofire

class WeatherService {
    var baseUrl = "api.openweathermap.org"
    var appId = "4a92498353c9514b369ac8651d833537"
    
    func getWeather(city: String, callback: @escaping (WeatherModel?, Error?) -> Void) {
        let urlString = "http://\(baseUrl)/data/2.5/weather"
        
        let parameters: Parameters = [
            "q"     : city,
            "appid" : appId
        ]
        
        AF.request(urlString, method: .get, parameters: parameters).responseData { (responce) in
            
            let data = responce.data!
            
            
            let decoder = JSONDecoder()
            
            do {
            
                let weather = try decoder.decode(WeatherModel.self, from: data)
                callback(weather, nil)
                
            } catch(let error) {
            
                callback(nil, error)
            }
            
        }
            
           
    }
}



struct WeatherModel: Decodable {
    let latitude: Double
    let longtitude: Double
    let temp: Double
    let speed: Double
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let coordValues = try values.nestedContainer(keyedBy: CoordKeys.self, forKey: .coord)
        self.latitude = try coordValues.decode(Double.self, forKey: .latitude)
        self.longtitude = try coordValues.decode(Double.self, forKey: .longtitude)
        
        let mainValues = try values.nestedContainer(keyedBy: CoordKeys.self, forKey: .main)
        self.temp = try mainValues.decode(Double.self, forKey: .temperature)
        
        let windValues = try values.nestedContainer(keyedBy: CoordKeys.self, forKey: .wind)
        self.speed = try windValues.decode(Double.self, forKey: .speed)
    }
    
    enum CodingKeys: String, CodingKey {
        case coord, main, wind
    }
    
    enum CoordKeys: String, CodingKey {
        case longtitude = "lon", latitude = "lat", temperature = "temp", speed
    }
    
    
    
}




