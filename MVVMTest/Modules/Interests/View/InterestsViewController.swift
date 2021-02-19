//
// Created by Leonid Nifantyev on 10/5/19.
//

import UIKit

class InterestsViewController: UIViewController {
    
    let rootView: InterestsView
    var viewModel: (InterestsViewModelInterface & InterestsDataSource)
    
    convenience init(viewModel: (InterestsViewModelInterface & InterestsDataSource)) {
        self.init(viewModel: viewModel, nibName: .none, bundle: .none)
    }
    
    init(viewModel: (InterestsViewModelInterface & InterestsDataSource), nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.viewModel = viewModel
        
        rootView = InterestsView(viewModel: viewModel)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel.fetch()
    }
    
    private func setupBinding() {
        viewModel.eventHandler = { [unowned self] event in
            switch event {
            case .changed: rootView.collectionHelper.reload()
            case .error: showError()
            default: break
            }
        }
    }
    
    func showError() {
        self.alert(message: "Something went wrong", okAction: { [weak self] in
            self?.viewModel.back()
        })
    }
}
