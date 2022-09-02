//
//  MovieDetailVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import UIKit
import Combine

class MovieDetailVC: UIViewController {
    
    // MARK: - IBOutlets and UI Components
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var productionCompaniesButton: UIButton!
    
    // MARK: - Variables
    private var viewModel: MovieDetailVM
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Initializers
    init(movieId: Int) {
        viewModel = MovieDetailVM(movieId: movieId)
        super.init(nibName: "MovieDetailVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = MovieDetailVM(movieId: 0)
        super.init(coder: coder)
    }
    
    // MARK: - Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    // MARK: - Setup functions
    private func setupUI() {
        title = "Movie Detail"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupBindings() {
        Task {
            await viewModel.getMovie()
        }
        
        viewModel.$movie
            .receive(on: RunLoop.main)
            .sink{ [weak self] value in
                if let movie = value {
                    self?.containerScrollView.isHidden = false
                    self?.loadingIndicator.isHidden = true
                    self?.loadingIndicator.stopAnimating()
                    
                    self?.titleLabel.text = movie.title
                    self?.releaseDateLabel.text = movie.releaseDate
                    self?.durationLabel.text = "\(movie.runtime ?? 0) mins"
                    self?.ratingLabel.text = "\(movie.voteAverage ?? 0)"
                    self?.overviewLabel.text = movie.overview
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
                if let productionCompanies = self?.viewModel.movie?.productionCompanies {
                    self?.showProductionCompaniesModal(productionCompanies)
                }
            }.store(in: &bindings)
    }
    
    private func showProductionCompaniesModal(_ productionCompanies: [ProductionCompany]) {
        let modal = AdditionalListModalVC(productionCompanies: productionCompanies)
        let navigationController = UINavigationController(rootViewController: modal)
        navigationController.isModalInPresentation = true
        present(navigationController, animated: true)
    }
}
