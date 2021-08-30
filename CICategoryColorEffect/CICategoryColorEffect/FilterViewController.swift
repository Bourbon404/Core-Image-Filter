//
//  FilterViewController.swift
//  CICategoryColorEffect
//
//  Created by Bourbon on 2021/8/30.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var filterImageView: UIImageView!
    
    var fileName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = fileName
        // Do any additional setup after loading the view.
        
        filterImageView.image = Filter().outImage(image: originImageView.image!, filter: fileName)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
