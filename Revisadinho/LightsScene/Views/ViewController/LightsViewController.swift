//
//  LigthsViewController.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
// swiftlint:disable trailing_whitespace line_length variable_name inclusive_language

import UIKit
import LightsDetection

enum DashboardLights: CaseIterable {
    case tire_pressure
    case abs
    case airbag
    case battery
    case brake
    case eletronic_injection
    case engine_temperature
    case master
    case oil_pressure
    case seat_belt
    case transmission_temperature
    case traction_control_malfunction
    case traction_control
    case traction_control_off
    
    var number: Int {
        switch self {
        case .tire_pressure: return 0
        case .brake: return 1
        case .master: return 2
        case .battery: return 3
        case .eletronic_injection: return 4
        case .engine_temperature: return 5
        case .traction_control: return 6
        case .traction_control_off: return 7
        case .airbag: return 8
        case .seat_belt: return 9
        case .traction_control_malfunction: return 10
        case .oil_pressure: return 11
        case .abs: return 12
        case .transmission_temperature: return 13
        }
    }
}

class LightsViewController: UIViewController {

    var lightsViewModel = LightsViewModel()
    var lightsRouter: LightsRouter?
    let lightsView = LightsView()
    var tableViewHeader: UIView?
    static var tableView: UITableView?
    var lightsInfo: [JSLights] = []
    
    var descriptionLines: Int = 20
    var titleLines: Int = 1
    
    var selectedIndex: IndexPath?
    var selected: Bool = false

    lazy var lightsDetectionViewController: LightSymbols = {
       return LightSymbols(controller: self)
    }()
    
    var rowIdentified: Int = -1 {
        didSet {
            if oldValue != rowIdentified {
                self.selectCellAt(row: rowIdentified)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        lightsInfo = lightsViewModel.getLightsInfo()
        lightsView.tableView.reloadData()
        setupIdentifyButton()
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
        
        if selected {
            if selectedIndex == indexPath { return CGFloat(56 + descriptionLines) }
        } else {
            
            if indexPath.row == 10 {
                return CGFloat(56 + 4)
                
            }
        }
        
        return 56
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")
        
        guard let cell = tableView.cellForRow(at: indexPath) as? LightTableViewCell else { return }
        
        selectedIndex = indexPath
        selected.toggle()
        if let index = selectedIndex {
            descriptionLines = cell.descriptionLabel.calculateMaxLines() * 18
            
            print("Lines of Title: \(cell.iconLabel.calculateMaxLines())")
            tableView.beginUpdates()
            tableView.reloadRows(at: [index], with: .none)
            tableView.endUpdates()
        }
        lightsView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
//        lightsView.tableView.reloadData()
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

extension LightsViewController: SymbolDetection {
    
    private func setupIdentifyButton() {
        lightsView.identifyButton.addTarget(self, action: #selector(identifyLights), for: .touchUpInside)
    }
    
    private func setupLightsDetectionViewController() {
        OperationQueue.main.addOperation {
            self.lightsDetectionViewController.showViewController()
            self.lightsDetectionViewController.setBackButtonColor(with: .purpleAction)
        }
    }
    
    func getSymbolDetected(symbolName: String) {
        for light in DashboardLights.allCases {
            if "\(light)" == symbolName {
                rowIdentified = light.number
            }
        }
    }
    
    @objc func identifyLights() {
        setupLightsDetectionViewController()
    }
    
    private func selectCellAt(row: Int) {
        let indexPath = NSIndexPath(row: row, section: 0) as IndexPath
        lightsDetectionViewController.dismissViewController()
        lightsView.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        lightsView.tableView.delegate?.tableView?(lightsView.tableView, didSelectRowAt: indexPath)
        lightsView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
