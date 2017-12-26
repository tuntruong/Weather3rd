//
//  ViewController.swift
//  Weather3rd
//
//  Created by Cuong15tr on 12/17/17.
//  Copyright © 2017 Cuong15tr. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var Uiview: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        DataServices.shared.location = "Ha Noi"
        registerNotification()
    }
    
    //MARK: Notification
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NotificationKey.data, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func updateData() {
        guard let weatherCurrent = DataServices.shared.weather?.current else {return}
        
        let f = weatherCurrent.temperature
        self.temperatureLabel.text = "\(Int((f - 32)*5/9))"
        self.summaryLabel.text = weatherCurrent.summary
        self.localLabel.text = DataServices.shared.location
        tableView.reloadData()
        collectionView.reloadData()
    }
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = DataServices.shared.weather?.hourly.count else {return 0}
        return (count-1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClCell", for: indexPath) as! HourlyCollectionViewCell
        if let hourly = DataServices.shared.weather?.hourly[indexPath.row]{
            if indexPath.row == 0{
                cell.timeLabel.text = "Now"
                cell.iconImage.image = UIImage(named: hourly.icon)
                let f = hourly.temperature
                cell.temp.text = "\(Int((f - 32)*5/9))°C"
            }else{
                cell.timeLabel.text = "\(hourly.time.gethour())h"
                cell.iconImage.image = UIImage(named: hourly.icon)
                let f = hourly.temperature
                cell.temp.text = "\(Int((f - 32)*5/9))°C"
            }
        }
        return cell
    }
    
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = DataServices.shared.weather?.daily.count else {return 0}
        return (count-1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyTableViewCell
        if let daily = DataServices.shared.weather?.daily{
            if indexPath.row == 0{
                cell.dayLabel.text = "Today"
                cell.iconImage.image = UIImage(named: daily[indexPath.row].icon)
                let maxf = daily[indexPath.row].temp_max
                let minf = daily[indexPath.row].temp_min
                cell.tempMaxLabel.text = "\(Int((maxf - 32)*5/9))°C"
                cell.tempMinLabel.text = "\(Int((minf - 32)*5/9))°C"
            }else{
                cell.dayLabel.text = daily[indexPath.row].time.dayWeek()
                cell.iconImage.image = UIImage(named: daily[indexPath.row].icon)
                let maxf = daily[indexPath.row].temp_max
                let minf = daily[indexPath.row].temp_min
                cell.tempMaxLabel.text = "\(Int((maxf - 32)*5/9))°C"
                cell.tempMinLabel.text = "\(Int((minf - 32)*5/9))°C"
            }
            
        }
        return cell
    }
}

