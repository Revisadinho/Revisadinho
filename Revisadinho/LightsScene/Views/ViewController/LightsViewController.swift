//
//  LigthsViewController.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
// swiftlint:disable trailing_whitespace line_length variable_name

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
    case trasmission_temperature
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
        case .trasmission_temperature: return 13
        }
    }
}

enum DeselectCell {
    case camera
    case user
}

class LightsViewController: UIViewController {

    var lightsViewModel = LightsViewModel()
    var lightsRouter: LightsRouter?
    let lightsView = LightsView()
    var tableViewHeader: UIView?
    static var tableView: UITableView?
    var lightsInfo: [JSLights] = []
    
    var selectedIndex: IndexPath?
    var selected: Bool = false
    
    var selector: DeselectCell = .user
    
    lazy var lightsDetectionViewController: LightSymbols = {
       return LightSymbols(controller: self)
    }()
    
    var rowIdentified: Int = -1 {
        didSet {
            if oldValue != rowIdentified {
                self.deselectCellAt(row: oldValue)
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
//        viewForHeader?.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 160))
        viewForHeader?.isUserInteractionEnabled = true
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lightsInfo.count
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
        selectedIndex = indexPath
        
        if selector == .camera {
            selected = true
            selector = .user
        } else {
            selected.toggle()
        }
        
        if let index = selectedIndex {
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            tableView.beginUpdates()
            tableView.reloadRows(at: [index], with: .none)
            tableView.endUpdates()
        }
    }
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndex = nil
        selected = false
        tableView.reloadData()
    }
}

extension LightsViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchBar.text!)
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
        for light in DashboardLights.allCases where "\(light)" == symbolName {
                print(symbolName)
                rowIdentified = light.number
        }
    }
    
    @objc func identifyLights() {
        setupLightsDetectionViewController()
    }
    
    private func selectCellAt(row: Int) {
        let indexPath = NSIndexPath(row: row, section: 0) as IndexPath
        lightsDetectionViewController.dismissViewController()
        lightsView.tableView.delegate?.tableView?(lightsView.tableView, didSelectRowAt: indexPath)
    }
    
    private func deselectCellAt(row: Int) {
        let indexPath = NSIndexPath(row: row, section: 0) as IndexPath
        lightsView.tableView.deselectRow(at: indexPath, animated: true)
        selector = .camera
    }
}
