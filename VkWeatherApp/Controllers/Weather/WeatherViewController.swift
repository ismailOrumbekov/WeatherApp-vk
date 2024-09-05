//
//  ViewController.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 06.09.2024.
//

import UIKit

class WeatherViewController: BaseViewController {
    private lazy var weatherHeaderView = WeatherHeaderView()
}


extension WeatherViewController{
    override func addViews(){
          super.addViews()
          view.addSubview(weatherHeaderView)
      }
      override func setUpConstraints(){
          super.setUpConstraints()
          weatherHeaderView.snp.makeConstraints { make in
              make.width.equalToSuperview().multipliedBy(0.9)
              make.height.equalToSuperview().multipliedBy(0.4)
              make.center.equalToSuperview()
          }
      }
      override func configuration(){
          super.configuration()
      }
}
