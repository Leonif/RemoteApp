//
//  ViewController.swift
//  RemoteApp
//
//  Created by Leonid Nifantyev on 25.09.2020.
//

import UIKit




class MainViewController: UIViewController {
    
    let weatherService: WeatherService = WeatherService()
    let rootView = MainView()
    
    
    override func loadView() {
        super.loadView()
        
        view = rootView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weatherService.getWeather(city: "Moscow") { [weak self] (weather, error) in
            self.handleRespose(weather)
        }
    }

    
    func handle(weather: WeatherModel) {
        
    }
    
    
    
}

