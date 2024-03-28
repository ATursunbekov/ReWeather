//
//  ViewController.swift
//  ReWeatherApp
//
//  Created by Alikhan Tursunbekov on 27/3/24.
//

import UIKit

class MainViewCotnroller: UIViewController {
     
    lazy var mainView = MainView()
    var selectedWeek = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupTargets()
        setupGestureRecognizers()
    }
    
    override func loadView() {
        view = mainView
    }
    
    func setupDelegates() {
        mainView.weekCollectionView.delegate = self
        mainView.weekCollectionView.dataSource = self
    }
    
    func setupTargets() {
        mainView.leftButton.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        mainView.rightButton.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
    }
    
    func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        mainView.locationView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func viewTapped() {
        print("View was tapped!")
    }
    
    @objc func leftTapped() {
        guard selectedWeek > 0 else { return }
        var previousIndexPath = IndexPath(item: selectedWeek, section: 0)
        mainView.weekCollectionView.cellForItem(at: previousIndexPath)
        selectedWeek -= 1
        previousIndexPath = IndexPath(item: selectedWeek, section: 0)
        mainView.weekCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        mainView.weekCollectionView.reloadData()
    }
    
    @objc func rightTapped() {
        guard selectedWeek < 6 else { return }
        selectedWeek += 1
        let previousIndexPath = IndexPath(item: selectedWeek, section: 0)
        mainView.weekCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        mainView.weekCollectionView.reloadData()
    }
}

extension MainViewCotnroller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as! WeekCollectionViewCell
        if indexPath.row != selectedWeek {
            cell.notSelected()
        } else {
            cell.selectedCell()
        }
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
