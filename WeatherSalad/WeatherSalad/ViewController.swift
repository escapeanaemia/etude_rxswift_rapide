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
    let degreeCLabel = UILabel()
    let degreeFLabel = UILabel()
    let tempSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeViewComponents()
        
        ApiController.shared.getCurrentWeather(city: "Seoul")?.observeOn(MainScheduler.instance)
            .subscribe(onNext: { (weather) in
                self.tempLabel.text = "\(weather.temperature)도"
                self.iconLabel.text = "\(weather.icon)"
                self.humidityLabel.text = "\(weather.humidity)"
                self.cityNameLabel.text = weather.cityName
                print("\(weather.temperature)도")
                print(weather.icon)
                print(weather.humidity)
                print(weather.cityName)
            }).disposed(by: disposeBag)
//        http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=55db388dc5585d5e70d85b63719f44bc&units=metric
//  http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=55db388dc5585d5e70d85b63719f44bc&units=metric
        
    }
    
    func initializeViewComponents(){
        //MARK:- Add UI components as Subview of "self.view"
        self.view.addSubview(self.searchCityName)
        self.view.addSubview(self.iconLabel)
        self.view.addSubview(self.humidityLabel)
        self.view.addSubview(self.cityNameLabel)
        self.view.addSubview(self.tempLabel)
        self.view.addSubview(self.degreeCLabel)
        self.view.addSubview(self.degreeFLabel)
        self.view.addSubview(self.tempSwitch)
        
        //MARK:- UI for textfield SearchCityName
        self.searchCityName.placeholder = "City's Name"
        self.searchCityName.font = UIFont.boldSystemFont(ofSize: 32)
        self.searchCityName.textAlignment = .center
        self.searchCityName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(36)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        //MARK:- UI for uilabel IconLabel
        self.iconLabel.text = "W"
        self.iconLabel.font = UIFont.systemFont(ofSize: 220)
        self.iconLabel.textAlignment = .center
        self.iconLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(self.iconLabel.snp.height)
        }
        
        //MARK:- UI for uilabel TempLabel
        self.tempLabel.text = "T"
        self.tempLabel.font = UIFont(name: "System", size: 24)
        self.tempLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.iconLabel.snp.top).offset(-8)
            make.leading.equalTo(self.iconLabel)
        }
        //MARK:- UI for uilabel HumidityLabel
        self.humidityLabel.text = "H"
        self.humidityLabel.font = UIFont(name: "System", size: 24)
        self.humidityLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.iconLabel.snp.top).offset(-8)
            make.trailing.equalTo(self.iconLabel)
        }
        //MARK:- UI for uilabel CityNameLabel
        self.cityNameLabel.text = "City"
        self.cityNameLabel.textAlignment = .center
        self.cityNameLabel.font = UIFont.systemFont(ofSize: 32)
        self.cityNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        //MARK:- UI for uiswitch TempSwitch
        self.tempSwitch.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-36)
            make.centerX.equalToSuperview()
        }
        //MARK:- UI for uilabel C
        self.degreeCLabel.text = "C"
        self.degreeCLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tempSwitch)
            make.trailing.equalTo(self.tempSwitch.snp.leading).offset(-8)
        }
        
        //MARK:- UI for uilabel F
        self.degreeFLabel.text = "F"
        self.degreeFLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tempSwitch)
            make.leading.equalTo(self.tempSwitch.snp.trailing).offset(8)
        }
    }


}

