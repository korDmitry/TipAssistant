//
//  QuestionsViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    
    //MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionScrollView.delegate = self
        questionPageControl.numberOfPages = questions.questionsArray.count
        setNavigationBar()
        setDefaultBorders()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpQuestionScrollView(createQuestionViews())
    }
    
    
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
        case goodButton:
            questions.questionsArray[questions.currentQuestion].mark = .good
        case neutralButton:
            questions.questionsArray[questions.currentQuestion].mark = .neutral
        case badButton:
            questions.questionsArray[questions.currentQuestion].mark = .bad
        default:
            break
        }
        
        if questions.currentQuestion < questions.questionsArray.count - 1 {
            let i = questions.currentQuestion + 1
            let rec = CGRect(x: questionScrollView.frame.width * CGFloat(i), y: 0, width:  questionScrollView.frame.width, height:  questionScrollView.frame.height)
            questionScrollView.scrollRectToVisible(rec, animated: true)
        }
        else {
            self.performSegue(withIdentifier: "ResultSegue", sender: self)
            sender.layer.borderWidth = borderMaxWidth
        }
    }
    
    
    //MARK: Properties
    
    fileprivate var questions = Questions()
    
    fileprivate let borderMaxWidth = CGFloat(2)
    fileprivate let borderMinWidth = CGFloat(0.5)
    private var cornerRadius: CGFloat {
        switch view.frame.width {
        case 320:
            return CGFloat(28)
        case 375:
            return CGFloat(38)
        case 414:
            return CGFloat(43)
        default:
            return CGFloat(36)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Functions
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    fileprivate func setDefaultBorders() {
        exellentButton.layer.cornerRadius = cornerRadius
        exellentButton.layer.borderColor = UIColor.white.cgColor
        exellentButton.layer.borderWidth = borderMinWidth
        exellentButton.clipsToBounds = true
        
        goodButton.layer.cornerRadius = cornerRadius
        goodButton.layer.borderColor = UIColor.white.cgColor
        goodButton.layer.borderWidth = borderMinWidth
        goodButton.clipsToBounds = true
        
        neutralButton.layer.cornerRadius = cornerRadius
        neutralButton.layer.borderColor = UIColor.white.cgColor
        neutralButton.layer.borderWidth = borderMinWidth
        neutralButton.clipsToBounds = true
        
        badButton.layer.cornerRadius = cornerRadius
        badButton.layer.borderColor = UIColor.white.cgColor
        badButton.layer.borderWidth = borderMinWidth
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            if let resultVC = (segue.destination as? ResultViewController) {
                resultVC.questions = self.questions
            }
        }
    }
}


//MARK: Extensions

extension QuestionsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        showMark(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showMark(scrollView)
    }
    
    private func showMark(_ scrollView: UIScrollView) {
        questionPageControl.currentPage = Int(round(questionScrollView.contentOffset.x/questionScrollView.frame.width))
        questions.currentQuestion = questionPageControl.currentPage
        
        setDefaultBorders()
        let mark = questions.questionsArray[questions.currentQuestion].mark
        
        switch mark {
        case .exellent:
            exellentButton.layer.borderWidth = borderMaxWidth
        case .good:
            goodButton.layer.borderWidth = borderMaxWidth
        case .neutral:
            neutralButton.layer.borderWidth = borderMaxWidth
        case .bad:
            badButton.layer.borderWidth = borderMaxWidth
        case .none:
            break
        }
    }
}

