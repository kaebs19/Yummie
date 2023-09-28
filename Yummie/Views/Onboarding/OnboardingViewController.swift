import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Variables

    var slides: [OnboardingSlide] = [] // مصفوفة تحتوي على معلومات الشرائح
    
    var currentPage = 0 { // متغير يتتبع الشريحة الحالية
        didSet {
            // عندما يتغير `currentPage`, يتم تحديث عنصر التحكم بالصفحات ونص زر التالي
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("ابدأ الآن", for: .normal)
            } else {
                nextButton.setTitle("التالي", for: .normal)
            }
        }
    }
    
    // MARK: - View Life Cycle
    // دورة حياة الواجهة
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // تكوين معلومات الشرائح
        slides = [
            OnboardingSlide(title: "أطباق لذيذة", description: "تجربة مجموعة متنوعة من الأطباق الرائعة من مختلف الثقافات حول العالم", image: UIImage(named: "slide3")!) ,
            
            OnboardingSlide(title: "طهاة عالميين", description: "تم تحضير أطباقنا فقط من قبل أفضل الطهاة", image: UIImage(named: "slide2")!) ,
            
            OnboardingSlide(title: "توصيل على مستوى العالم الفوري", description: "سيتم توصيل طلباتك فوراً", image: UIImage(named: "slide1")!)
        ]
        
        pageControl.numberOfPages = slides.count
        
        // إعداد مكون العرض الخاص بالشرائح
        setupCollectionView()
    }
    
    // MARK: -  Configure Action - Func
    // تكوين إجراء الزر وإعداد مكون العرض
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            // عندما ينقر المستخدم على الزر ويكون على آخر شريحة، يتم توجيهه إلى الشاشة الرئيسية
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "homeVC") as? UINavigationController  else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            // إذا لم يكن المستخدم على آخر شريحة، سيتم نقله إلى الشريحة التالية
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// تمديد الفئة `OnboardingViewController` لتنفيذ بروتوكولات UICollectionViewDelegate وUICollectionViewDataSource وUICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    // تنفيذ الدوال اللازمة لمكون العرض (UICollectionView)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // إعداد الخلية (Cell) لعرض معلومات الشريحة
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OmboardingCollectionViewCell.identifier, for: indexPath) as! OmboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // تعيين حجم الشريحة لتملئ عرض مكون العرض بالكامل وتأخذ ارتفاعه
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // عند انتهاء التمرير بواسطة المستخدم، يتم تحديد الشريحة الحالية بناءً على الموقع الحالي للتمرير الأفقي
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
