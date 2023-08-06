//
//  HomeVC + CollectionView.swift
//  Filker Photos using mvvm-c
//
//  Created by Sherif Hamdy on 06/08/2023.
//

import UIKit

//MARK:- Configure Datasource
extension HomeVC{
    internal func makeDataSource() -> DataSource {
        // 1
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self](collectionView, indexPath, video) ->
                UICollectionViewCell? in
                guard let self = self else{return nil}
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
                let photo = self.viewModel.banners[indexPath.section].photosData[indexPath.item]
                cell.setupCell(photo: photo)
                return cell
            })
        
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = self.dataSource.snapshot()
                .sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BannerCollectionReusableView.reuseIdentifier,
                for: indexPath) as? BannerCollectionReusableView
            return view
        }
        
        
        return dataSource
    }
    
}

extension HomeVC{
    internal func setupCollectionView(){
        collectionView.delegate = self
        //        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        
        collectionView.register(
            BannerCollectionReusableView.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BannerCollectionReusableView.reuseIdentifier
        )
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.setCollectionViewLayout(layout, animated: true)
        addRefreshAndTarget()
    }
    
    private func addRefreshAndTarget(){
        self.collectionView.addRefresherToCollectionView()
        self.collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh(){
        input.send(.refreshData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.collectionView.refreshControl?.endRefreshing()
        }

    }
}

extension HomeVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //presenter.didTabOnItem(index: indexPath.item)
        input.send(.viewImage(indexPath: indexPath))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == viewModel.banners.count - 1 && viewModel.isLoading == false{
            input.send(.loadMore)
        }
    }
}

extension HomeVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //here your custom value for spacing
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = (collectionView.frame.width/2) - (lay.minimumInteritemSpacing/2) - lay.sectionInset.left
        return CGSize(width:widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let availableWidth = view.frame.width
        let heightPerItem = availableWidth * 1/3
        return CGSize(width: availableWidth, height: heightPerItem)
    }
}
