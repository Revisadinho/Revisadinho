//
//  ViewController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 13/09/21.
// swiftlint:disable trailing_whitespace line_length

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let thirdHeightView = self.view.frame.height / 3
        let redSquare = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: thirdHeightView))
        redSquare.backgroundColor = .red
        let greenSquare = UIView(frame: CGRect(x: 0, y: thirdHeightView, width: self.view.frame.width, height: thirdHeightView))
        greenSquare.backgroundColor = .green
  
        let blueSquare = UIView(frame: CGRect(x: 0, y: thirdHeightView + thirdHeightView, width: self.view.frame.width, height: thirdHeightView))
        blueSquare.backgroundColor = .blue
        view.addSubview(redSquare)
        view.addSubview(greenSquare)
        view.addSubview(blueSquare)
    }

}
