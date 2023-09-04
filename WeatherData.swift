//  WeatherData.swift
//  Clima
//  Created by Saurabh  on 10/08/23.


import Foundation

struct Weather:Codable {
    let name: String
    let main: Main
    let weather: [weatherData]
   
} 
struct Main: Codable  {
    let temp: Double
}
struct weatherData: Codable  {
    let id: Int
}

