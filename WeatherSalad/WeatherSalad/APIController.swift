//
//  WeatherAPI.swift
//  WeatherSalad
//
//  Created by Andrew Han on 2020/12/10.
//

import Foundation
import RxSwift


class ApiController{
    static let shared = ApiController()
    private var apiKey = APIKey.apiKey
    let baseURL = URL(string: "http://api.openweathermap.org/data/2.5")!
    
    private init(){}
    func getCurrentWeather(city:String) -> Observable<Weather>?{
        let value = buildRequest(pathComponent: "weather", params: [("q", city)])?.map({ (data) -> Weather in
            let decoder = JSONDecoder()
            return try decoder.decode(Weather.self ,from: data)
        })
        return value
    }
    private func buildRequest(method: String = "GET", pathComponent: String, params: [(String, String)]) -> Observable<Data>?{
        let url = baseURL.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "appid", value: apiKey)
        let unitsQueyrItem = URLQueryItem(name: "units", value: "metric")
        guard let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        switch method {
        case "GET":
            var queryItems = params.map{URLQueryItem(name: $0.0, value: $0.1)}
            queryItems.append(keyQueryItem)
            queryItems.append(unitsQueyrItem)
            urlComponents.queryItems = queryItems
        case "POST":
            urlComponents.queryItems = [keyQueryItem, unitsQueyrItem]
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        default:
            print("")
        }
        print("url------")
        print(urlComponents.url!)
        request.url = urlComponents.url!
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return URLSession.shared.rx.data(request: request)
        
    }
}
