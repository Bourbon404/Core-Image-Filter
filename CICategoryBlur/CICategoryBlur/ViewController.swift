//
//  ViewController.swift
//  CICategoryBlur
//
//  Created by Bourbon on 2021/8/12.
//

import UIKit

class ViewController: UIViewController {

    let array : [String] = ["CIBoxBlur",
                            "CIDiscBlur",
                            "CIGaussianBlur",
                            "CIMaskedVariableBlur",
                            "CIMedianFilter",
                            "CIMotionBlur",
                            "CINoiseReduction",
                            "CIZoomBlur"]

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
}

