//
//  MyCell.h
//  DMS
//

// Usage - To display data in a grid type view.

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
{
    NSMutableArray *columns;
     NSMutableArray *alltags;
}
- (void)ResetAllColumnPositions;
- (void)addColumn:(CGFloat)position;
- (void)addColumn:(CGFloat)width tag:(int) val alignment:(NSInteger) align;
- (void)addImageColumn:(CGFloat)width height:(int) imgHeight tag:(int) val imageName:(NSString *) imgName;
- (void)addButton:(CGFloat)width height:(int) imgHeight tag:(int) val imageName:(NSString *) imgName target:(id) obj selector:(SEL) sel;
- (void)setColumn:(NSString *) strValue tag:(int) val;
- (void)setColumnButton:(NSString *) strValue tag:(int) val;
@property CGFloat rowheight;
@property CGFloat columnpadding;
@property BOOL originalOrientationIsPortrait;
@property BOOL originalOrientationIsLandscape;
@end
