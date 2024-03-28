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
    
    lazy var locationView = UIView()
    
    lazy var locationImage = {
        let image = UIImageView(image: UIImage(named: "location"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var cityName: UILabel = {
        let name = UILabel()
        name.text = "New York"
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
//        image.layer.cornerRadius = 15
//        image.clipsToBounds = true
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
//        collection.showsHorizontalScrollIndicator = false
        collection.decelerationRate = .fast
        collection.alwaysBounceHorizontal = true
//        collection.isPagingEnabled = false
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
    
    let lineView = CustomSmoothLineView(points:
                                            [
                                                CGPoint(x: 24, y: 147.5),
                                                CGPoint(x: 119, y: 100),
                                                CGPoint(x: 200, y: 120),
//                                                CGPoint(x: 295, y: 60),
//                                                CGPoint(x: 390, y: 60),
                                                CGPoint(x: UIScreen.main.bounds.width-26, y: 147.5),
                                            ])
    
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
        addSubview(lineView)
        
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
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(DWidth(to: 24))
            make.bottom.equalToSuperview()
            make.height.equalTo(DHeight(to: 285))
            make.width.equalTo(DWidth(to: 382))
        }
    }
}

