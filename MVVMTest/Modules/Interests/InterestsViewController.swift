//
// Created by Leonid Nifantyev on 10/5/19.
//

import UIKit

class InterestsViewController: UIViewController {
    
    var rootView: InterestsView?
    
    let viewModel: (InterestsViewModelInterface & InterestsDataSource)
    
    convenience init(viewModel: (InterestsViewModelInterface & InterestsDataSource)) {
        self.init(viewModel: viewModel, nibName: .none, bundle: .none)
    }
    
    init(viewModel: (InterestsViewModelInterface & InterestsDataSource), nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        rootView = InterestsView(viewModel: viewModel)
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetch()
    }
    
    func showError() {
        self.alert(message: "Something went wrong", okAction: { [weak self] in
            self?.viewModel.back()
        })
    }
}
