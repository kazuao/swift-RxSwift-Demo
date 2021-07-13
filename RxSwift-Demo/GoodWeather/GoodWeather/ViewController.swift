//
//  ViewController.swift
//  GoodWeather
//
//  Created by k-aoki on 2021/07/07.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // enter押下で発火
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { [weak self] city in
                
                guard let _self = self else { return }
                
                if let city = city {
                    if city.isEmpty {
                        _self.displayWeather(nil)
                    } else {
                        _self.fetchWeather(by: city)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        // 文字入力のたびに発火
//        cityNameTextField.rx.value
//            .subscribe(onNext: { [weak self] city in
//
//                guard let _self = self else { return }
//
//                if let city = city {
//                    if city.isEmpty {
//                        _self.displayWeather(nil)
//                    } else {
//                        _self.fetchWeather(by: city)
//                    }
//                }
//            })
//            .disposed(by: disposeBag)
    }
    
    private func fetchWeather(by city: String) {

        guard
            let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(city: cityEncoded)
        else { return }
        
        let resource = Resource<WeatherResult>(url: url)
        
            // 通常の方法
//            .subscribe(onNext: { [weak self] result in
//
//                guard let _self = self else { return }
//
//                let weather = result.main
//                _self.displayWeather(weather)
//            })
//            .disposed(by: disposeBag)
        
        // throwエラーをハンドリングしない場合
//        let search = URLRequest.load(resource: resource)
//            .observe(on: MainScheduler.instance) // MainThreadで実行できるように
//            // Driverを使う場合は不要
////            .catchAndReturn(WeatherResult.empty) // エラーになった場合
//            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        // throwエラーをcatchする場合
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .retry(3) // 再施行回数
            .catch { error in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            }
            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        // bindを使ったパターン
        search.map { "\($0.main.temp) ℃" }
            // Driverを使う場合は、driveに置き換える
//            .bind(to: temperatureLabel.rx.text)
            .drive(temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💦" }
//            .bind(to: humidityLabel.rx.text)
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        
        if let weather = weather {
            
            temperatureLabel.text = "\(weather.temp) ℃"
            humidityLabel.text = "\(weather.humidity) 💦" 
            
        } else {
            temperatureLabel.text = "🐹"
            humidityLabel.text = "🌻"
        }
    }
}

