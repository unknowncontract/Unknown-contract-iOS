
## 초기 셋팅 (Code Base)


1. 스토리보드 지우기

2. Info.plist 
    1. Application Scene Manifest  > Scene Configuration > Application Session Role > Item 0
    3. storyboard Name  지우기

3. Target 
    1. 검색창(왼쪽 인디케이터) main 검색 
    2. INFOPLIST_KEY ~ 클릭 
    3. 오른쪽 필터 검색창에 main 검색
    4. UIKit Main Storyboard File Base Name 제거 

4. SceneDeleagte
    ```swift

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = ViewController()
            window?.makeKeyAndVisible()
        }


    ```

## 카메라
1. info.plist
    1. Privacy - Camera Usage Description
2. [구현 참고 링크](https://yagom.net/forums/topic/%EC%B9%B4%EB%A9%94%EB%9D%BC-%EC%96%B4%ED%94%8C-%EB%A7%8C%EB%93%A4%EA%B8%B0-3%ED%8E%B8/)
    

## 파일 피커
1. info.plist
    1. Supports opening documents in place 추가
    Application supports iTunes file sharing 추가


## [UICollectionView](https://k-elon.tistory.com/25)
