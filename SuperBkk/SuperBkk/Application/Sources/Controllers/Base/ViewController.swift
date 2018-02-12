//
//  ViewController.swift
//  SuperBkk
//
//  Created by Tamás Czigány on 2018. 02. 12..
//  Copyright © 2018. Tamás Czigány. All rights reserved.
//

import Foundation
import UIKit

public class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
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
    
    public func initialize() {
        
    }
    
    deinit {
        //dlog(object: "deinit: \(self)")
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: ViewController
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        self.view.backgroundColor   = UIColor.white
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: actions
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //dlog(object: "'\(type(of: self))' class is not key value coding-compliant for the key '\(key)' - '\(value)'")
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: autorotation
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    #if os(iOS)
    public override var shouldAutorotate: Bool {
        return false
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: styles
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    #endif
}
