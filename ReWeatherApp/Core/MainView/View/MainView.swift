//
//  MainView.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 27/3/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    lazy var backImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "back1"))
        return image
    }()
    
    lazy var locationView = {
        let view = UIButton()
        return view
    }()
    
    lazy var locationImage = {
        let image = UIImageView(image: UIImage(named: "location"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var cityName: UILabel = {
        let name = UILabel()
        name.text = "Bishkek"
        name.font = .inter(size: 20, weight: .medium)
        name.textColor = .white
        return name
    }()
    
    lazy var dropImage = {
        let image = UIImageView(image: UIImage(named: "drop"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var avatarImage = {
        let image = UIImageView(image: UIImage(named: "avatar"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var stateLabel: UILabel = {
        let name = UILabel()
        name.text = "Cloudy"
        name.font = .inter(size: 24, weight: .medium)
        name.textColor = .white
        return name
    }()
    
    lazy var weatherImage = {
        let image = UIImageView(image: UIImage(named: "sunCloud"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var tempLabel: UILabel = {
        let name = UILabel()
        name.text = "26°C"
        name.font = .inter(size: 64, weight: .medium)
        name.textColor = .white
        return name
    }()
    
    lazy var dateLabel: UILabel = {
        let name = UILabel()
        name.text = "Sunday | 12 Dec 2023"
        name.font = .inter(size: 18, weight: .medium)
        name.textColor = .white
        return name
    }()
    
    lazy var weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
        collection.decelerationRate = .fast
        collection.alwaysBounceHorizontal = true
        return collection
    }()
    
    lazy var leftButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "leftArrow"), for: .normal)
        return button
    }()
    
    lazy var rightButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "rightArrow"), for: .normal)
        return button
    }()
    
    lazy var backView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: "#DFAE53", alpha: 0.8)
        return view
    }()
    
    lazy var timeImage = {
        let image = UIImageView(image: UIImage(named: "clock"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var clockTitle = {
        let label = UILabel()
        label.text = "24-hour forecast"
        label.font = .inter(size: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    lazy var forcastLabel = {
        let label = UILabel()
        label.text = "5-day forecast"
        label.textColor = .white
        label.layer.cornerRadius = DHeight(to: 14)
        label.backgroundColor = UIColor(hex: "#EACA8F")
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let chartView = {
        let temp = (UIScreen.main.bounds.width - 48) / 5
        let points = [(x: CGFloat(0), y: CGFloat(80)),
                      (x: CGFloat(temp), y: CGFloat(80 + 9)),
                      (x: CGFloat(temp * 2), y: CGFloat(80 + 13)),
                      (x: CGFloat(temp * 3), y: CGFloat(80 + 14)),
                      (x: CGFloat(temp * 4), y: CGFloat(80 + 11)),
                      (x: UIScreen.main.bounds.width - 24, y: CGFloat(100))
        ]
        let temperatures = ["", "9°", "13°", "14°", "11°", ""]
        return SmoothChartView(points: points, temperatures: temperatures)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(backImage)
        addSubview(locationView)
        locationView.addSubview(locationImage)
        locationView.addSubview(cityName)
        locationView.addSubview(dropImage)
        backImage.addSubview(avatarImage)
        backImage.addSubview(stateLabel)
        backImage.addSubview(weatherImage)
        backImage.addSubview(tempLabel)
        backImage.addSubview(dateLabel)
        backImage.addSubview(weekCollectionView)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(backView)
        backView.addSubview(timeImage)
        backView.addSubview(clockTitle)
        backView.addSubview(chartView)
        backView.addSubview(forcastLabel)
        
        backImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(DWidth(to: 33))
            make.trailing.equalTo(dropImage.snp.trailing)
            make.top.equalToSuperview().offset(DHeight(to: 48))
            make.height.equalTo(DHeight(to: 28))
        }
        
        locationImage.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(DWidth(to: 25))
        }
        
        cityName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(locationImage.snp.trailing).offset(DWidth(to: 10))
        }
        
        dropImage.snp.makeConstraints { make in
            make.leading.equalTo(cityName.snp.trailing).offset(DWidth(to: 16))
            make.centerY.equalToSuperview()
            make.height.equalTo(DHeight(to: 6))
            make.width.equalTo(DWidth(to: 12))
        }
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DHeight(to: 48))
            make.trailing.equalToSuperview().offset(DWidth(to: -32))
            make.height.equalTo(DHeight(to: 30))
            make.width.equalTo(DWidth(to: 30))
        }
        
        stateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(DHeight(to: 181))
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stateLabel.snp.bottom).offset(DHeight(to: 20))
            make.height.equalTo(DHeight(to: 160))
            make.width.equalTo(DWidth(to: 200))
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImage.snp.bottom).offset(13)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tempLabel.snp.bottom).offset(DHeight(to: 13))
        }
        
        weekCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DWidth(to: 55))
            make.top.equalTo(dateLabel.snp.bottom).offset(DHeight(to: 32))
            make.height.equalTo(DHeight(to: 70))
        }
        
        leftButton.snp.makeConstraints { make in
            make.trailing.equalTo(weekCollectionView.snp.leading).offset(DWidth(to: -3))
            make.top.equalTo(weekCollectionView.snp.top).offset(DHeight(to: 8))
            make.width.equalTo(DWidth(to: 22))
            make.height.equalTo(DHeight(to: 26))
        }
        
        rightButton.snp.makeConstraints { make in
            make.leading.equalTo(weekCollectionView.snp.trailing).offset(DWidth(to: 3))
            make.top.equalTo(weekCollectionView.snp.top).offset(DHeight(to: 8))
            make.width.equalTo(DWidth(to: 22))
            make.height.equalTo(DHeight(to: 26))
        }
        
        backView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(DWidth(to: 24))
            make.bottom.equalToSuperview()
            make.height.equalTo(DHeight(to: 285))
            make.width.equalTo(DWidth(to: 382))
        }
        
        timeImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(DWidth(to: 11))
            make.top.equalToSuperview().offset(DHeight(to: 12))
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        clockTitle.snp.makeConstraints { make in
            make.centerY.equalTo(timeImage.snp.centerY)
            make.leading.equalTo(timeImage.snp.trailing).offset(6)
        }
        
        chartView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.top.equalTo(clockTitle.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        forcastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(DWidth(to: 205))
            make.height.equalTo(DHeight(to: DHeight(to: 30)))
            make.bottom.equalToSuperview().offset(DHeight(to: -20))
        }
    }
}

