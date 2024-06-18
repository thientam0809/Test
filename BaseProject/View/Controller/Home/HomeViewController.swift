//
//  HomeViewController.swift
//  BaseProject
//
//  Created by Nguyen Khanh Thien Tam on 10/06/2024.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - IBOulets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: HomeViewModel?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadLocal()
        getApi()
    }
    
    // MARK: - Private methods
    private func configTableView() {
        tableView.register(HomeCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadLocal() {
        viewModel?.loadLocalDate()
        tableView.reloadData()
    }
    
    private func getApi() {
        viewModel?.getWorkouts(completion: { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    this.tableView.reloadData()
                }
            case .failure(let failure):
                // TODO: - Show alert
                break
            }
        })
    }
}

// MARK: - Extension UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowInSection(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: HomeCell.self, forIndexPath: indexPath)
        cell.delegate = self
        cell.viewModel = viewModel?.viewModelForItem(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: HomeCellDelegate {
    func cell(_ cell: HomeCell, needPerfom action: HomeCell.Action) {
        switch action {
        case .isTap(let id):
            viewModel?.setIdSelect(id: id)
            tableView.reloadData()
        }
    }
}
