//
//  WeatherModel.swift
//  WeatherSalad
//
//  Created by Andrew Han on 2020/11/15.
//

import Foundation
import RxSwift
import RxCocoa


class ApiController{
    static let shared = ApiController()
    
    private let apiKey = ""
    let baseURL = URL(string: "http://api.openweathermap.org/data/2.5")!
    struct Weather{
        let cityName: String
        let temperature : Int
        let humidity: Int
        let icon: String
        
        static let empty = Weather(cityName: "Unknown", temperature: -1000, humidity: 0, icon: iconNameToChar(icon: "e"))
    }
    
    
    func currentWeather(city:String) -> Observable<Weather>{
        return Observable.just(
            Weather(cityName: city, temperature: 20, humidity: 90, icon: iconNameToChar(icon: "01d"))
        )
    }
}

public func iconNameToChar(icon: String) -> String {
  switch icon {
  case "01d":
    return "\u{f11b}"
  case "01n":
    return "\u{f110}"
  case "02d":
    return "\u{f112}"
  case "02n":
    return "\u{f104}"
  case "03d", "03n":
    return "\u{f111}"
  case "04d", "04n":
    return "\u{f111}"
  case "09d", "09n":
    return "\u{f116}"
  case "10d", "10n":
    return "\u{f113}"
  case "11d", "11n":
    return "\u{f10d}"
  case "13d", "13n":
    return "\u{f119}"
  case "50d", "50n":
    return "\u{f10e}"
  default:
    return "E"
  }
}
