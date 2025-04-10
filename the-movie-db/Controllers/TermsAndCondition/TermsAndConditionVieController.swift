//
//  TermsAndConditionVieController.swift
//  the-movie-db
//
//  Created by Zan on 4/10/25.
//

import UIKit

class TermsAndConditionVieController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textView: UITextView!

    private var passedTitle: String = ""
    private var passedDescription: String = ""

    init(with title: String, with desc: String) {
        super.init(nibName: "TermsAndConditionVieController", bundle: nil)
        self.passedTitle = title
        self.passedDescription = desc
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        lblTitle.text = passedTitle
        textView.text = passedDescription
    }
}

