/*
 MIT License
 
 Copyright (c) 2017 Shoaib Sarwar Cheema
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

class ParallaxViewController: UIViewController {

    private var bgImage: UIImage? = nil
    private var bgImageHeight: CGFloat = 0
    private var tableView: UITableView? = nil
    private var imageView = UIImageView()
    private var transparentNavBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    
    func setup() {
        
        view.insertSubview(imageView, at: 0)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.size.width, height: bgImageHeight))
        imageView.image = bgImage
        
        for subView in view.subviews {
            if subView.isKind(of: UITableView.self) {
                tableView = subView as? UITableView
                break
            }
        }
        
        if transparentNavBar {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = -1 * scrollView.contentOffset.y
        
        if y > 0 {
            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width + y, height: y + bgImageHeight)
            imageView.center = CGPoint(x: view.center.x, y: imageView.center.y)
        }
    }
}

@IBDesignable extension ParallaxViewController {
    
    @IBInspectable var parallaxImage:UIImage? {
        set {
            self.bgImage = newValue
        }
        get {
            return bgImage
        }
    }
    @IBInspectable var parallaxHeight: CGFloat {
        set {
            self.bgImageHeight = newValue
        }
        get {
            return bgImageHeight
        }
    }
    
    @IBInspectable var transparentNavigationBar: Bool {
        set {
            self.transparentNavBar = newValue
        }
        get {
            return transparentNavBar
        }
    }
    
}
