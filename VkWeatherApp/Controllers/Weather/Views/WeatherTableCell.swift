//
//  WeatherTableCell.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 08.09.2024.
//

import Foundation
import UIKit

class WeatherTableCell: UITableViewCell {
    
    public static let id = "WeatherTableCell"
                            
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tempProgressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressTintColor = .yellow
        progressBar.trackTintColor = .lightGray
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true
        return progressBar
    }()
    
    
    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center

        
        stackView.spacing = 5
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(day: String, weatherIconName: String, minTemp: String, maxTemp: String, progress: Float) {
        dayLabel.text = day
        weatherIcon.image = UIImage(systemName: weatherIconName)
        weatherIcon.tintColor = .white
        minTempLabel.text = minTemp
        maxTempLabel.text = maxTemp
        tempProgressBar.progress = progress
    }
}



extension WeatherTableCell{
    func setUpUI(){
        addViews()
        setUpConstraints()
        configuration()
    }
    
    
    func addViews(){
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubview(dayLabel)
        hStackView.addArrangedSubview(weatherIcon)
        hStackView.addArrangedSubview(maxTempLabel)
        hStackView.addArrangedSubview(tempProgressBar)
        hStackView.addArrangedSubview(minTempLabel)

    }
    
    func setUpConstraints(){
        hStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        tempProgressBar.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(100)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
    func configuration(){
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.cornerRadius = 2
        selectionStyle = .none
        

    }
}
