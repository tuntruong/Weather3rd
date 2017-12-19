//
//  DataServices.swift
//  Weather3rd
//
//  Created by Cuong15tr on 12/17/17.
//  Copyright © 2017 Cuong15tr. All rights reserved.
//

import Foundation
import CoreLocation
struct NotificationKey {
    static let data = Notification.Name.init("data")
}
class DataServices {
    
    var locationCurrent: String?
    static var shared : DataServices = DataServices()
    var location = "" {
        didSet {
            self.getdata(locationInput: location)
        }
    }
    private var _weather: Weather?
    
    var weather : Weather?{
        get{
            if _weather == nil {
                self.getdata(locationInput: location)
            }
            return _weather
        }set{
            _weather = newValue
        }
    }
    private func getdata(locationInput: String) {
        let baseUrl = "https://api.darksky.net/forecast/0a7e919279ef03e2c1bb23c71544d118/"
        CLGeocoder().geocodeAddressString(locationInput) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                guard let location = placemarks?.first?.location else {return}
                let urlString = baseUrl + "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                guard let url = URL(string: urlString ) else {
                    return
                }
                print(urlString)
                let urlRequest = URLRequest(url: url)
                self.makeDataTaskRequest(request: urlRequest){
                    self._weather = Weather(dictionary: $0)
                    NotificationCenter.default.post(name: NotificationKey.data, object: nil)
                    
                }
            }
        }
    }
    private func makeDataTaskRequest(request: URLRequest, completedBlock: @escaping (JSON) -> Void ) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonObject =  try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) else {
                return
            }
            guard let json = jsonObject as? JSON else {
                return
            }
            DispatchQueue.main.async {
                completedBlock(json)
            }
        }
        task.resume()
    }
}
