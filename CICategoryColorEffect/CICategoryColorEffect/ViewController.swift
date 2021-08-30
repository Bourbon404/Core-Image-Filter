//
//  ViewController.swift
//  CICategoryColorEffect
//
//  Created by Bourbon on 2021/8/30.
//

import UIKit

class ViewController: UIViewController {

    let array : [String] = ["CIColorCrossPolynomial",
                            "CIColorCube",
                            "CIColorCubeWithColorSpace",
                            "CIColorInvert",
                            "CIColorMap",
                            "CIColorMonochrome",
                            "CIColorPosterize",
                            "CIFalseColor",
                            "CIMaskToAlpha",
                            "CIMaximumComponent",
                            "CIMinimumComponent",
                            "CIPhotoEffectChrome",
                            "CIPhotoEffectFade",
                            "CIPhotoEffectInstant",
                            "CIPhotoEffectMono",
                            "CIPhotoEffectNoir",
                            "CIPhotoEffectProcess",
                            "CIPhotoEffectTonal",
                            "CIPhotoEffectTransfer",
                            "CISepiaTone",
                            "CIVignette",
                            "CIVignetteEffect"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let string = array[indexPath.row]
        cell.textLabel?.text = string
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(identifier: "FilterViewController") as? FilterViewController {
            vc.fileName = array[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
