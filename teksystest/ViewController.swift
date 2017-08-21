//
//  ViewController.swift
//  teksystest
//
//  Created by Manish Reddy on 6/7/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var cityTextField: UITextField!
    @IBOutlet fileprivate weak var cityLabel: UILabel!
    
    var viewModel: ViewModel?
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(weatherDataFetcher: WeatherDataFetcher())
        viewModel?.delegate = self
    }
    
    //Action
    @IBAction fileprivate func submitAction(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let cityText = cityTextField.text, cityText != "" else {
            return
        }

        viewModel?.fetchWeatherData(cityText: cityText)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        guard let cellTemperatureData = viewModel?.temperatureData?.temperatureFor3Days[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.dateLabel.text = cellTemperatureData.dateString
        cell.descriptionLabel.text = cellTemperatureData.description
        cell.highTemperatureLabel.text = String(cellTemperatureData.maximumTemperature)
        cell.lowTemperatureLabel.text = String(cellTemperatureData.minimumTemperature)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.temperatureData?.temperatureFor3Days.count ?? 0
    }
    
}

extension ViewController: ViewControllerDelegate {
   
    func reloadData() {
        guard let temperatureData = viewModel?.temperatureData else { return }
        
        cityLabel.text = temperatureData.city + " " + temperatureData.country
        tableView.reloadData()
    }
}

