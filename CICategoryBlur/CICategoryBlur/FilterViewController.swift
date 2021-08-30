//
//  FilterViewController.swift
//  CICategoryBlur
//
//  Created by Bourbon on 2021/8/30.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var originImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let selector = Selector(title ?? "")
        perform(selector)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /// 方形模糊
    @objc func CIBoxBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIBoxBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")

        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 圆形模糊
    @objc func CIDiscBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIDiscBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")

        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 高斯模糊
    @objc func CIGaussianBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")

        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 遮罩模糊
    @objc func CIMaskedVariableBlur() {

        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let maskImage = UIImage(named: "2.png")
        let maskCIImage = CIImage(image: maskImage!)

        let filter = CIFilter(name: "CIMaskedVariableBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        filter?.setValue(maskCIImage, forKey: "inputMask")

        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 均值模糊
    @objc func CIMedianFilter() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CIMedianFilter")
        filter?.setValue(ciImage, forKey: "inputImage")
        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 运动模糊
    @objc func CIMotionBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CIMotionBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(20, forKey: "inputRadius")
        filter?.setValue(0, forKey: "inputAngle")
        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 降噪模糊
    @objc func CINoiseReduction() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CINoiseReduction")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputNoiseLevel")
        filter?.setValue(10, forKey: "inputSharpness")

        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 缩放模糊
    @objc func CIZoomBlur() {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)

        let filter = CIFilter(name: "CIZoomBlur")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(CIVector(x: resultImageView.center.x, y: resultImageView.center.y), forKey: "inputCenter")
        filter?.setValue(20, forKey: "inputAmount")
        if let resultCIImage = filter?.outputImage {
            resultImageView.image = UIImage(ciImage: resultCIImage)
        }
    }
}

