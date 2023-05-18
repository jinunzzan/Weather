//
//  WeatherInformation.swift
//  Weather
//
//  Created by Eunchan Kim on 2023/05/16.
//

import Foundation

struct WeatherInformation: Codable{
    //외부표현으로 변환해주는 코더블~
    //디코더블과 인코더블
    //WeatherInformation 형태로 디코딩
    //api에서 필요한 프로퍼티만 데려옴
    let weather: [Weather]
    let temp: Temp
    let name: String

    enum CodingKeys: String, CodingKey {
      case weather
      case temp = "main"
      case name
    }
  }

  struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
  }

  struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double

    enum CodingKeys: String, CodingKey {
      case temp
      case feelsLike = "feels_like"
      case minTemp = "temp_min"
      case maxTemp = "temp_max"
    }
  }
