# CoreImage中的色彩调节

[TOC]

这里主要介绍的是`CICategoryColorAdjustment`这个滤镜下面的特效，主要内容是关于图片色彩的调整

本节内容涉及到一些图像处理专业名词，本质是图像处理的一种方式，名词解释不做赘述，仅供简单罗列

首先来看下原图的效果

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqr2n01yoj60hq0d7god02.jpg" alt="flower" width="50%;" />

##  CIColorClamp

定义为色钳，操作为修改颜色值以使其保持在指定范围内。

根据定义，这里提供了两个参数

- *inputMinComponents* 范围下限的`RGBA`值。属性类型为`CiAttributeTypectAngle`且显示名称为`MinComponents`的`CIVector`对象，默认值为[0 0 0 0]
- *inputMaxComponents*范围上限的`RGBA`值。属性类型为`CiAttributeTypeCTAngle`且显示名称为`MaxComponents`的`CIVector`对象，默认值为[1 1 1 1]

这是执行后的效果：

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqopb0ulrj60ia0dumyn02.jpg" alt="截屏2021-08-23 下午2.01.31" width="50%;" />

## CIColorControls

此滤镜主要负责调整饱和度、亮度和对比度值。

根据定义，提供了三个参数来改变效果

- *inputSaturation* 饱和度，默认值为1
- *inputBrightness* 亮度
- *inputContrast* 对比度，默认值为1

下面是简单的使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqouy9twbj60hw0dwab602.jpg" alt="截屏2021-08-23 下午2.07.00" width="50%;" />

## CIColorMatrix

此滤镜是通过矩阵变换来调整颜色，文档中的解释是将源颜色值相乘，并向每个颜色组件添加一个偏移因子。

根据定义这里提供了5个参数

- *inputRVector* 显示名称为红色向量的`CIVector`对象。
- *inputGVector* 显示名称为绿色向量的`CIVector`对象。
- *inputBVector* 显示名称为蓝色向量的`CIVector`对象。
- *inputAVector* 显示名称为透明度向量的`CIVector`对象。
- *inputBiasVector* 显示名称为“偏移向量”的`CIVector`对象。

此过滤器执行矩阵乘法，如下所示，以变换颜色向量：

```c
1. s.r = dot(s, redVector) 
2. s.g = dot(s, greenVector) 
3. s.b = dot(s, blueVector) 
4. s.a = dot(s, alphaVector)
5. s = s + bias
```

下面是简单使用的效果

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqp5t3yjoj60iy0ecgnw02.jpg" alt="截屏2021-08-23 下午2.17.14" width="50%;" />

## CIColorPolynomial

颜色多项式，此滤镜的文档中是这样定义的：通过应用一组三次多项式修改图像中的像素值。

根据定义，文档中定义了一下参数

- *inputRedCoefficients* 属性类型为`CiAttributeTypectAngle`且显示名称为`RedCourters的CIVector`对象。默认值为[0 1 0 0]
- *inputGreenCoefficients* 属性类型为`CiAttributeTypectAngle`且显示名称为`GreenCourters的CIVector`对象。默认值为 [0 1 0 0] 
- *inputBlueCoefficients* 属性类型为`CiAttributeTypectAngle`且显示名称为`BlueCourters`的`CIVector`对象。默认值为[0 1 0 0] 
- *inputAlphaCoefficients* 属性类型为`CiAttributeTypeCTAngle`且显示名称为`AlphaCourters`的`CIVector`对象。默认值为[0 1 0 0] 

对于每个像素，每个颜色分量的值被视为三次多项式的输入，其系数按升序从相应的输入系数参数中获取。相当于以下公式：

1. `r = rCoeff[0] + rCoeff[1] * r + rCoeff[2] * r*r + rCoeff[3] * r*r*r `
2. `g = gCoeff[0] + gCoeff[1] * g + gCoeff[2] * g*g + gCoeff[3] * g*g*g `
3. `b = bCoeff[0] + bCoeff[1] * b + bCoeff[2] * b*b + bCoeff[3] * b*b*b `
4. `a = aCoeff[0] + aCoeff[1] * a + aCoeff[2] * a*a + aCoeff[3] * a*a*a`

