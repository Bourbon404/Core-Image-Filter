# `CoreImage`中的模糊处理

`CoreImage`是`iOS`系统内置的图像处理框架，提供了以下8种方式来进行模糊处理

首先展示原图

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtexh57oyuj60et0m8mzn02.jpg" alt="1" style="zoom: 33%;" />

## 介绍

1. `CIBoxBlur`方形模糊

   先看文档原文

   `Blurs an image using a box-shaped convolution kernel.`

   意思是用一个盒型来模糊图像，除了图像参数`inputImage`外（下面每种方式都具备次参数，后面不在赘述），还具备一个参数

   - 半径`inputRadius`参数，此默认值为10

   下面是处理的结果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtexjinr4lj60u01sxjvl02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.00.24" style="zoom:15%;" />

2. `CIDiscBlur`圆形模糊

   和上面的类似，这里只不过采用的是圆形来模糊图像，还具备一个参数

   - 半径`inputRadius`参数，默认值为8

   下面是处理结果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtexluf90yj60u01sx42302.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.02.46" style="zoom:15%;" />

3. `CIGaussianBlur`高斯模糊

   高斯模糊是一种大家都很熟悉的模糊方式，高斯模糊的算法也很出名，在`iOS`上实现也很简单，还具备一个参数

   - 半径`inputRadius`即可，该值默认是10

   下面是处理结果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtexouk2elj60u01sxad302.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.05.37" style="zoom:15%;" />

4. `CIMaskedVariableBlur`遮罩模糊

   先看文档原文

   `Blurs the source image according to the brightness levels in a mask image.`

   翻译过来就是在原始图层上覆盖一个遮罩层，遮罩具备模糊效果，同时控制遮罩层亮度来控制显示。

   具备如下参数

   - `inputMask` 遮罩层
   - `inputRadius`遮罩层亮度，值范围是[0,100]

   下面分别是遮罩和最终效果，还有一个效果2

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtey3wvmnuj60u01sx41i02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.13.01" style="zoom:15%;" /><img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtey3w8ce3j60u01sxgpe02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.09.42" style="zoom:15%;" /><img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtey6oh0gwj60u01sxtd602.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.19.18" style="zoom:15%;" />

   * 需要注意的是：
     * 如果两个图片大小不一致，遮罩层是从左下角开始绘制，效果如上面效果2
     * 我在这里遇到了问题，设置遮罩后图像向右侧偏移了，暂未找到具体原因

5. `CIMedianFilter`均值模糊

   先看文档原文

   `Computes the median value for a group of neighboring pixels and replaces each pixel value with the median.`

   理解为两个像素取中间值，然后循环计算这个图像，得到一个模糊后的效果，均值计算也是现有算法，算法逻辑不做陈述。

   这种方式没有参数，直接得到最终效果，此方法经常利用在图像降噪处理，附上最终效果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gteyn7pnz7j60u01sxn2n02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.33.11" style="zoom:15%;" />

   

6. `CIMotionBlur`运动模糊

   类似于模拟图像在运动时，以一定角度拍摄下的图像，此时具备的模糊效果

   具备以下两个参数

   - 角度`inputAngle`参数，默认值为0；
   - 半径`inputRadius`或者理解为速度参数，默认值为20

   附上实现效果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gteyrdx637j60u01sxdiu02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.42.34" style="zoom:15%;" />

   

7. `CINoiseReduction`降噪模糊

   先看文档原文

   `Small changes in luminance below that value are considered noise and get a noise reduction treatment, which is a local blur. Changes above the threshold value are considered edges, so they are sharpened.`

   理解为这种方式同时具备降噪和锐化处理，通过一个值来判断，小于时进行降噪，大于则进行锐化

   这种方式具备两个参数

   - `inputNoiseLevel`噪声等级，默认值是0.02；

   - `inputSharpness`锐化，默认值是0.4

   附上展示效果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtez08d8jyj60u01sxq7u02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.51.11" style="zoom:15%;" />

8. `ZoomBlur`缩放模糊

   已缩放的形式，来模拟模糊状态，这里具备两个参数

   - `inputCenter`中心位置，这里强调，传入的参数类型是`CIVector`，默认值为(150, 150)
   - `inputAmount`缩放量，默认值为20

   附上展示效果

   <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gtez6fs1exj60u01sxgow02.jpg" alt="Simulator Screen Shot - iPhone 12 Pro Max - 2021-08-13 at 10.57.04" style="zoom:15%;" />

   ## 总结

   系统提供了以上几种方式来进行模糊处理，方式各有特点，具体依据应用场景来选择，需要注意的是以上的操作都是需要在主线程上进行，而且耗时，使用时依照图片大小和丰富程度，做好等待状态

