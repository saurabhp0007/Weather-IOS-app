//  WeatherModel.swift
//  Clima
//  Created by Saurabh  on 11/08/23.

import Foundation
struct weatherModel {
    
    let conditionId: Int
    let Temperature: Double  
    let cityName:  String
    
    var temperatureString: String {
        return String(format: "%.1f", Temperature)
    }
    
    var ConditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
   
}
