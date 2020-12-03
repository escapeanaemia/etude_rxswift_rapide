//
//  ViewController.swift
//  WeatherSalad
//
//  Created by Andrew Han on 2020/11/11.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
class ViewController: UIViewController {

    let tempLabel = UILabel()
    let iconLabel = UILabel()
    let humidityLabel = UILabel()
    let cityNameLabel = UILabel()
    let disposeBag = DisposeBag()
    let searchCityName = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ApiController.shared.currentWeather(city: "Seoul").observeOn(MainScheduler.instance).subscribe(onNext: { data in
            self.tempLabel.text = "\(data.temperature)도"
            self.iconLabel.text = data.icon
            self.humidityLabel.text = "\(data.humidity)"
            self.cityNameLabel.text = data.cityName
            print("\(data.temperature)도")
            print(data.icon)
            print(data.humidity)
            print(data.cityName)
        } ).disposed(by: self.disposeBag)
        searchCityName.rx.text
            .filter { (text) -> Bool in
                return (text?.count ?? 0) > 0
            }
            .flatMap { (text) in
                return ApiController.shared.currentWeather(city: text ?? "Error").catchErrorJustReturn(ApiController.Weather.empty)
            }
            .asDriver(onErrorJustReturn: ApiController.Weather.empty)
    }


}

