//
//  ViewController.swift
//  Exercices
//
//  Created by Aymen Letaief on 09.12.21.
//

import UIKit
import ExercisesCore

class ExercicesListViewController: UITableViewController {

    var datasource: [Exercise] = []
    let urlString = "https://jsonblob.com/api/jsonBlob/027787de-c76e-11eb-ae0a-39a1b8479ec2"
    
    var exercisesViewModel: ExercisesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        exercisesViewModel!.loadAllExercices()
    }
    
    func configureViewModel() {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        
        let httpClient = URLSessionHTTPClient(session: session)
        
        let loader = RemoteExercisesLoader(url:URL(string: urlString)!,httpClient:httpClient)
        
        exercisesViewModel = ExercisesViewModel(remoteLoader: loader)
        exercisesViewModel?.delegate = self
        
    }

}


extension ExercicesListViewController  {
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciceCell", for: indexPath) as! ExerciseCell
        let exercise = datasource[indexPath.row]
        
        cell.setup(exercise: exercise)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
}


extension ExercicesListViewController: ExercisesListDelegate {
    
    func showExercises(exercises: [Exercise]) {
        self.datasource = exercises
        self.tableView.reloadData()
    }
    
    
}
