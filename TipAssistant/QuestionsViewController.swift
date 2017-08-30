//
//  QuestionsViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    
    //MARK: VC lifecycle
    
    override func viewDidLoad() {
        questionScrollView.delegate = self
        questionPageControl.numberOfPages = questions.questionsArray.count
        setUpQuestionScrollView(createQuestionViews())
        setNavigationBar()
        setDefaultBorders()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: Properties
    
    var questions = Questions()
    
    
    //MARK: @IBOutlets
    
    @IBOutlet weak var exellentButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    
    @IBOutlet weak var questionScrollView: UIScrollView!
    @IBOutlet weak var questionPageControl: UIPageControl!
    
    
    //MARK: @IBActions
    
    @IBAction func setMark(_ sender: UIButton) {
        setDefaultBorders()
        switch sender {
        case exellentButton:
            questions.questionsArray[questions.currentQuestion].mark = .exellent
            exellentButton.layer.borderWidth = 2
        case goodButton:
            questions.questionsArray[questions.currentQuestion].mark = .good
            goodButton.layer.borderWidth = 2
        case neutralButton:
            questions.questionsArray[questions.currentQuestion].mark = .neutral
            neutralButton.layer.borderWidth = 2
        case badButton:
            questions.questionsArray[questions.currentQuestion].mark = .bad
            badButton.layer.borderWidth = 2
        default:
            break
        }
    }
    
    //MARK: Private functions
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    fileprivate func setDefaultBorders() {
        exellentButton.layer.cornerRadius = 40
        exellentButton.layer.borderColor = UIColor.white.cgColor
        exellentButton.layer.borderWidth = 0.5
        exellentButton.clipsToBounds = true
        
        goodButton.layer.cornerRadius = 40
        goodButton.layer.borderColor = UIColor.white.cgColor
        goodButton.layer.borderWidth = 0.5
        goodButton.clipsToBounds = true
        
        neutralButton.layer.cornerRadius = 40
        neutralButton.layer.borderColor = UIColor.white.cgColor
        neutralButton.layer.borderWidth = 0.5
        neutralButton.clipsToBounds = true
        
        badButton.layer.cornerRadius = 40
        badButton.layer.borderColor = UIColor.white.cgColor
        badButton.layer.borderWidth = 0.5
        badButton.clipsToBounds = true
    }
    
    private func createQuestionViews() -> [QuestionView] {
        var arrayOfQuestionViews: [QuestionView] = []
        for question in questions.questionsArray {
            let questionView: QuestionView = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)?.first as! QuestionView
            questionView.questionLabel.text = question.text
            arrayOfQuestionViews.append(questionView)
        }
        return arrayOfQuestionViews
    }
    
    private func setUpQuestionScrollView(_ questionViews:[QuestionView]) {
        questionScrollView.contentSize = CGSize(width: questionScrollView.frame.width * CGFloat(questions.questionsArray.count), height: questionScrollView.frame.height)
        
        for i in 0 ..< questions.questionsArray.count {
            questionViews[i].frame = CGRect(x: questionScrollView.frame.width * CGFloat(i), y: 0, width:  questionScrollView.frame.width, height:  questionScrollView.frame.height)
            questionScrollView.addSubview(questionViews[i])
        }
    }
}


//MARK: Extensions

extension QuestionsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        questionPageControl.currentPage = Int(round(questionScrollView.contentOffset.x/questionScrollView.frame.width))
        questions.currentQuestion = questionPageControl.currentPage
        
        setDefaultBorders()
        let mark = questions.questionsArray[questions.currentQuestion].mark
        
        switch mark {
        case .exellent:
            exellentButton.layer.borderWidth = 2
        case .good:
            goodButton.layer.borderWidth = 2
        case .neutral:
            neutralButton.layer.borderWidth = 2
        case .bad:
            badButton.layer.borderWidth = 2
        case .none:
            break
        }
    }
}

