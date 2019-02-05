//
//  WeatherForecastView.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import UIKit

protocol WeatherForecastViewDelegate: class {
    func didTapTryAgainButton()
}

class WeatherForecastView: UIView {

    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            let cellReuseIdentifier = ForecastTableCell.reuseIdentifier
            let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
            
            tableView.tableFooterView = UIView()
        }
    }

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private var errorView: UIView!
    
    // MARK: - Private Properties
    
    private var viewState: WeatherForecastViewState? {
        didSet {
            guard let viewState = viewState else {
                return
            }
            viewState.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            viewState.failedToLoadData ? (errorView.isHidden = false) : (errorView.isHidden = true)
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Public Properties
    
    weak var delegate: WeatherForecastViewDelegate?
    
    // MARK: - Configuration
    
    func configure(with viewState: WeatherForecastViewState) {
        self.viewState = viewState
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapTryAgainButton() {
        delegate?.didTapTryAgainButton()
    }
}

// MARK: - UITableView Data Source

extension WeatherForecastView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState?.forecasts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewState = viewState?.forecasts[indexPath.row] else {
            fatalError("Unexpected state")
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableCell.reuseIdentifier) as? ForecastTableCell else {
            fatalError("Failed to dequeue ForecastTableCell")
        }
        cell.configure(with: cellViewState)
        
        return cell
    }
}

// MARK: - UITableView Delegate

extension WeatherForecastView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
