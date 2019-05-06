//
//  Created by Dmitriy Stupivtsev on 05/05/2019.
//

import UIKit

typealias PagesViewControllerType = BaseViewController<PagesView>
    & UIPageViewControllerDataSource
    & UIPageViewControllerDelegate

final class PagesViewController: PagesViewControllerType {
    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private let controllers: [UIViewController]
    private var currentIndex = 0
    
    init(controllers: [UIViewController]) {
        self.controllers = controllers
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        customView.addPagesView(pageViewController.view)
        
        updatePagesCount()
        customView.setCurrentPageIndex(currentIndex)
        
        let startControllers = controllers.first.map(Array<UIViewController>.init) ?? []
        pageViewController.setViewControllers(startControllers, direction: .forward, animated: true)
    }
    
    private func updatePagesCount() {
        let count = controllers.count
        let delegate = count > 1 ? self : nil
        
        // without delegate pages don't scroll,
        // so we remove it when pages count less than 2
        pageViewController.delegate = delegate
        pageViewController.dataSource = delegate
        
        customView.setPagesCount(count)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        guard let index = pendingViewControllers.first.flatMap({ controllers.firstIndex(of: $0) }) else { return }
        
        currentIndex = index
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed else { return }
        
        customView.setCurrentPageIndex(currentIndex)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        return controllers.firstIndex(of: viewController).flatMap { index in
            guard index > 0 else { return nil }
            return controllers[index - 1]
        }
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        return controllers.firstIndex(of: viewController).flatMap { index in
            guard index < controllers.count - 1 else { return nil }
            return controllers[index + 1]
        }
    }
}
