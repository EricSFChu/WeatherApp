//
//  WeatherCell.swift
//  Pods
//
//  Created by EricDev on 5/17/17.
//
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(weatherObject: Weathers){
        dateLabel.text = weatherObject.date
        weatherLabel.text = weatherObject.weatherLabel
        highTemp.text = weatherObject.highTemp
        lowTemp.text = weatherObject.lowTemp
        weatherImage.image = UIImage(named: weatherObject.weatherLabel)
    }

}
