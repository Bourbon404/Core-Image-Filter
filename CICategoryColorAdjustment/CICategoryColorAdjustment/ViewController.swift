//
//  ViewController.swift
//  CICategoryColorAdjustment
//
//  Created by Bourbon on 2021/8/13.
//

import UIKit

class ViewController: UIViewController {

    let array : [String] = ["CIColorClamp",
                            "CIColorControls",
                            "CIColorMatrix",
                            "CIColorPolynomial",
                            "CIExposureAdjust",
                            "CIGammaAdjust",
                            "CIHueAdjust",
                            "CILinearToSRGBToneCurve",
                            "CISRGBToneCurveToLinear",
                            "CITemperatureAndTint",
                            "CIToneCurve",
                            "CIVibrance",
                            "CIWhitePointAdjust"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "FilterViewController") {
            vc.title = array[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
}

