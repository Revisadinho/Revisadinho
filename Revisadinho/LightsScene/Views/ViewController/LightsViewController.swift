//
//  LigthsViewController.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
// swiftlint:disable trailing_whitespace line_length

import UIKit

class LightsViewController: UIViewController {

    var lightsRouter: LightsRouter?
    let lightsView = LightsView()
    var tableViewHeader: UIView?
    var jParser = JsonParser()
    static var tableView: UITableView?
    var lightsInfo: [JSLights] = []
    
    var selectedIndex: IndexPath?
    var selected: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        lightsInfo = jParser.parsingLights()
        lightsView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lightsView.tableView.delegate = self
        lightsView.tableView.dataSource = self
        self.tableViewHeader = lightsView.viewForTableViewHeader
        LightsViewController.tableView = lightsView.tableView
        lightsView.viewControllwe = self
        
        view = lightsView
    }

}
extension LightsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        lightsView.setUpHeaderTableView()
        let viewForHeader = tableViewHeader
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
        print("Selected row: \(indexPath.row)")
        selectedIndex = indexPath
        selected.toggle()
        if let index = selectedIndex {
            tableView.beginUpdates()
            tableView.reloadRows(at: [index], with: .none)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
}
