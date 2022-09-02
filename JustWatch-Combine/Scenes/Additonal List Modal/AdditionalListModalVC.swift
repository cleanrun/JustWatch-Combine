//
//  AdditionalListModalVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit
import Combine

class AdditionalListModalVC: UIViewController {
    // MARK: - Diffable data source typealias
    private typealias ProductionCompanyDataSource = UITableViewDiffableDataSource<Int, ProductionCompany>
    private typealias SeasonDataSource = UITableViewDiffableDataSource<Int, Season>
    private typealias EpisodeDataSource = UITableViewDiffableDataSource<Int, Episode>
    private typealias ProductionCompanySnapshot = NSDiffableDataSourceSnapshot<Int, ProductionCompany>
    private typealias SeasonSnapshot = NSDiffableDataSourceSnapshot<Int, Season>
    private typealias EpisodeSnapshot = NSDiffableDataSourceSnapshot<Int, Episode>
    
    // MARK: - IBOutlets and UI Components
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Variables
    private var tvId: Int?
    private var viewModel: AdditionalListModalVM
    private var bindings = Set<AnyCancellable>()
    
    private var productionCompanyDataSource: ProductionCompanyDataSource!
    private var seasonDataSource: SeasonDataSource!
    private var episodeDataSource: EpisodeDataSource!
    
    // MARK: - Initializers
    init(productionCompanies: [ProductionCompany]) {
        viewModel = AdditionalListModalVM(productionCompanies: productionCompanies)
        super.init(nibName: "AdditionalListModalVC", bundle: nil)
    }
    
    init(networks: [ProductionCompany]) {
        viewModel = AdditionalListModalVM(productionCompanies: networks)
        super.init(nibName: "AdditionalListModalVC", bundle: nil)
    }
    
    init(tvId: Int, seasons: [Season]) {
        self.tvId = tvId
        viewModel = AdditionalListModalVM(seasons: seasons)
        super.init(nibName: "AdditionalListModalVC", bundle: nil)
    }
    
    init(tvId: Int, seasonNumber: Int) {
        viewModel = AdditionalListModalVM(tvId: tvId, seasonNumber: seasonNumber)
        super.init(nibName: "AdditionalListModalVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = AdditionalListModalVM(productionCompanies: [])
        super.init(coder: coder)
    }
    
    // MARK: - Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        if viewModel.listType == .episode {
            setupEpisodeBindings()
        } else {
            setupDataSource()
        }
    }
    
    // MARK: - Setup functions
    private func setupNavigationBar() {
        if viewModel.listType != .episode {
            let rightBarItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
            navigationItem.rightBarButtonItem = rightBarItem
        }
    }
    
    private func setupTableView() {
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "AdditionalListCell", bundle: nil), forCellReuseIdentifier: AdditionalListCell.REUSE_IDENTIFIER)
    }
    
    private func setupDataSource() {
        switch viewModel.listType {
        case .productionCompany, .network:
            productionCompanyDataSource = ProductionCompanyDataSource(tableView: listTableView, cellProvider: { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalListCell.REUSE_IDENTIFIER) as! AdditionalListCell
                cell.setupContents(viewModel: AdditionalListCellVM(productionCompany: item))
                return cell
            })
        case .season:
            seasonDataSource = SeasonDataSource(tableView: listTableView, cellProvider: { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalListCell.REUSE_IDENTIFIER) as! AdditionalListCell
                cell.setupContents(viewModel: AdditionalListCellVM(season: item))
                return cell
            })
        default:
            break
        }
        
        setupSnapshot()
    }
    
    private func setupSnapshot() {
        switch viewModel.listType {
        case .productionCompany, .network:
            var snapshot = ProductionCompanySnapshot()
            snapshot.appendSections([0])
            snapshot.appendItems(viewModel.productionCompanies!)
            productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
        case .season:
            var snapshot = SeasonSnapshot()
            snapshot.appendSections([0])
            snapshot.appendItems(viewModel.seasons!)
            seasonDataSource.apply(snapshot, animatingDifferences: true)
        default:
            break
        }
    }
    
    private func setupEpisodeBindings() {
        Task {
            await viewModel.getEpisodes()
        }
        
        episodeDataSource = EpisodeDataSource(tableView: listTableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalListCell.REUSE_IDENTIFIER) as! AdditionalListCell
            cell.setupContents(viewModel: AdditionalListCellVM(episode: item))
            return cell
        })
        
        viewModel.$episodes
            .receive(on: RunLoop.main)
            .sink { [weak episodeDataSource] value in
                if let value = value {
                    var snapshot = EpisodeSnapshot()
                    snapshot.appendSections([0])
                    snapshot.appendItems(value)
                    episodeDataSource?.apply(snapshot, animatingDifferences: true)
                }
            }.store(in: &bindings)
    }
    
    // MARK: - Custom Functions
    private func routeToEpisodeList(seasonNumber: Int) {
        let vc = AdditionalListModalVC(tvId: tvId ?? 0, seasonNumber: seasonNumber)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Actions
    @objc private func doneAction() {
        dismiss(animated: true)
    }

}

extension AdditionalListModalVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AdditionalListCell.CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.listType == .season {
            let seasonNumber = seasonDataSource.itemIdentifier(for: indexPath)?.seasonNumber ?? 0
            routeToEpisodeList(seasonNumber: seasonNumber)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
