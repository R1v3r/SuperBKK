//
//  NavigationViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

public class NavigationViewController: UINavigationController, UIGestureRecognizerDelegate {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: init
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    public init() {
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: nil)
        
        self.initialize()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: nil)
        
        self.viewControllers = [rootViewController]
        
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.initialize()
    }
    
    func initialize() {
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: ViewController
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        #if os(iOS)
            self.interactivePopGestureRecognizer?.delegate = self
        #endif
    }
    
    func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: gesture recognizer delgate
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.topViewController == self.viewControllers.last && self.viewControllers.count > 1
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: autorotation
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    #if os(iOS)
    public override var shouldAutorotate: Bool {
        if let shouldRotate = self.topViewController?.shouldAutorotate {
            return shouldRotate
        }
        return super.shouldAutorotate
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let orientation = self.topViewController?.supportedInterfaceOrientations {
            return orientation
        }
        return super.supportedInterfaceOrientations
    }
    
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let orientation = self.topViewController?.preferredInterfaceOrientationForPresentation {
            return orientation
        }
        return super.preferredInterfaceOrientationForPresentation
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: styles
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = self.topViewController?.preferredStatusBarStyle {
            return style
        }
        return super.preferredStatusBarStyle
    }
    #endif
    
}
