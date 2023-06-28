//
//  MultiGestureCollectionView.h
//  TradeBook
//
//  Created by kim on 2022/9/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 识别多手势
@interface MultiGestureCollectionView : UICollectionView <UIGestureRecognizerDelegate>
// 是否可以识别多手势 默认为NO
@property (nonatomic, assign) BOOL shouldRecognizeSimultaneously;
@end

NS_ASSUME_NONNULL_END
