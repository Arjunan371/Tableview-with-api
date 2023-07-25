

import UIKit
import Kingfisher


struct Newsapi: Codable{
   var status: String?
   var totalResults: Int?
    var articles: [ArticleContent]?
}

struct ArticleContent: Codable{
    var source:Details?
    var author: String?
    var title: String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
}
struct Details: Codable{
    var id: String?
    var name:String?
}
class ViewController: UIViewController {
  
    var json:Newsapi?
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getmethod()

    }
    func getmethod(){

               let urlString = "https://newsapi.org/v2/top-headlines?country=in&apiKey=55818053ca304dd389c7d3fe367a5d58"

               let url = URL(string: urlString)

               var request = URLRequest(url: url!)
           
               request.httpMethod = "GET"

               URLSession.shared.dataTask(with: request) { data, response , error in

                   guard error == nil else {

                       return}

                   guard let SData = data else{print("Error:Did not receive data")

                       return}

                   guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else{

                       print("Error: HTTTP REQUEST FAILED")

                       return

                   }
                   print(response)

                   do {

                       let responsedata = try JSONDecoder().decode(Newsapi.self, from: SData)

                       self.json = responsedata
                    print(responsedata)

                       DispatchQueue.main.async{
                  self.table.reloadData()

                       }

                   }

                   catch{

                       print(error)

                   }

               }.resume()

               print("continue")

       }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "one", for: indexPath) as! firstTableViewCell
        cell.label1.text = json?.articles?[indexPath.row].source?.name ?? ""
        cell.label2.text = json?.articles?[indexPath.row].title ?? ""
        cell.Date.text = json?.articles?[indexPath.row].publishedAt ?? ""
        cell.label3.text = json?.articles?[indexPath.row].author ?? ""
        cell.lbel4.text = String(json?.totalResults ?? 0)
        cell.image1.layer.cornerRadius = cell.image1.frame.size.width/2
        
            let url = URL(string: json?.articles?[indexPath.row].urlToImage ?? "")
        cell.image1.kf.setImage(with: url,placeholder: UIImage(systemName: "person.circle.fill"))
            
        
        
//        cell.btn.tag = indexPath.row
        
        cell.btn.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return cell
    }
    @objc func buttonSelected(sender: UIButton){
//        let btnPos = sender.convert(CGPoint.zero, to: table)
//            guard let indexPath = table.indexPathForRow(at: btnPos) else {
//              return
//            }
        
        let row = sender.tag
          //  let indexPath = IndexPath(row: row, section: 0)
        let vc = storyboard?.instantiateViewController(withIdentifier: "one") as! firstViewController
        vc.webiew = json?.articles?[row].url ?? ""
        navigationController?.pushViewController(vc, animated: true)
        print(sender.tag)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
}
