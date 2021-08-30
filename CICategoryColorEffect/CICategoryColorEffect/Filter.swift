//
//  Filter.swift
//  CICategoryColorEffect
//
//  Created by Bourbon on 2021/8/30.
//

import UIKit

class Filter: NSObject {

    func outImage(image:UIImage, filter: String) -> UIImage? {
        
        let selector = Selector(filter + "WithImage:name:")
        
        if responds(to: selector) {
            let result = perform(selector, with: image, with: filter)
            if let image = result?.takeUnretainedValue() as? UIImage {
                return image
            }
        }
        return nil
    }
    
    /// 交叉色多项式
    @objc func CIColorCrossPolynomial(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")
        
        let red = CIVector(values: [0,0,1,0,0,0,0,0,0,0], count: 10)
        filter?.setValue(red, forKey: "inputRedCoefficients")
        
        let green = CIVector(values: [0,1,0,0,0,0,0,0,0,0], count: 10)
        filter?.setValue(green, forKey: "inputGreenCoefficients")

        let blue = CIVector(values: [1,0,0,0,0,0,0,0,0,0], count: 10)
        filter?.setValue(blue, forKey: "inputBlueCoefficients")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    
    /// 彩色立方体
    var hue : Float = 0.1
    func RGBtoHSV(_ r : Float, g : Float, b : Float) -> (h : Float, s : Float, v : Float) {
        var h : CGFloat = 0
        var s : CGFloat = 0
        var v : CGFloat = 0
        let col = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        col.getHue(&h, saturation: &s, brightness: &v, alpha: nil)
        return (Float(h), Float(s), Float(v))
    }

    func HSVtoRGB(_ h : Float, s : Float, v : Float) -> (r : Float, g : Float, b : Float) {
        var r : Float = 0
        var g : Float = 0
        var b : Float = 0
        let C = s * v
        let HS = h * 6.0
        let X = C * (1.0 - fabsf(fmodf(HS, 2.0) - 1.0))
        if (HS >= 0 && HS < 1) {
            r = C
            g = X
            b = 0
        } else if (HS >= 1 && HS < 2) {
            r = X
            g = C
            b = 0
        } else if (HS >= 2 && HS < 3) {
            r = 0
            g = C
            b = X
        } else if (HS >= 3 && HS < 4) {
            r = 0
            g = X
            b = C
        } else if (HS >= 4 && HS < 5) {
            r = X
            g = 0
            b = C
        } else if (HS >= 5 && HS < 6) {
            r = C
            g = 0
            b = X
        }
        let m = v - C
        r += m
        g += m
        b += m
        return (r, g, b)
    }
    @objc func CIColorCube(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        // Allocate and opulate color cube table
//        const unsigned int size = 64;
//        float *cubeData = (float *)malloc(size * size * size * sizeof(float) * 4);
//        for (int b = 0; b < size; b++) {
//            for (int g = 0; g < size; r++) {
//                for (int r = 0; r < size; r ++) {
//                    cubeData[b][g][r][0] = <# output R value #>;
//                    cubeData[b][g][r][1] = <# output G value #>;
//                    cubeData[b][g][r][2] = <# output B value #>;
//                    cubeData[b][g][r][3] = <# output A value #>;
//                }
//            }
//        }
//        // Put the table in a data object and create the filter
//        NSData *data = [NSData dataWithBytesNoCopy:cubeData
//                                            length:cubeDataSize
//                                      freeWhenDone:YES];
//        CIFilter *colorCube = [CIFilter filterWithName:@"CIColorCube"
//                                   withInputParameters:@{
//            @"inputCubeDimension": @(size),
//            @"inputCubeData": data,
//        }];
        
        
        let size = 64
        let defaultHue: Float = 0 //default color of blue truck
        let hueRange: Float = 60 //hue angle that we want to replace

        let centerHueAngle: Float = defaultHue/360.0
        var destCenterHueAngle: Float = hue
        let minHueAngle: Float = (defaultHue - hueRange/2.0) / 360
        let maxHueAngle: Float = (defaultHue + hueRange/2.0) / 360
        let hueAdjustment = centerHueAngle - destCenterHueAngle
        if destCenterHueAngle == 0  {
            destCenterHueAngle = 1 //force red if slider angle is 0
        }

        var cubeData = [Float](repeating: 0, count: (size * size * size * 4))
        var offset = 0
        var x : Float = 0, y : Float = 0, z : Float = 0, a :Float = 1.0

        for b in 0..<size {
         x = Float(b)/Float(size)
         for g in 0..<size {
             y = Float(g)/Float(size)
             for r in 0..<size {
                 z = Float(r)/Float(size)
                 var hsv = RGBtoHSV(z, g: y, b: x)
                 
                 if (hsv.h > minHueAngle && hsv.h < maxHueAngle) {
                     hsv.h = destCenterHueAngle == 1 ? 0 : hsv.h - hueAdjustment //force red if slider angle is 360
                     let newRgb = HSVtoRGB(hsv.h, s:hsv.s, v:hsv.v)
                     
                     cubeData[offset] = newRgb.r
                     cubeData[offset+1] = newRgb.g
                     cubeData[offset+2] = newRgb.b
                 } else {
                     cubeData[offset] = z
                     cubeData[offset+1] = y
                     cubeData[offset+2] = x
                 }
                 cubeData[offset+3] =  a
                 offset += 4
             }
         }
        }

        let b = cubeData.withUnsafeBufferPointer{ Data(buffer:$0) }
        let data = b as NSData
        filter?.setValue(data, forKey: "inputCubeData")
        filter?.setValue(size, forKey: "inputCubeDimension")
        

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    
    @objc func CIColorCubeWithColorSpace(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setDefaults()
        #warning("留位置，等待处理")
        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIColorInvert(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")
        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIColorMap(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setValue(ciImage, forKey: "inputGradientImage")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIColorMonochrome(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setValue(CIColor.yellow, forKey: "inputColor")
        filter?.setValue(2, forKey: "inputIntensity")
        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIColorPosterize(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setValue(10, forKey: "inputLevels")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIFalseColor(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")
        
        filter?.setValue(CIColor.black, forKey: "inputColor0")
        filter?.setValue(CIColor.white, forKey: "inputColor1")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIMaskToAlpha(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIMaximumComponent(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIMinimumComponent(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectChrome(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectFade(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectInstant(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectMono(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectNoir(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectProcess(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectTonal(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIPhotoEffectTransfer(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")



        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CISepiaTone(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setValue(5, forKey: "inputIntensity")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIVignette(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setValue(10, forKey: "inputRadius")
        filter?.setValue(10, forKey: "inputIntensity")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }
    @objc func CIVignetteEffect(image : UIImage, name: String) -> UIImage? {
        let filter = CIFilter(name: name)
        let ciImage = CIImage(image: image)
        filter?.setValue(ciImage, forKey: "inputImage")

        filter?.setValue(CIVector(cgPoint: CGPoint(x: 300, y: 100)), forKey: "inputCenter")
        filter?.setValue(0.9, forKey: "inputIntensity")
        filter?.setValue(100, forKey: "inputRadius")

        if let result = filter?.outputImage {
            return UIImage(ciImage: result)
        }
        return nil
    }

}
