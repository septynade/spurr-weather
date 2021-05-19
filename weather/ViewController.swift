//
//  ViewController.swift
//  weather
//
//  Created by Bisnis Integrasi Global on 19/05/21.
//

import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    //MARK: - Variables
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Events
    @IBAction func checkTapped(_ sender: Any) {
        guard let cityName = textField.text else { return }
        searchCity(cityName)
    }
    
    
    //MARK: - Functions
    func searchCity(_ city: String) {
        let param = ["q": city,
                     "appid": "7a42316f11f59d4a612e3f3dbee4d899",
                     "units": "metric"]
        AF.request("https://api.openweathermap.org/data/2.5/weather?", parameters: param)
            .response { response in
                guard let data = response.data else { return }
                let json = JSON(data)
                
                let temp = json["main"]["temp"].stringValue
                let cityName = json["name"].stringValue
                let desc = json["weather"][0]["description"].stringValue
                
                DispatchQueue.main.async {
                    self.tempLabel.text = temp.components(separatedBy: ".")[0]
                    self.cityNameLabel.text = cityName
                    self.descLabel.text = desc
                }
            }
    }

}

