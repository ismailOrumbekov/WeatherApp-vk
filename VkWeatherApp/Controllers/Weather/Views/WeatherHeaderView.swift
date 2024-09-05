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
        stackView.spacing = 5
        
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
        stackView.backgroundColor = Resources.Colors.block
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
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .clear
            collectionView.isScrollEnabled = true
            collectionView.isUserInteractionEnabled = true
            collectionView.alwaysBounceVertical = true

            collectionView.showsHorizontalScrollIndicator = false
            return collectionView
        }()
    
    let weatherData: [(time: String, icon: String, temp: String)] = [
            ("Now", "sun.max.fill", "76°"),
            ("10AM", "sun.max.fill", "77°"),
            ("11AM", "sun.max.fill", "77°"),
            ("12PM", "sun.max.fill", "77°"),
            ("12PM", "sun.max.fill", "77°"),
            ("12PM", "sun.max.fill", "77°"),
            ("12PM", "sun.max.fill", "77°"),
            ("2PM", "sun.max.fill", "79°")
             ]
    
    
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
            addSubview(collectionView)
        }
        override func setUpConstraints(){
            super.setUpConstraints()
            verticalStackView.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.9)
                make.center.equalToSuperview()
                
            }
            
            expectedWeatherStackView.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.95)
                make.centerX.equalToSuperview()
                make.top.equalTo(verticalStackView.snp.bottom).offset(30)
            }
            
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(expectedWeatherStackView.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.9)
                make.height.equalTo(100)
            }
            
            
        }
        override func configuration(){
            super.configuration()
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(ExpectedWeatherCell.self, forCellWithReuseIdentifier: ExpectedWeatherCell.id)
                   
        }
}


extension WeatherHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpectedWeatherCell.id, for: indexPath) as! ExpectedWeatherCell
        let data = weatherData[indexPath.item]
        cell.configure(time: data.time, iconName: data.icon, temperature: data.temp)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
}
