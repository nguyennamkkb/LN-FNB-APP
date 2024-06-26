//
//  Extensions.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
import FittedSheets
import MobileCoreServices


typealias ClosureAction = ()->Void
typealias ClosureComplet = (Bool)->Void
typealias ClosureCustom<T> = ((_ item: T) -> Void)


extension UIButton{
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor

            func addBorder(to edges: UIRectEdge) {
                if edges.contains(.top) {
                    border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
                    self.layer.addSublayer(border)
                }
                if edges.contains(.left) {
                    border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
                    self.layer.addSublayer(border)
                }
                if edges.contains(.right) {
                    border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
                    self.layer.addSublayer(border)
                }
                if edges.contains(.bottom) {
                    border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
                    self.layer.addSublayer(border)
                }
            }

            addBorder(to: edges)
        }
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
    
}
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func registerCells(cells: [String], bundle: Bundle? = nil) {
        for cell in cells {
            let cellNib = UINib(nibName: cell, bundle: bundle)
            self.register(cellNib, forCellReuseIdentifier: cell)
        }
    }
    
    func registerCell(nibName: String, bundle: Bundle? = nil) {
        let cellNib = UINib(nibName: nibName, bundle: bundle)
        self.register(cellNib, forCellReuseIdentifier: nibName)
    }
    
    func registerHeaders(headers: [String], bundle: Bundle? = nil) {
        for cell in headers {
            let cellNib = UINib(nibName: cell, bundle: bundle)
            self.register(cellNib, forHeaderFooterViewReuseIdentifier: cell)
        }
    }
    
    func setupEstimateRowTableView(_ estimatedRowHeight: CGFloat) {
        self.estimatedRowHeight = estimatedRowHeight
        self.rowHeight = UITableView.automaticDimension
    }
    
    func commonInit(estimatedRowHeight: CGFloat? = nil){
        self.keyboardDismissMode = .onDrag
        self.tableFooterView = UIView(frame: .zero)
        if let estimatedRowHeight = estimatedRowHeight {
            self.rowHeight = UITableView.automaticDimension
            self.estimatedRowHeight = estimatedRowHeight
        }
    }
    func tableToImage() -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(self.contentSize, false, 0.0)
            
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            
            for i in 0..<self.numberOfSections {
                let section = self.rect(forSection: i)
                for j in 0..<self.numberOfRows(inSection: i) {
                    let indexPath = IndexPath(row: j, section: i)
                    if let cell = self.cellForRow(at: indexPath) {
                        let rect = self.rectForRow(at: indexPath)
                        cell.frame = rect.offsetBy(dx: section.origin.x, dy: section.origin.y)
                        cell.layer.render(in: context)
                    }
                }
            }
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
        }
}

extension Array {
    //Lấy item tại index đã check nil
    func itemAtIndex(index: Int) -> Element? {
        if self.count > index, index >= 0 {
            return self[index]
        } else {
            return nil
        }
    }
}

extension String {
    func removeAccents() -> String {
        return self.folding(options: .diacriticInsensitive, locale: nil)
                       .replacingOccurrences(of: "đ", with: "d")
                       .replacingOccurrences(of: "Đ", with: "D")
        }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func prepareForSearch(_ shouldRemoveWhiteSpace: Bool = true) -> String {
        var newStr = self.folding(options: .diacriticInsensitive, locale: Locale.current)
        
        newStr = newStr.lowercased()
        
        newStr = newStr.replacingOccurrences(of: "đ", with: "d", options: NSString.CompareOptions.literal, range: nil)
        if shouldRemoveWhiteSpace {
            newStr = newStr.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        }
        
        return newStr
    }
    
    func split(_ charactor: String) -> [String] {
        return self.split(whereSeparator: {String($0) == charactor}).map(String.init)
    }
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = ""
            formatter.maximumFractionDigits = 0
            formatter.minimumFractionDigits = 0
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}


extension UIView {
    func round() {
        radius(self.bounds.size.height/2)
    }
    
