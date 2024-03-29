//
//  SearchTableViewCell.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 30/3/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            layer.backgroundColor = UIColor.clear.cgColor
            selectionStyle = .none
            backgroundColor = .clear
            setupConstraints()
        }
    
    func setupConstraints() {
        contentView.addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func configureData(cityName: String) {
        cityLabel.text = cityName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

