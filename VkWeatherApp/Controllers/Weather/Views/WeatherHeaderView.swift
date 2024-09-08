//
//  WeatherHeaderView.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 06.09.2024.
//

import Foundation
import UIKit
import SnapKit

class WeatherHeaderView: BaseView{
    
//MARK: Main header
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Almaty"
        return label
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 90)
        label.text = "30°"
        return label
    }()
    
    private lazy var weatherLabel: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.font = UIFont.systemFont(ofSize: 20)
       label.text = "Sunny"
       return label
        
    }()
    
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Maximum: 34°"
        return label
         
     }()
    
    private lazy var minLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Minumym: 20°"
        return label
         
     }()
    
    
//MARK: Expected weather block
    private lazy var expectedWeatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = Resources.Colors.block.cgColor
        stackView.alignment = .leading
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)


        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    private lazy var expWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = Resources.Texts.expectedWeather
        return label
    }()
    
    
    private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 15

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.isScrollEnabled = true
            collectionView.isUserInteractionEnabled = true
            collectionView.backgroundColor = .clear
            collectionView.contentInset = .zero

            collectionView.register(ExpectedWeatherCell.self, forCellWithReuseIdentifier: ExpectedWeatherCell.id)
            
            return collectionView
        }()
    
    var weatherData: DailyWeatherForecast?
    
    
}


extension WeatherHeaderView{
        override func addViews(){
            super.addViews()
            addSubview(verticalStackView)
            horizontalStackView.addArrangedSubview(maxLabel)
            horizontalStackView.addArrangedSubview(minLabel)
            verticalStackView.addArrangedSubview(cityLabel)
            verticalStackView.addArrangedSubview(degreesLabel)
            verticalStackView.addArrangedSubview(weatherLabel)
            verticalStackView.addArrangedSubview(horizontalStackView)
            
            addSubview(expectedWeatherStackView)
            expectedWeatherStackView.addArrangedSubview(expWeatherLabel)
            expectedWeatherStackView.addArrangedSubview(collectionView)
        }
        override func setUpConstraints(){
            super.setUpConstraints()
            verticalStackView.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                
            }
            
            expectedWeatherStackView.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalTo(verticalStackView.snp.bottom).offset(30)
            }
            
            collectionView.snp.makeConstraints { make in
                
                make.width.equalToSuperview().multipliedBy(0.9)
                make.height.equalTo(100)
            }
            
            
        }
        override func configuration(){
            super.configuration()
            collectionView.delegate = self
            collectionView.dataSource = self
                   
        }
    
    
    
    func setData(weatherData: DailyWeatherForecast){
        self.weatherData = weatherData
        cityLabel.text = weatherData.cityName
        degreesLabel.text = "\( weatherData.formattedTempC)°"
        weatherLabel.text = weatherData.condition
        minLabel.text = "Minimum: \(formatTemp(weatherData.minTempC))°"
        maxLabel.text = "Maximum: \(formatTemp(weatherData.maxTempC))°"
        
        collectionView.reloadData()
    }
}


extension WeatherHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.hourlyTemps.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpectedWeatherCell.id, for: indexPath) as! ExpectedWeatherCell
        guard let data = weatherData?.hourlyTemps[indexPath.row] else {return UICollectionViewCell()}
        cell.configure(time: data.getTime(), iconName: data.iconName, temperature: "\(data.formattedTempC)")
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 100)
    }
}
