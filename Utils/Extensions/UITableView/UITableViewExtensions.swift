//
//  UITableView+Extensions.swift
//  Tele2
//
//  Created by l.nifantyev on 9/5/18.
//  Copyright © 2018 Tele2. All rights reserved.
//

import Foundation
import UIKit

public protocol ReusableView {}

public protocol NibLoadableView {}

public typealias NibLoadableReusable = ReusableView & NibLoadableView

//MARK: - UITableViewCell: ReusableView & NibLoadableView
public extension ReusableView where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension ReusableView where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension NibLoadableView where Self: UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
}

public extension NibLoadableView where Self: UITableViewHeaderFooterView {
    static var nibName: String {
        return String(describing: self)
    }
}

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadableReusable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func ln_dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func ln_dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        guard let headerView = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter with identifier: \(T.reuseIdentifier)")
        }
        return headerView
    }
}


public extension UITableView {
    func selfSizingCells() {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 50//UITableView.automaticDimension
    }

    func selfSizingHeaders() {
        self.sectionHeaderHeight = UITableView.automaticDimension
        self.estimatedSectionHeaderHeight = 50//UITableView.automaticDimension
    }
    func selfSizingFooters() {
        self.sectionFooterHeight = UITableView.automaticDimension
        self.estimatedSectionFooterHeight = 50//UITableView.automaticDimension
    }
}