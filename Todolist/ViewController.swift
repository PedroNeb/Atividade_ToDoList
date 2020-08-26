//
//  ViewController.swift
//  Todolist
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var listaDeTarefas: [String] = []
    let keyLista = "listaDeTarefas"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource=self
        
        if let lista = UserDefaults.standard.value(forKey: keyLista) as? [String]{
            listaDeTarefas.append(contentsOf: lista)
        }
    }

    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa", message: "Adicione uma Nova Tarefa", preferredStyle: .alert)
        
        let acaoSalvar = UIAlertAction(title: "Salvar", style: .default){(action) in
            if let textField = alert.textFields?.first, let texto = textField.text{
                self.listaDeTarefas.append(texto)
                self.tableview.reloadData()
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.keyLista)
            }
        }
        
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel){(action) in
            print("clicou em Cancelar")
        }
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancelar)
        
        alert.addTextField()

        present(alert,animated:true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            listaDeTarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.listaDeTarefas, forKey: self.keyLista)
        }
        }
    }
    
