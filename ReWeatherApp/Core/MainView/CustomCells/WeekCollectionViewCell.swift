//
//  WeekCollectionViewCell.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 28/3/24.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
    static let identifier = "WeekCollectionViewCell"
    
    lazy var weekLabel = {
        let name = UILabel()
        name.text = "SUN"
        name.font = .inter(size: 20, weight: .medium)
        name.textColor = .white
        return name
    }()
    
    lazy var weatherImage = {
        let image = UIImageView(image: UIImage(named: "sunCloud"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.addSubview(weekLabel)
        contentView.addSubview(weatherImage)
        
        weekLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(weatherImage.snp.top).offset(-6)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
    }
    
    func configureData(day: String, image: String) {
        weekLabel.text = day
        weatherImage.image = UIImage(named: image)
    }
    
    func selectedCell() {
        weekLabel.font = .inter(size: 20, weight: .medium)
        weekLabel.textColor = .white
        weatherImage.snp.updateConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
    }
    
    func notSelected() {
        weekLabel.font = .inter(size: 16, weight: .regular)
        weekLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        weatherImage.snp.updateConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
