//
//  ViewController.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 06.09.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: BaseViewController {
    private var weatherData: [DailyWeatherForecast] = []
    let locationManager = CLLocationManager()
    
    
    private lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.barTintColor = .white
        
        searchBar.placeholder = "Write any city"
        
        return searchBar
    }()

    private var headerView : WeatherHeaderView = {
        let view = WeatherHeaderView()
        view.frame = CGRect(x: 0, 
                            y: 200,
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height * 0.5
        )
        return view
    }()
    
    private let tableView: UITableView = {
            let tableView = UITableView()
            
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none

        
        tableView.register(WeatherTableCell.self, forCellReuseIdentifier: WeatherTableCell.id)
                
            return tableView
        }()
        

    
    
}


extension WeatherViewController{
    
    override func addViews(){
          super.addViews()
        view.addSubview(tableView)
        view.addSubview(searchBar)
      }
    
      override func setUpConstraints(){
          
          super.setUpConstraints()
          
          searchBar.snp.makeConstraints { make in
              make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
              make.centerX.equalToSuperview()
              
              make.width.equalToSuperview().multipliedBy(0.9)
              make.height.equalTo(50)
          }
          
          tableView.snp.makeConstraints { make in
              make.width.equalToSuperview().multipliedBy(0.9)
              make.height.equalToSuperview()
              make.top.equalTo(searchBar.snp.bottom).offset(30)
              make.centerX.equalToSuperview()
          }
      }
    
      override func configuration(){
          super.configuration()          
          locationManager.delegate = self
          locationManager.requestWhenInUseAuthorization()
          locationManager.requestLocation()
          
          tableView.delegate = self
          tableView.dataSource = self
          tableView.tableHeaderView = headerView
          
          
          
          
          
          
         

          
          
      }
    

}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableCell.id, for: indexPath) as! WeatherTableCell
            let data = weatherData[indexPath.row]
            cell.setData(
                        day: data.dayOfWeek,
                        weatherIconName: data.iconName,
                        
                         minTemp: "\(formatTemp(data.minTempC))°",
                         maxTemp: "\(formatTemp(data.maxTempC))°",
                        progress: data.progressValue
            )
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60 
        }
}


extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingHeading()
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let locationString = "\(lat),\(lon)"

            WeatherManager.shared.fetchWeather(for: locationString) { dailyWeatherList in
                self.weatherData = dailyWeatherList
                self.tableView.reloadData()
                self.headerView.setData(weatherData: dailyWeatherList[0])
            }        }
    }
    
    
   
    
    //Works only if there were problems with request location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("smthwrong")
    }
}
