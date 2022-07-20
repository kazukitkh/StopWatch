//
//  ViewController.swift
//  StopWatch
//
//  Created by 武樋一樹 on 2022/07/20.
//

import UIKit

class stopWatchViewController: UIViewController {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var rapButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var rapTableView: UITableView!
    
    var timer: Timer?
    var raps: [String] = []
    var timeString: String = "00.00.00" {
        didSet {
            timerLabel.text = timeString
        }
    }
    var time: Float = 0.0 {
        didSet {
            let min = Int(self.time / 60)
            let sec = Int(self.time) % 60
            let mili = Int(self.time * 100) % 100
            
            self.timeString = String(format: "%d:%02d:%02d", min, sec, mili)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.time = 0.0
        startButton.setTitle("Start", for: .normal)
        resetButton.setTitle("Reset", for: .normal)
        rapButton.setTitle("Rap", for: .normal)
        stopButton.setTitle("Stop", for: .normal)
        rapTableView.register(UINib(nibName: "rapTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        rapTableView.delegate = self
        rapTableView.dataSource = self
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if (timer == nil || !(timer?.isValid ?? false)) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
                (timer) in
                self.time += 0.01
            }
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        if let t = timer {
            t.invalidate()
            timer = nil
            self.time = 0.0
            startButton.setTitle("Start", for: .normal)
            raps.removeAll()
            self.rapTableView.reloadData()
        }
    }
    
    @IBAction func rapButtonPressed(_ sender: Any) {
        if let t = timer, t.isValid {
            self.raps.append(timeString)
            self.rapTableView.reloadData()
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        if let t = timer, t.isValid {
            timer?.invalidate()
            startButton.setTitle("Restart", for: .normal)
        }
    }
}

extension stopWatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(raps.count)
        
        return raps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rapTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! rapTableViewCell
        cell.label.text = raps[indexPath.row]
        print(raps[indexPath.row])
        
        return cell
    }
}