    @objc func radius(_ value: CGFloat = 5) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
    
    func customRound(corner: CGFloat, mask: CACornerMask ) {
        self.clipsToBounds = true
        self.layer.cornerRadius = corner
        self.layer.maskedCorners = mask
    }
    func addShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
    }
    func addCornerRadiusToBottom(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension CGImage {
    func imageSizeInBytes() -> Int {
        let bytesPerPixel = 4 // Giả sử mỗi điểm ảnh có 4 byte (RGBA)
        let bytesPerRow = bytesPerPixel * self.width
        return bytesPerRow * self.height
    }
}
extension UIImage {
    func reducePixelQuality(quality: CGFloat) -> UIImage? {
            guard let imageData = self.jpegData(compressionQuality: quality) else { return nil }
            return UIImage(data: imageData)
        }
//    func reducePixelQuality(quality: CGFloat) -> CGImage? {
//            guard let cgImage = self.cgImage else { return nil }
//            
//            let imageData = NSMutableData()
//            guard let destination = CGImageDestinationCreateWithData(imageData, kUTTypeJPEG, 1, nil) else { return nil }
//            
//            let options: [NSString: Any] = [kCGImageDestinationLossyCompressionQuality: quality]
//            CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
//            CGImageDestinationFinalize(destination)
//            
//            guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
//            
//            let cgImageOptions: [NSString: Any] = [
//                kCGImageSourceShouldCache: false,
//                kCGImageSourceCreateThumbnailFromImageAlways: true,
//                kCGImageSourceThumbnailMaxPixelSize: max(self.size.width, self.size.height)
//            ]
//            
//            guard let thumbnail = CGImageSourceCreateThumbnailAtIndex(source, 0, cgImageOptions as CFDictionary) else { return nil }
//            return thumbnail
//        }
    func resized(toWidth width: CGFloat) -> UIImage {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = true
        return UIGraphicsImageRenderer(size: canvasSize, format: format).image {
          _ in draw(in: CGRect(origin: .zero, size: canvasSize))
        }
      }
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    func resizeImage(maxWidth: CGFloat) -> UIImage {
        let aspectRatio = self.size.width / self.size.height
        let newWidth = min(maxWidth, self.size.width)
        let newHeight = newWidth / aspectRatio
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
            
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = opaque
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        return newImage
    }
    
}
extension UIImageView {
    // Hàm này sẽ load một hình ảnh từ url và hiển thị nó trên UIImageView
    func loadImageFromUrl(from url: URL) {
        // Tạo một URLSession để tải dữ liệu từ url
        let session = URLSession.shared
        // Tạo một task để tải dữ liệu từ url
        let task = session.dataTask(with: url) { data, response, error in
            // Kiểm tra xem có lỗi không
            if let error = error {
                // Nếu có lỗi, in ra lỗi và thoát khỏi hàm
                print(error.localizedDescription)
                return
            }
            // Kiểm tra xem có dữ liệu không
            if let data = data {
                // Nếu có dữ liệu, tạo một UIImage từ dữ liệu
                let image = UIImage(data: data)
                // Cập nhật giao diện trên main thread
                DispatchQueue.main.async {
                    // Gán hình ảnh cho UIImageView
                    self.image = image
                }
            }
        }
        // Bắt đầu task
        task.resume()
    }
}
extension UIViewController {
    public func showSheet(controller: UIViewController, sizes: [SheetSize]) {
        let controller = SheetViewController(controller:controller, sizes: sizes)
        controller.overlayColor = UIColor.black.withAlphaComponent(0.4)
        controller.cornerRadius = 16
        self.present(controller, animated: false, completion: nil)
    }
    
    public var sheetViewController: SheetViewController? {
        var parent = self.parent
        while let currentParent = parent {
            if let sheetViewController = currentParent as? SheetViewController {
                return sheetViewController
            } else {
                parent = currentParent.parent
            }
        }
        return nil
    }
}


extension UITextField {
    func setBottomLine(color: UIColor = .white) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: (SCREEN_WIDTH - 40)/2, height: 1.0)
        bottomLine.backgroundColor = color.withAlphaComponent(0.6).cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}