下面是滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqr5g50r0j60iu0e240m02.jpg" alt="截屏2021-08-23 下午2.25.57" width="50%;" />

## CIExposureAdjust

曝光调整，次滤镜顾名思义就是调整图片曝光

文档中定义了一个参数

- *inputEV* 属性类型为`CIAttributeTypeScalar`且显示名称为`EV`的`NSNumber`对象。默认值为0.5

此滤镜将颜色值相乘，如下所示，以指定的F光圈模拟曝光变化：

`s.rgb * pow(2.0, ev)`

下面是滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqr5l6wqjj60iq0e6go102.jpg" alt="截屏2021-08-23 下午2.30.08" width="50%;" />

## CIGammaAdjust

图片伽马调整，此滤镜的方式是将图片进行伽马调整，此方式提供了一个参数

- *inputPower* 属性类型为`CIAttributeTypeScalar`且显示名称为`Power`的`NSNumber`对象。默认值为0.75

该滤波器通常用于补偿显示器的非线性效应。调整`gamma`可以有效地更改黑白过渡的坡度。它使用以下公式：

`pow(s.rgb, vec3(power))`

下面是此滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqpp41no5j60ik0ecjt902.jpg" alt="截屏2021-08-23 下午2.35.59" width="50%;" />

## CIHueAdjust

色调调整，更改源像素的整体色调。次滤镜提供了下面一个参数

- *inputAngle* 属性类型为`CIAttributeTypeAngle`且显示名称为`Angle的NSNumber`对象。默认值为0

下面是次滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqps3r5dnj60i80dodhm02.jpg" alt="截屏2021-08-23 下午2.38.51" width="50%;" />

## CILinearToSRGBToneCurve

将颜色强度从线性gamma曲线映射到sRGB颜色空间。这个滤镜没有参数，直接看下面的效果

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqpwv4mt1j60ii0dwgnt02.jpg" alt="截屏2021-08-23 下午2.43.26" width="50%;" />

## CISRGBToneCurveToLinear

将颜色强度从sRGB颜色空间映射到线性gamma曲线。这个滤镜同上面一样，也没有参数，直接看下面的效果

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqpyx2w3jj60i20du40b02.jpg" alt="截屏2021-08-23 下午2.45.24" width="50%;" />

## CITemperatureAndTint

此滤镜为调整图像的参考白点。这种方式提供了两个参数

- *inputNeutral* 属性类型为`CIAttributeTypeOffset`且显示名称为中性的`CIVector`对象。默认值为[6500, 0]
- *inputTargetNeutral* 属性类型为`CIAttributeTypeOffset`且显示名称为`TargetNeutral`的`CIVector`对象。默认值为[6500, 0]

下面是简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqq8gvpiaj60i60dstao02.jpg" alt="截屏2021-08-23 下午2.54.35" width="50%;" />

## CIToneCurve

色调曲线，调整图像的R、G和B通道的色调。此种滤镜提供了下面5个参数来调控

- *inputPoint0*  默认值为[0,0]
- *inputPoint1* 默认值为[0.25,0.25]
- *inputPoint2*  默认值为[0.5,0.5]
- *inputPoint3* 默认值为[0.75,0.75]
- *inputPoint4* 默认值为[1,1]

下面是滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqqfb2lmoj60i40di0uv02.jpg" alt="截屏2021-08-23 下午3.01.09" width="50%;" />

## CIVibrance

饱和度调整，调整图像的饱和度，同时保持令人愉悦的肤色。此滤镜提供一个参数来调整

- *inputAmount* 

下面是此滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqr5wewxmj60i20dignk02.jpg" alt="截屏2021-08-23 下午3.05.38" width="50%;" />

## CIWhitePointAdjust

调整图像的参考白点，并使用新参考映射源中的所有颜色。此滤镜需要一个参数

- *inputColor*

下面是滤镜的简单使用

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtqqobf4hnj60hw0dodh402.jpg" alt="截屏2021-08-23 下午3.09.49" width="50%;" />