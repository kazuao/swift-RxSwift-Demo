//
//  FilterService.swift
//  CameraFilter
//
//  Created by Kazunori Aoki on 2021/06/25.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FilterService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    // Observable経由にする
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        
        return Observable<UIImage>.create { observer in
            
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    // 通常の方法でやる場合：completion
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {

        guard let filter = CIFilter(name: "CICMYKHalftone") else {
            return
        }

        filter.setValue(5.0, forKey: kCIInputWidthKey)

        if let sourceImage = CIImage(image: inputImage) {

            filter.setValue(sourceImage, forKey: kCIInputImageKey)

            if let cgimg = self.context.createCGImage(filter.outputImage! , from: filter.outputImage!.extent) {

                let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