extension Double {
    func roundDouble(maxFraction: Int = 2) -> Double {
        let currencyStyle = NumberFormatter()
        currencyStyle.numberStyle = .decimal
        currencyStyle.maximumFractionDigits = maxFraction
        currencyStyle.roundingMode = .halfUp
        
        let locale = Locale.current
        currencyStyle.locale = locale
        currencyStyle.groupingSeparator = locale.groupingSeparator ?? "."
        currencyStyle.groupingSize = 3
        currencyStyle.alwaysShowsDecimalSeparator = false
        currencyStyle.usesGroupingSeparator = true
        currencyStyle.isLenient = true
        let formatedString = currencyStyle.string(from: NSNumber(value: self)) ?? ""
        let formatedNumber = currencyStyle.number(from: formatedString)
        return formatedNumber?.doubleValue ?? 0
    }
    
    func formatNumber(maxFraction: Int = 2) -> String {
        let currencyStyle = NumberFormatter()
        currencyStyle.numberStyle = .decimal
        currencyStyle.maximumFractionDigits = maxFraction
        currencyStyle.roundingMode = .halfUp
        
        let locale = Locale.current
        currencyStyle.locale = locale
        currencyStyle.groupingSeparator = locale.groupingSeparator ?? "."
        currencyStyle.groupingSize = 3
        currencyStyle.alwaysShowsDecimalSeparator = false
        currencyStyle.usesGroupingSeparator = true
        currencyStyle.isLenient = true
        let formatedString = currencyStyle.string(from: NSNumber(value: self)) ?? ""
        return formatedString
    }
}

extension Int {
    func formatNumberInt(maxFraction: Int = 2) -> String {
        let currencyStyle = NumberFormatter()
        currencyStyle.numberStyle = .decimal
        currencyStyle.maximumFractionDigits = maxFraction
        currencyStyle.roundingMode = .halfUp
        
        let locale = Locale.current
        currencyStyle.locale = locale
        currencyStyle.groupingSeparator = locale.groupingSeparator ?? "."
        currencyStyle.groupingSize = 3
        currencyStyle.alwaysShowsDecimalSeparator = false
        currencyStyle.usesGroupingSeparator = true
        currencyStyle.isLenient = true
        let formatedString = currencyStyle.string(from: NSNumber(value: self)) ?? ""
        return formatedString
    }
}

extension Thread {
    class func runOnMain(block: @escaping (() -> Void)){
        if Thread.isMainThread == false {
            DispatchQueue.main.async(execute: {
                block()
            })
        }else{
            block()
        }
    }
    
    class func runOnMain(after: TimeInterval,block: @escaping (() -> Void)){
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            block()
        }
    }
    
    class func runOnBackground(block: @escaping (() -> Void)){
        if Thread.isMainThread == true {
            DispatchQueue(label: "QueueIdentification", qos: .background).async(execute: {
                block()
            })
        }else{
            block()
        }
    }
    
}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
    func resizeWidth(_ width: CGFloat) -> UIImage? {
        let scale = width / self.size.width
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: width, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return resizedImage
    }
    func convertImageToBlackAndWhite() -> UIImage? {
        if let ciImage = CIImage(image: self) {
            let filter = CIFilter(name: "CIPhotoEffectMono")
            filter?.setValue(ciImage, forKey: kCIInputImageKey)

            if let outputImage = filter?.outputImage {
                let context = CIContext(options: nil)
                if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}


// bo goc canh tuy chon
//vd: view.roundCorners(corners: [.topLeft, .bottomLeft], radius: CGFloat(Common.RADIUS))
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
}

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController,
                                  animated: Bool = true,
                                  duration: TimeInterval = 0.5,
                                  options: AnimationOptions = .curveEaseIn,
                                  completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            var hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                hexColor.append("ff")
            }
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
