//
//  ViewController.swift
//  ios-itmo-2022-assignment2
//
//  Created by rv.aleksandrov on 29.09.2022.
//

import UIKit
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
class Pair {
    public var first = ""
    public var second = ""
    init(first: String = "", second: String = "") {
        self.first = first
        self.second = second

    }
}
class ViewController: UITableViewController {
    private var marks: [Array<Int>] = []
    private let cellID = "CELL_ID"
    private var dates: Array<Array<Pair>> = []
    private var listDates = [String]()
    private var hashDates = Set<String>()
    private let addController = AddNewFilm()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Мои Фильмы"
        navigationItem.titleView?.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyCell.self, forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(loadAddScreen))
        tableView.translatesAutoresizingMaskIntoConstraints = false
     
        
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listDates[section]
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [self] (action, sourceView, completionHandler) in
            self.dates[indexPath.section].remove(at: indexPath.row)
            marks[indexPath.section].remove(at: indexPath.row)
            completionHandler(true)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if(dates[indexPath.section].count == 0) {
                dates.remove(at: indexPath.section)
                marks.remove(at: indexPath.section)
                hashDates.remove(listDates[indexPath.section])
                listDates.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
            tableView.reloadData()
        }

        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates[section].count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyCell()

        cell.configureNamesAndMark(mark: marks[indexPath.section][indexPath.row], film: dates[indexPath.section][indexPath.row].first, director: dates[indexPath.section][indexPath.row].second)
        return cell
    }

    @objc
    private func loadAddScreen() {
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
        addController.saveButton.addTarget(self, action: #selector(addNewFilmAction), for: .touchUpInside)
        navigationController?.pushViewController(addController, animated: true)
    }
    @objc
    public func addNewFilmAction() {
        let pair = Pair(first: addController.filmsName, second: addController.DirectorName)
        var pos = 0
        let arr = hashDates.contains(addController.date)
        
        if(!arr) {
            listDates.append(addController.date)
            hashDates.insert(addController.date)
            marks.append(Array<Int>())
            marks[marks.count - 1].append(addController.TotalStars)
            dates.append(Array<Pair>())
            self.tableView.performBatchUpdates({
                self.tableView.insertSections(IndexSet(integer: dates.count - 1), with: .automatic)
                
            }, completion: nil)
            pos = dates.count - 1
            dates[dates.count - 1].append(pair)
        } else {
            
            for _ in listDates{
                if(addController.date == listDates[pos]){
                    break
                }else{
                    pos += 1
                }
            }
            dates[pos].append(pair)
            marks[pos].append(addController.TotalStars)
        }
        
        self.tableView.performBatchUpdates({
            self.tableView.insertRows(at: [IndexPath(row: dates[pos].count - 1, section: pos)],
                with: .automatic)
        }, completion: nil)
        self.tableView.endUpdates()
        navigationController?.popViewController(animated: true)
    }
}

class MyCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellView()
    }

    public func configureNamesAndMark(mark: Int, film: String, director: String) {
        numOfStars = mark
        nameLabel.text = film
        directorLabel.text = director
        switch(numOfStars) {
        case 1: changeCollor1()
        case 2: changeCollor2()
        case 3: changeCollor3()
        case 4: changeCollor4()
        case 5: changeCollor5()
        case 0: break
        default: fatalError("invalid mark occured")
        }
    }
    public var numOfStars = 0
    private let moveConstant = CGFloat(0)
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    public lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Режиссер"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    public lazy var starButton1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor1), for: .touchUpInside)
        return button
    }()
    public lazy var starButton2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor2), for: .touchUpInside)
        return button
    }()
    public lazy var starButton3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor3), for: .touchUpInside)
        return button
    }()
    public lazy var starButton4: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor4), for: .touchUpInside)
        return button
    }()
    public lazy var starButton5: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(changeCollor5), for: .touchUpInside)

        return button
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setCellView() {
        self.addSubview(nameLabel)
        self.addSubview(directorLabel)
        self.addSubview(starButton1)
        self.addSubview(starButton2)
        self.addSubview(starButton3)
        self.addSubview(starButton4)
        self.addSubview(starButton5)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            directorLabel.rightAnchor.constraint(equalTo: rightAnchor),
            directorLabel.topAnchor.constraint(equalTo: topAnchor),
            directorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),


            starButton1.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: moveConstant),
            starButton1.trailingAnchor.constraint(equalTo: starButton2.leadingAnchor, constant: -moveConstant),
            starButton1.topAnchor.constraint(equalTo: self.topAnchor),
            starButton1.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            starButton2.leadingAnchor.constraint(equalTo: starButton1.trailingAnchor, constant: moveConstant),
            starButton2.trailingAnchor.constraint(equalTo: starButton3.leadingAnchor, constant: -moveConstant),
            starButton2.topAnchor.constraint(equalTo: self.topAnchor),
            starButton2.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            starButton3.leadingAnchor.constraint(equalTo: starButton2.trailingAnchor, constant: moveConstant),
            starButton3.trailingAnchor.constraint(equalTo: starButton4.leadingAnchor, constant: -moveConstant),
            starButton3.topAnchor.constraint(equalTo: self.topAnchor),
            starButton3.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            starButton4.leadingAnchor.constraint(equalTo: starButton3.trailingAnchor, constant: moveConstant),
            starButton4.trailingAnchor.constraint(equalTo: starButton5.leadingAnchor, constant: -moveConstant),
            starButton4.topAnchor.constraint(equalTo: self.topAnchor),
            starButton4.bottomAnchor.constraint(equalTo: self.bottomAnchor),


            starButton5.leadingAnchor.constraint(equalTo: starButton4.trailingAnchor, constant: moveConstant),
            starButton5.trailingAnchor.constraint(equalTo: directorLabel.leadingAnchor, constant: -moveConstant),
            starButton5.topAnchor.constraint(equalTo: self.topAnchor),
            starButton5.bottomAnchor.constraint(equalTo: self.bottomAnchor),


            ])
    }


    @objc
    public func changeCollor1() {
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton1.setImage(tintedImage, for: .normal)
        starButton1.tintColor = .yellow
        resetColorBack1()
    }

    @objc
    public func changeCollor2() {
        changeCollor1()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton2.setImage(tintedImage, for: .normal)
        starButton2.tintColor = .yellow
        resetColorBack2()
    }
    @objc
    public func changeCollor3() {
        changeCollor2()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton3.setImage(tintedImage, for: .normal)
        starButton3.tintColor = .yellow
        resetColorBack3()
    }
    @objc
    public func changeCollor4() {
        changeCollor3()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton4.setImage(tintedImage, for: .normal)
        starButton4.tintColor = .yellow
        resetColorBack4()
    }
    @objc
    public func changeCollor5() {
        changeCollor4()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        starButton5.setImage(tintedImage, for: .normal)
        starButton5.tintColor = .yellow
    }
    @objc
    public func resetColorBack4() {
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton5.setImage(image, for: .normal)
    }
    @objc
    public func resetColorBack3() {
        resetColorBack4()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton4.setImage(image, for: .normal)
    }
    @objc
    public func resetColorBack2() {
        resetColorBack3()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton3.setImage(image, for: .normal)
    }
    @objc
    public func resetColorBack1() {
        resetColorBack2()
        let imageName = "Star-2.png"
        let image = UIImage(named: imageName)
        starButton2.setImage(image, for: .normal)
    }


}

