//
//  ViewController.swift
//  CICategoryBlur
//
//  Created by Bourbon on 2021/8/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GaussianBlur()
    }
    
    /// 方形模糊
    func BoxBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter.init(name: "CIBoxBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        
        if let resultCIImage = filter?.outputImage {
            let result = UIImage(ciImage: resultCIImage)
            imageView.image = result
        }
    }
    /// 圆形模糊
    func DiscBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter.init(name: "CIDiscBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        
        if let resultCIImage = filter?.outputImage {
            let result = UIImage(ciImage: resultCIImage)
            imageView.image = result
        }
    }
    /// 高斯模糊
    func GaussianBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter.init(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        
        if let resultCIImage = filter?.outputImage {
            let result = UIImage(ciImage: resultCIImage)
            imageView.image = result
        }
    }
    /// 遮罩模糊
    func MaskedVariableBlur() {
        
    }
    func MedianFilter() {
        
    }
    func MotionBlur() {
        
    }
    func NoiseReduction() {
        
    }
    func ZoomBlur() {
        
    }
}

