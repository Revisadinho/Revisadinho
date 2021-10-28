//
//  LigthsViewController.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
// swiftlint:disable trailing_whitespace line_length

import UIKit

class LightsViewController: UIViewController {

    var lightsViewModel = LightsViewModel()
    var lightsRouter: LightsRouter?
    let lightsView = LightsView()
    var tableViewHeader: UIView?
    static var tableView: UITableView?
    var lightsInfo: [JSLights] = []
    
    var selectedIndex: IndexPath?
    var selected: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        lightsInfo = lightsViewModel.getLightsInfo()
        lightsView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lightsView.tableView.delegate = self
        lightsView.tableView.dataSource = self
        self.tableViewHeader = lightsView.viewForTableViewHeader
        LightsViewController.tableView = lightsView.tableView
        lightsView.viewControllwe = self
        lightsView.searchBar.delegate = self
        
        view = lightsView
    }

}
extension LightsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeader = tableViewHeader
        lightsView.setUpHeaderTableView()
//        viewForHeader?.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 160))
        viewForHeader?.isUserInteractionEnabled = true
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lightsInfo.count < 1 {
            lightsView.placeholderText.isHidden = false
            lightsView.tableView.bounces = false
            return 0
        } else {
            lightsView.placeholderText.isHidden = true
            lightsView.tableView.bounces = true
            return lightsInfo.count
        }
//        return lightsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LightTableViewCell.identifier, for: indexPath) as? LightTableViewCell
        cell?.iconImageView.image = UIImage(named: lightsInfo[indexPath.row].iconName)?.withRenderingMode(.alwaysOriginal)
        
        cell?.iconLabel.text = lightsInfo[indexPath.row].name
        cell?.descriptionLabel.text = lightsInfo[indexPath.row].description
        cell?.selectionStyle = .none
        cell?.animate()
        return cell ?? LightTableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.cellForRow(at: indexPath) as? LightTableViewCell else { return 56}
        
        if selected {
            let lines = CGFloat(integerLiteral: cell.descriptionLabel.calculateMaxLines())
            if selectedIndex == indexPath { return 56 + (17 * lines) }
        } else {
            return 56
        }
        
        return 56
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")
        selectedIndex = indexPath
        selected.toggle()
        if let index = selectedIndex {
            tableView.beginUpdates()
            tableView.reloadRows(at: [index], with: .none)
            tableView.endUpdates()
        }
    }
    
}

extension LightsViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == "" {
            lightsInfo = lightsViewModel.getLightsInfo()

        } else {
            lightsInfo = lightsViewModel.getLightsByName(name: searchText)
        }
        lightsView.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        lightsView.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Canceled")
        lightsView.removeSearchBar()
        searchBar.endEditing(true)
        searchBar.text = nil
        searchBar.resignFirstResponder()
        lightsInfo = lightsViewModel.getLightsInfo()
        selectedIndex = nil
        selected = false
        lightsView.tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
}
