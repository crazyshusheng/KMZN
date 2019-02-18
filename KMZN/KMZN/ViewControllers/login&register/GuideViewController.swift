

import UIKit

class GuideViewController: UIViewController ,UIScrollViewDelegate{
    
 
    @IBOutlet weak var pageView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var startButton: UIButton!
    
    
    //页面数量
    private let numOfPages = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        
    
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * CGFloat(numOfPages), height: SCREEN_HEIGHT)
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = true
   
        for i  in 0..<numOfPages {
            let imgfile = "guidePage\(Int(i+1)).png"
            let image = UIImage(named: "\(imgfile)")
            let imgView = UIImageView(image: image)
            imgView.frame=CGRect(x: SCREEN_WIDTH*CGFloat(i), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            scrollView.addSubview(imgView)
        }
        scrollView.contentOffset = CGPoint.zero
        scrollView.delegate=self

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let twidth = CGFloat(numOfPages - 1 ) * self.view.bounds.size.width
        
        if scrollView.contentOffset.x == twidth {
            
            startButton.isHidden = false
           
            
        }else{
            
            startButton.isHidden = true
       
        }
        
        pageViewChange(page: (Int(scrollView.contentOffset.x)/Int(self.view.frame.size.width)))
        
    }
    
    
    
    
    @IBAction func goToStart(_ sender: Any) {
        
        UserSettings.shareInstance.setValue(key: "everLaunched", value: "true")
        
        
        gotoMianViewControll()
    }

    
    
    //回到主界面
    func gotoMianViewControll(){
        
        let mainStroryboard = UIStoryboard(name: "Main",bundle:nil)
        let viewController = mainStroryboard.instantiateViewController(withIdentifier: "tabarVC")
        self.present(viewController, animated: false , completion: nil)

    }
    
    
    
    
    
    func pageViewChange(page:Int){
        
        
       
        
        for i in 0...2{
            
            let view = pageView.viewWithTag(i+1) as? UIButton
            
            if page == i {
                view?.isSelected = true
            }else{
                view?.isSelected = false
            }
        }
    }
    
    
}


