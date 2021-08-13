//
//  ViewController.swift
//  CICategoryColorAdjustment
//
//  Created by Bourbon on 2021/8/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        whitePointAdjust()
    }
    
    /// 色钳
    /// - Returns: void
    func colorClamp() -> Void {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIColorClamp")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0), forKey: "inputMinComponents")
        filter?.setValue(CIVector(x: 0.8, y: 0.8, z: 0.8, w: 0.8), forKey: "inputMaxComponents")

        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    
    ///  饱和度、亮度、对比度
    /// - Returns: Void
    func colorControls() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(50, forKey: "inputSaturation")
        filter?.setValue(50, forKey: "inputBrightness")
        filter?.setValue(50, forKey: "inputContrast")

        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    
    /// 颜色矩阵
    /// - Returns: Void
    func colorMatrix() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIColorMatrix")
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(CIVector(x: 2, y: 0, z: 0, w: 0), forKey: "inputRVector")
        filter?.setValue(CIVector(x: 0, y: 2, z: 0, w: 0), forKey: "inputGVector")
        filter?.setValue(CIVector(x: 0, y: 0, z: 2, w: 0), forKey: "inputBVector")
//        filter?.setValue(CIVector(x: 0, y: 0, z: 0, w: 1), forKey: "inputAVector")
//        filter?.setValue(CIVector(x: 0, y: 0, z: 0, w: 0), forKey: "inputBiasVector")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    func colorPolynomial() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIColorPolynomial")
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(CIVector(x: 0, y: 0, z: 0, w: 0.4), forKey: "inputRedCoefficients")
        filter?.setValue(CIVector(x: 0, y: 0, z: 0.5, w: 0.8), forKey: "inputGreenCoefficients")
        filter?.setValue(CIVector(x: 0, y: 0, z: 0.5, w: 1), forKey: "inputBlueCoefficients")
        filter?.setValue(CIVector(x: 0, y: 1, z: 1, w: 1), forKey: "inputAlphaCoefficients")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 曝光
    /// - Returns: Void
    func exposureAdjust() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIExposureAdjust")
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(5, forKey: "inputEV")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 伽马调整
    /// - Returns: Void
    func gammaAdjust() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIGammaAdjust")
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(5, forKey: "inputPower")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 色调
    /// - Returns: Void
    func hueAdjust() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIHueAdjust")
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(5, forKey: "inputAngle")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 将颜色强度从线性gamma曲线映射到sRGB颜色空间。
    /// - Returns: Void
    func linearToSRGBToneCurve() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CILinearToSRGBToneCurve")
        filter?.setValue(ciImage, forKey: "inputImage")
                
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 将颜色强度从sRGB颜色空间映射到线性gamma曲线。
    /// - Returns: Void
    func sRGBToneCurveToLinear() -> Void {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CISRGBToneCurveToLinear")
        filter?.setValue(ciImage, forKey: "inputImage")
                
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 调整图像的参考白点
    /// - Returns: Void
    func temperatureAndTint() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CITemperatureAndTint")
        filter?.setValue(ciImage, forKey: "inputImage")
                
        filter?.setValue(CIVector(x: 6500, y: 0), forKey: "inputNeutral")
        filter?.setValue(CIVector(x: 6500, y: 0), forKey: "inputTargetNeutral")
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 调整图像的R、G和B通道的色调响应。
    /// - Returns: Void
    func toneCurve() -> Void {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIToneCurve")
        filter?.setValue(ciImage, forKey: "inputImage")
                
        filter?.setValue(CIVector(x: 0, y: 0), forKey: "inputPoint0")
        filter?.setValue(CIVector(x: 0.25, y: 0.25), forKey: "inputPoint1")
        filter?.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
        filter?.setValue(CIVector(x: 0.75, y: 0.75), forKey: "inputPoint3")
        filter?.setValue(CIVector(x: 1, y: 1), forKey: "inputPoint4")

        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    /// 色彩饱和度
    /// - Returns: Void
    func vibrance() -> Void {
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIVibrance")
        filter?.setValue(ciImage, forKey: "inputImage")
                
        filter?.setValue(100, forKey: "inputAmount")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
    func whitePointAdjust() -> Void {
        
        let image = UIImage(named: "1.jpg")
        let ciImage = CIImage(image: image!)
        
        let filter = CIFilter(name: "CIWhitePointAdjust")
        filter?.setValue(ciImage, forKey: "inputImage")
                
        let color = CIColor.yellow
        filter?.setValue(color, forKey: "inputColor")
        
        if let resultCIImage = filter?.outputImage {
            imageView.image = UIImage(ciImage: resultCIImage)
        }
    }
}

