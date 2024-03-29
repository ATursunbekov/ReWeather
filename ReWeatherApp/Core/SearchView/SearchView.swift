//
//  SearchView.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 29/3/24.
//

import UIKit
import SwiftUI

protocol SearchViewDelegate {
    func searchPressed(cityName: String)
}

class SearchView: UIViewController {
    
    var delegate: SearchViewDelegate?
    
    lazy var backView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#DFAE53")
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var searchView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.inter(size: 15, weight: .medium)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "SEARCH LOCATION", attributes: attributes)
        textField.textAlignment = .left
        return textField
    }()
    
    lazy var searchCityButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var tableView:UITableView = {
        let  tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.rowHeight = 30
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupConstraints()
        searchCityButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        view.addSubview(backView)
        backView.addSubview(searchView)
        searchView.addSubview(searchTextField)
        backView.addSubview(searchCityButton)
        backView.addSubview(tableView)
        
        backView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(300)
        }
        
        searchView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
        searchCityButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchView.snp.centerY)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc func searchPressed() {
        if let text = searchTextField.text {
            DataManager.shared.addCityHistory(city: text)
            delegate?.searchPressed(cityName: text)
        }
        dismiss(animated: false)
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.getAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configureData(cityName: DataManager.shared.getCity(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.text = DataManager.shared.getCity(index: indexPath.row)
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct SearchViewPreview: PreviewProvider {
    static var previews: some View {
        SearchView().showPreview()
    }
}
#endif
