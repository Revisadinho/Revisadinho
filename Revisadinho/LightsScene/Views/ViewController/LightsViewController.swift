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
    var lightsInfo: [JSLights] = []
    
    override func viewWillAppear(_ animated: Bool) {
        lightsInfo = jParser.parsingLights()
        lightsView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lightsView.tableView.delegate = self
        lightsView.tableView.dataSource = self
        self.tableViewHeader = lightsView.viewForTableViewHeader
        view = lightsView
//        lightsView.tableView.tableHeaderView = lightsView.viewForTableViewHeader
//        lightsView.setUpHeaderTableView()
//        setupTableView()
//        view.addSubview(tableView)
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
        let cell = LightTableViewCell()
        let imageIn = UIImage(named: lightsInfo[indexPath.row].iconName)?.withRenderingMode(.alwaysOriginal)
        
        cell.iconImageView.image = imageIn
        
        cell.iconLabel.text = lightsInfo[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
}
