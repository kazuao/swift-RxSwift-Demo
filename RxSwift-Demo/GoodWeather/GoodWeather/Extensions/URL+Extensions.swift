//
//  URL+Extensions.swift
//  GoodWeather
//
//  Created by k-aoki on 2021/07/07.
//

import Foundation

let apiKey = "90e47b66a3c6dbc298d981cff42ce04b"

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric")
    }
}
