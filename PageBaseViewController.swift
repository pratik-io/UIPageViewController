//
//  PageBaseViewController.swift
//  DemoSlider
//
//  Created by Dark Army on 22/08/19.
//  Copyright © 2019 Dark Army. All rights reserved.
//

import UIKit

class PageBaseViewController: BaseViewController {

    
    @IBOutlet weak var pageControl : UIPageControl!
    var pageViewController: UIPageViewController!
    var arrVCs = [UIViewController]()
    var currentIndex = 0
    //var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:UIScreen.main.bounds.width/2 - 100, y:UIScreen.main.bounds.height-50, width: 200, height: 20))
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        
        hideNavigationBar()
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        
        //set ViewControllers
        
        for index in 1...3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PageItemViewController\(index)") as! PageItemViewController
            vc.indexMy = index-1
            vc.view.frame = UIScreen.main.bounds
            arrVCs.append(vc)
        }
        self.pageViewController.setViewControllers([arrVCs[0]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        pageViewController.view.frame = UIScreen.main.bounds
        self.addChild(pageViewController)
        view.addSubview(pageViewController!.view)
        self.pageViewController.didMove(toParent: self)
        
        configurePageControl()
    }
    
    
    func configurePageControl() {
        self.pageControl.numberOfPages = arrVCs.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.06705289334, green: 0.7171089649, blue: 0.6512789726, alpha: 1)
        self.view.bringSubviewToFront(self.pageControl)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController?
    {
        if self.arrVCs.count == 0 || index >= self.arrVCs.count
        {
            return nil
        }
        
        currentIndex = index
        
        return arrVCs[index]
    }
    
    
    
}

extension PageBaseViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
 
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageItemViewController).indexMy
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.arrVCs.count) {
            return nil
        }
        
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageItemViewController).indexMy
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return self.arrVCs.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentVC = pageViewController.viewControllers![0] as! PageItemViewController
        self.pageControl.currentPage = currentVC.indexMy
    }
}
