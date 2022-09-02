//
//  TVDetailVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit
import Combine

class TVDetailVC: UIViewController {
    
    // MARK: - IBOutlets and UI Components
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstAirDateLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var productionCompaniesButton: UIButton!
    @IBOutlet weak var networksButton: UIButton!
    @IBOutlet weak var seasonsButton: UIButton!
    
    // MARK: - Variables
    private var viewModel: TVDetailVM
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Initializers
    init(tvId: Int) {
        viewModel = TVDetailVM(tvId: tvId)
        super.init(nibName: "TVDetailVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = TVDetailVM(tvId: 0)
        super.init(coder: coder)
    }
    
    // MARK: - Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        title = "TV Series Detail"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupBindings() {
        Task {
            await viewModel.getMovie()
        }
        
        viewModel.$tvSeries
            .receive(on: RunLoop.main)
            .sink{ [weak self] value in
                if let tvSeries = value {
                    self?.containerScrollView.isHidden = false
                    self?.loadingIndicator.isHidden = true
                    self?.loadingIndicator.stopAnimating()
                    
                    self?.titleLabel.text = tvSeries.name
                    self?.firstAirDateLabel.text = tvSeries.firstAirDate
                    self?.episodesLabel.text = "\(tvSeries.numberOfEpisodes ?? 0)"
                    self?.ratingLabel.text = "\(tvSeries.voteAverage ?? 0)"
                    self?.overviewLabel.text = tvSeries.overview
                } else {
                    self?.containerScrollView.isHidden = true
                    self?.loadingIndicator.isHidden = false
                    self?.loadingIndicator.startAnimating()
                }
            }.store(in: &bindings)
        
        viewModel.$backdropImage
            .receive(on: RunLoop.main)
            .sink{ [weak self] value in
                if let image = value {
                    self?.backdropImage.image = image
                }
            }.store(in: &bindings)
        
        productionCompaniesButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                if let productionCompanies = self?.viewModel.tvSeries?.productionCompanies {
                    self?.showProductionCompaniesModal(productionCompanies)
                }
            }.store(in: &bindings)
        
        networksButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                if let networks = self?.viewModel.tvSeries?.networks {
                    self?.showNetworksModal(networks)
                }
            }.store(in: &bindings)
        
        seasonsButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                if let seasons = self?.viewModel.tvSeries?.seasons {
                    self?.showSeasonsModal(seasons)
                }
            }.store(in: &bindings)
    }
    
    // MARK: - Custom Functions
    private func showProductionCompaniesModal(_ productionCompanies: [ProductionCompany]) {
        let modal = AdditionalListModalVC(productionCompanies: productionCompanies)
        let navigationController = UINavigationController(rootViewController: modal)
        navigationController.isModalInPresentation = true
        present(navigationController, animated: true)
    }
    
    private func showNetworksModal(_ networks: [ProductionCompany]) {
        let modal = AdditionalListModalVC(networks: networks)
        let navigationController = UINavigationController(rootViewController: modal)
        navigationController.isModalInPresentation = true
        present(navigationController, animated: true)
    }
    
    private func showSeasonsModal(_ seasons: [Season]) {
        let modal = AdditionalListModalVC(tvId: viewModel.tvSeries?.ID ?? 0, seasons: seasons)
        let navigationController = UINavigationController(rootViewController: modal)
        navigationController.isModalInPresentation = true
        present(navigationController, animated: true)
    }
}
