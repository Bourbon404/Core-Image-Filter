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
        ZoomBlur()
    }
    
    /// 方形模糊
    func BoxBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIBoxBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 圆形模糊
    func DiscBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIDiscBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 高斯模糊
    func GaussianBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 遮罩模糊
    func MaskedVariableBlur() {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let maskImage = UIImage(named: "2.png")
        let maskCIImage = CIImage(image: maskImage!)
        
        let filter = CIFilter(name: "CIMaskedVariableBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        filter?.setValue(maskCIImage, forKey: "inputMask")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 均值模糊
    func MedianFilter() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CIMedianFilter")
        filter?.setValue(ciImage, forKey: "inputImage")
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 运动模糊
    func MotionBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CIMotionBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(20, forKey: "inputRadius")
        filter?.setValue(0, forKey: "inputAngle")
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 降噪模糊
    func NoiseReduction() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CINoiseReduction")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputNoiseLevel")
        filter?.setValue(10, forKey: "inputSharpness")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 缩放模糊
    func ZoomBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CIZoomBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(CIVector(x: imageView.frame.midX, y: imageView.frame.midY), forKey: "inputCenter")
        filter?.setValue(20, forKey: "inputAmount")
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
}

