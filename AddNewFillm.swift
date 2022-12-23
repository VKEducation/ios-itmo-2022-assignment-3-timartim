//
//  CreateNewFillm.swift
//  ios-itmo-2022-assignment2
//
//  Created by Артемий on 26.10.2022.
//

import UIKit
class AddNewFilm: UIViewController {
    var textIsValid = false
    private var titleValidation = false
    private var directorValidation = false
    private var yearValidation = false
    public var filmsName = ""
    public var DirectorName = ""
    public var TotalStars = 0
    public var date = ""
    private lazy var titleElement = LabelAndText()
    private lazy var directorElement = LabelAndText()
    private lazy var yearElement = LabelAndText()
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.backgroundColor = UIColor.white
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    private lazy var starButton1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor1), for: .touchUpInside)
        return button
    }()
    private lazy var starButton2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor2), for: .touchUpInside)
        return button
    }()
    private lazy var starButton3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor3), for: .touchUpInside)
        return button
    }()
    private lazy var starButton4: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor4), for: .touchUpInside)
        return button
    }()
    private lazy var starButton5: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor5), for: .touchUpInside)
        return button
    }()
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фильм"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center

        return label
    }()
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ваша оценка"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        let done = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(tapDone))
        let cancel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(tapCancel))
        toolBar.setItems([done, cancel], animated: true)
        return toolBar
    }()

    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 24
        button.backgroundColor = UIColor.rgb(red: 93, green: 176, blue: 117).withAlphaComponent(0.4)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Добавление нового фильма"
        navigationItem.backButtonTitle = "Назад"
        view.backgroundColor = .white
        view.addSubview(mainView)
        titleElement.configureView(labelTitle: "Название", textPlaceholder: "Введите название")
        directorElement.configureView(labelTitle: "Режиссер", textPlaceholder: "Название фильма")
        yearElement.configureView(labelTitle: "Год", textPlaceholder: "Год выпуска")
        titleElement.nameText.addTarget(self, action: #selector(titleIsValid), for: .editingChanged)
        directorElement.nameText.addTarget(self, action: #selector(directorIsValid), for: .editingChanged)
        titleElement.nameText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        directorElement.nameText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        yearElement.nameText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        yearElement.nameText.inputView = datePicker
        yearElement.nameText.inputAccessoryView = toolBar
        yearElement.nameText.becomeFirstResponder() 
        titleElement.nameText.becomeFirstResponder()
        directorElement.nameText.becomeFirstResponder()
        mainView.addSubview(mainLabel)
        mainView.addSubview(titleElement)
        mainView.addSubview(directorElement)
        mainView.addSubview(yearElement)
        mainView.addSubview(starButton1)
        mainView.addSubview(starButton2)
        mainView.addSubview(starButton3)
        mainView.addSubview(starButton4)
        mainView.addSubview(starButton5)
        mainView.addSubview(scoreLabel)
        mainView.addSubview(saveButton)

        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),

            //mainLabel (Фильмы)
            mainLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 36),

            //title Element
            titleElement.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            titleElement.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            titleElement.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            titleElement.heightAnchor.constraint(equalToConstant: 73),


            //Director Element
            directorElement.topAnchor.constraint(equalTo: titleElement.bottomAnchor, constant: 16),
            directorElement.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            directorElement.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            directorElement.heightAnchor.constraint(equalToConstant: 73),

            //Year element
            yearElement.topAnchor.constraint(equalTo: directorElement.bottomAnchor, constant: 16),
            yearElement.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            yearElement.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            yearElement.heightAnchor.constraint(equalToConstant: 73),


            //datePicker



            //Star button 1
            starButton1.topAnchor.constraint(equalTo: yearElement.bottomAnchor, constant: 48),
            starButton1.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),
            starButton1.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -234),
            starButton1.heightAnchor.constraint(equalToConstant: 43),

            //Star, button 2
            starButton2.topAnchor.constraint(equalTo: yearElement.bottomAnchor, constant: 48),
            starButton2.leadingAnchor.constraint(equalTo: starButton1.trailingAnchor, constant: -20),
            starButton2.heightAnchor.constraint(equalToConstant: 43),

            // StarButton 3
            starButton3.topAnchor.constraint(equalTo: yearElement.bottomAnchor, constant: 48),
            starButton3.leadingAnchor.constraint(equalTo: starButton2.trailingAnchor, constant: 10),
            starButton3.heightAnchor.constraint(equalToConstant: 43),

            //StarButton4
            starButton4.topAnchor.constraint(equalTo: yearElement.bottomAnchor, constant: 48),
            starButton4.leadingAnchor.constraint(equalTo: starButton3.trailingAnchor, constant: 10),
            starButton4.heightAnchor.constraint(equalToConstant: 43),

            //StarButton5
            starButton5.topAnchor.constraint(equalTo: yearElement.bottomAnchor, constant: 48),
            starButton5.leadingAnchor.constraint(equalTo: starButton4.trailingAnchor, constant: 10),
            starButton5.heightAnchor.constraint(equalToConstant: 43),

            //scoreLabel
            scoreLabel.topAnchor.constraint(equalTo: starButton3.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            scoreLabel.heightAnchor.constraint(equalToConstant: 20),

            //saveButton
            saveButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            saveButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
            ])

    }
    @objc
    private func changeCollor1() {
        TotalStars = 1
        scoreLabel.text = "Ужасно"
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton1.setImage(tintedImage, for: .normal)
        starButton1.tintColor = .yellow
        resetColorBack1()
    }

    @objc
    private func changeCollor2() {
        changeCollor1()
        TotalStars = 2
        scoreLabel.text = "Плохо"
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton2.setImage(tintedImage, for: .normal)
        starButton2.tintColor = .yellow
        resetColorBack2()
    }
    @objc
    private func changeCollor3() {
        changeCollor2()
        TotalStars = 3
        scoreLabel.text = "Нормально"
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton3.setImage(tintedImage, for: .normal)
        starButton3.tintColor = .yellow
        resetColorBack3()
    }
    @objc
    private func changeCollor4() {
        changeCollor3()
        TotalStars = 4
        scoreLabel.text = "Хорошо"
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton4.setImage(tintedImage, for: .normal)
        starButton4.tintColor = .yellow
        resetColorBack4()
    }
    @objc
    private func changeCollor5() {
        changeCollor4()
        TotalStars = 5
        scoreLabel.text = "Amazing!"
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton5.setImage(tintedImage, for: .normal)
        starButton5.tintColor = .yellow
    }
    @objc
    private func resetColorBack4() {
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton5.setImage(image, for: .normal)
    }
    @objc
    private func resetColorBack3() {
        resetColorBack4()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton4.setImage(image, for: .normal)
    }
    @objc
    private func resetColorBack2() {
        resetColorBack3()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton3.setImage(image, for: .normal)
    }
    @objc
    private func resetColorBack1() {
        resetColorBack2()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton2.setImage(image, for: .normal)
    }
    @objc func titleIsValid() {
        let textField = titleElement.nameText
        if(textField.text?.count ?? -1 >= 1) && (textField.text?.count ?? -1 <= 300) {
            titleValidation = true
            titleElement.nameLabel.textColor = .black
            titleElement.nameText.layer.borderWidth = 1.0
            titleElement.nameText.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            titleElement.nameLabel.textColor = .red
            titleElement.nameText.layer.borderWidth = 1.0
            titleElement.nameText.layer.borderColor = UIColor.red.cgColor

            titleValidation = false
        }
    }
    @objc func directorIsValid() {
        
        let textField = directorElement.nameText
        var checkLetters = false
        var firstLetter = false
        
        let text :String = textField.text ?? ""
        if text.count == 0 {
            directorValidation = false
            directorElement.nameLabel.textColor = .red
            directorElement.nameText.layer.borderWidth = 1.0
            directorElement.nameText.layer.borderColor = UIColor.red.cgColor
        } else {
           
            let names = text.components(separatedBy: " ")
            for str in names{
                if str.count > 0{
                    firstLetter = str[0].isUppercase
                }
                for element in str {
                    if((element == " ") || (element.isLetter)) {
                        checkLetters = true
                    } else {
                        checkLetters = false
                    }
                }
                if(!(checkLetters && firstLetter)){
                    break
                }
            }
            
            checkLetters = checkLetters && firstLetter
            directorElement.nameText.layer.borderWidth = 1.0
            if(textField.text?.count ?? -1 >= 3) && (textField.text?.count ?? -1 <= 300) && checkLetters {
                directorValidation = true
                directorElement.nameLabel.textColor = .black
                directorElement.nameText.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                directorValidation = false
                directorElement.nameLabel.textColor = .red
                directorElement.nameText.layer.borderWidth = 1.0
                directorElement.nameText.layer.borderColor = UIColor.red.cgColor
                
            }
        }

    }

    @objc
    private func editingChanged() {
        
        if(titleValidation && yearValidation && directorValidation) {
            
            saveButton.isEnabled = true
            filmsName = titleElement.nameText.text ?? ""
            DirectorName = directorElement.nameText.text ?? ""
            saveButton.backgroundColor = UIColor.rgb(red: 93, green: 176, blue: 117)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = UIColor.rgb(red: 93, green: 176, blue: 117).withAlphaComponent(0.4)
        }
    }

    @objc
    func datePickerValueChanged(_ sender: UIDatePicker) {

        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()

        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"

        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)

        print("Selected value \(selectedDate)")
    }
    @objc
    private func tapDone() {
        yearElement.nameText.resignFirstResponder()

        guard let datePicker = yearElement.nameText.inputView as? UIDatePicker else {
            return
        }

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd.MM.YYYY"

        yearElement.nameText.text = dateFormatter.string(from: datePicker.date)
        date = yearElement.nameText.text ?? ""
        yearValidation = true
        editingChanged()
        yearElement.nameLabel.textColor = .black
        yearElement.nameText.layer.borderWidth = 1.0
        yearElement.nameText.layer.borderColor = UIColor.systemGreen.cgColor

    }
    @objc
    private func tapCancel() {
        yearElement.nameText.resignFirstResponder()
    }

}


