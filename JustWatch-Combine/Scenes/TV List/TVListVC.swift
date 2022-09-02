//
//  TVListVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import UIKit
import Combine

class TVListVC: UITableViewController {
    // MARK: - Diffable data source typealias
    private typealias DataSource = UITableViewDiffableDataSource<TVListVM.Section, TVSeriesList>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TVListVM.Section, TVSeriesList>
    
    // MARK: - Properties
    private var viewModel: TVListVM!
    private var bindings = Set<AnyCancellable>()
    
    private var dataSource: DataSource!
    
    // MARK: - Initializer
    init() {
        viewModel = TVListVM()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = TVListVM()
        super.init(coder: coder)
    }
    
    // MARK: - Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        title = "TV Shows"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func setupBindings() {
        Task {
            await viewModel.fetchData()
        }
        
        viewModel.$isFetchingData
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                if !value {
                    self?.setupSnapshot()
                }
            }.store(in: &bindings)
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "SectionCell", bundle: nil), forCellReuseIdentifier: SectionCell.REUSE_IDENTIFIER)
        
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionCell.REUSE_IDENTIFIER) as! SectionCell
            let title: String
            switch indexPath.section {
            case 0:
                title = "Popular"
            case 1:
                title = "On The Air"
            case 2:
                title = "Top Rated"
            default:
                title = "Unknown"
            }
            cell.setupContents(with: SectionCellVM(type: .tv, title: title, tvSeries: itemIdentifier.results!))
            cell.addTVSelectHandler(handler: { [unowned self] tvSeries in
                self.navigationController?.pushViewController(TVDetailVC(tvId: tvSeries.ID ?? 0), animated: true)
            })
            return cell
        })
    }
    
    private func setupSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.popular, .onTheAir, .topRated])
        snapshot.appendItems(viewModel.popular, toSection: .popular)
        snapshot.appendItems(viewModel.onTheAir, toSection: .onTheAir)
        snapshot.appendItems(viewModel.topRated, toSection: .topRated)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Actions
    @objc private func refreshAction() {
        Task {
            await viewModel.fetchData()
        }
        refreshControl?.endRefreshing()
    }
    
}

// MARK: - Table view delegate
extension TVListVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SectionCell.CELL_HEIGHT
    }
}
