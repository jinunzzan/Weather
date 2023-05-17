//
//  ViewController.swift
//  Weather
//
//  Created by Eunchan Kim on 2023/05/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var weatherStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true)
            print("날씨가져오기 클릭")
        }
        
    }
    func configureView(weatherInformation: WeatherInformation){
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first{
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))도"
        self.minTempLabel.text = "최저: \(Int(weatherInformation.temp.tempMin - 273.15))도"
        self.maxTempLabel.text = "최고: \(Int(weatherInformation.temp.tempMax  - 273.15))도"
    }
    
    func getCurrentWeather(cityName: String){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=b3457a7face33829ef9791932f896fc3") else {return}
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) {[weak self] data, response, error in
                guard let data = data, error == nil else {return}
                let decoder = JSONDecoder()
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else {return}
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
                debugPrint(weatherInformation)
            }.resume()
        }

    }

