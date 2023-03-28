//
//  PagesViewController.swift
//  
//
//  Created by Artur Sardaryan on 29.03.2023.
//

import UIKit

public final class PagesViewController: UIViewController {
    private let pageViewController: UIPageViewController
    private let viewControllers: [UIViewController]
    
    private let segmentsView: SegmentsView
    private let segmentsHeight: CGFloat

    public init(data: PagesData) {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        viewControllers = data.pages.map { $0.viewController }
        
        segmentsView = SegmentsView(data: .init(titles: data.pages.map { $0.title },
                                                style: data.segmentsStyle))
        segmentsHeight = data.segmentsStyle.height
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        segmentsView.delegate = self
        segmentsView.backgroundColor = .yellow
        view.addSubview(segmentsView)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentsView.frame = .init(x: 0,
                                   y: view.safeAreaInsets.top,
                                   width: view.bounds.width,
                                   height: segmentsHeight)
        
        pageViewController.view.frame = .init(x: 0,
                                              y: segmentsHeight + view.safeAreaInsets.top,
                                              width: view.bounds.width,
                                              height: view.bounds.height - segmentsHeight - view.safeAreaInsets.top)
    }
}

extension PagesViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }

        return viewControllers[currentIndex - 1]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController), currentIndex < viewControllers.count - 1 else {
            return nil
        }

        return viewControllers[currentIndex + 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            completed,
            let viewController = pageViewController.viewControllers?.first,
            let currentIndex = viewControllers.firstIndex(of: viewController) else {
            return
        }

        segmentsView.selectedIndex = currentIndex
    }
}

extension PagesViewController: SegmentsViewDelegate {
    public func didSelectSegment(at index: Int) {
        guard
            let viewController = pageViewController.viewControllers?.first,
            let currentIndex = viewControllers.firstIndex(of: viewController),
            currentIndex != index else {
            return
        }
        
        pageViewController.setViewControllers([viewControllers[index]],
                                              direction: index > currentIndex ? .forward : .reverse,
                                              animated: true)
        segmentsView.selectedIndex = index
    }
}
