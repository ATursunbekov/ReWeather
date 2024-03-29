//
//  ViewController.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 27/3/24.
//

import UIKit

class MainViewCotnroller: UIViewController {
     
    lazy var mainView = MainView()
    var selectedWeek = 0
    var viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupTargets()
        viewModel.getLocation(cityName: "Bishkek")
        navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        view = mainView
    }
    
    func setupDelegates() {
        mainView.weekCollectionView.delegate = self
        mainView.weekCollectionView.dataSource = self
        viewModel.delegate = self
    }
    
    func setupTargets() {
        mainView.leftButton.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        mainView.rightButton.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
        mainView.locationView.addTarget(self, action: #selector(viewTapped), for: .touchUpInside)
    }

    @objc func viewTapped() {
        let searchView = SearchView()
        searchView.modalPresentationStyle = .overFullScreen
        searchView.delegate = self
        present(searchView, animated: false)
    }
    
    @objc func leftTapped() {
        guard selectedWeek > 0 else { return }
        var previousIndexPath = IndexPath(item: selectedWeek, section: 0)
        mainView.weekCollectionView.cellForItem(at: previousIndexPath)
        selectedWeek -= 1
        updateDataInscrolling()
        previousIndexPath = IndexPath(item: selectedWeek, section: 0)
        mainView.weekCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        mainView.weekCollectionView.reloadData()
    }
    
    @objc func rightTapped() {
        guard selectedWeek < viewModel.weekWeather.count - 1 else { return }
        selectedWeek += 1
        updateDataInscrolling()
        let previousIndexPath = IndexPath(item: selectedWeek, section: 0)
        mainView.weekCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        mainView.weekCollectionView.reloadData()
    }
    
    func updateDataInscrolling() {
        mainView.tempLabel.text = "\(Int(viewModel.weekWeather[selectedWeek].temp.day))°C"
        mainView.weatherImage.image = UIImage(named: viewModel.weekWeather[selectedWeek].weather[0].icon)
        mainView.stateLabel.text = viewModel.weekWeather[selectedWeek].weather[0].main
        mainView.dateLabel.text = formatDate(from: TimeInterval(viewModel.weekWeather[selectedWeek].dt))
    }
}

extension MainViewCotnroller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weekWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as! WeekCollectionViewCell
        if indexPath.row != selectedWeek {
            cell.notSelected()
        } else {
            cell.selectedCell()
        }
        cell.configureData(day: dayOfWeek(from: TimeInterval(viewModel.weekWeather[indexPath.row].dt)), image: viewModel.weekWeather[indexPath.row].weather[0].icon)
        return cell
    }
}

extension MainViewCotnroller: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 110) / 5, height: 74)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewCotnroller: MainViewModelDelegate {
    func refreshData(data: WeatherModel) {
        DispatchQueue.main.async {
            self.mainView.stateLabel.text = data.daily[0].weather[0].main
            self.mainView.weatherImage.image = UIImage(named: data.daily[0].weather[0].icon)
            self.mainView.tempLabel.text = "\(Int(data.daily[0].temp.day.rounded()))°C"
            self.mainView.dateLabel.text = self.formatDate(from: TimeInterval(data.daily[0].dt))
            self.mainView.weekCollectionView.reloadData()
        }
    }
    
    func formatDate(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE | dd MMM yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: date)
    }
    
    func dayOfWeek(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: date).uppercased()
    }
}

extension MainViewCotnroller: SearchViewDelegate {
    func searchPressed(cityName: String) {
        mainView.cityName.text = cityName
        viewModel.getLocation(cityName: cityName)
    }
}
