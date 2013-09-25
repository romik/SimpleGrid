//
//  MyCell.m
//  DMS
//

//

#import "MyCell.h"

@implementation MyCell
@synthesize rowheight,columnpadding;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addColumn:(CGFloat)position {
    if(columns==nil)
    {
        columns=[[NSMutableArray alloc]init];
    }
    [columns addObject:[NSNumber numberWithFloat:position]];
}

- (void)addColumn:(CGFloat)width tag:(int) val alignment:(NSInteger) align
{
    if(columns==nil)
    {
        columns=[[NSMutableArray alloc]init];
    }
    if(alltags==nil)
    {
        alltags=[[NSMutableArray alloc] init];
    }
    [alltags addObject:[NSNumber numberWithInt:val]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([self SumColumns]+2, 0, width ,self.rowheight)] ;
    [columns addObject:[NSNumber numberWithFloat:width]];
    label.tag = val;
    //label.font = [UIFont systemFontOfSize:9.0];
    label.font = [UIFont fontWithName:@"Arial" size:12];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment = align;
    label.textColor = [UIColor blackColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:label];
    
}

- (void)addImageColumn:(CGFloat)width height:(int) imgHeight tag:(int) val imageName:(NSString *) imgName
{
    if(columns==nil)
    {
        columns=[[NSMutableArray alloc]init];
    }
    if(alltags==nil)
    {
        alltags=[[NSMutableArray alloc] init];
    }
    [alltags addObject:[NSNumber numberWithInt:val]];
    
    
    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([self SumColumns]+2, 0, width ,self.rowheight)] ;
    UIImage *img = [[UIImage imageNamed:imgName]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img] ;
    [imageView setFrame:CGRectMake([self SumColumns]+2, 0, width ,imgHeight)];
    [columns addObject:[NSNumber numberWithFloat:width]];
   imageView.tag = val;
    
    [self.contentView addSubview:imageView];
}
- (void)addButton:(CGFloat)width height:(int) imgHeight tag:(int) val imageName:(NSString *) imgName target:(id) obj selector:(SEL) sel
{
    if(columns==nil)
    {
        columns=[[NSMutableArray alloc]init];
    }
    if(alltags==nil)
    {
        alltags=[[NSMutableArray alloc] init];
    }
    [alltags addObject:[NSNumber numberWithInt:val]];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake([self SumColumns]+2, 5, width ,imgHeight);
    UIImage *Image = [[UIImage imageNamed:imgName]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:Image forState:UIControlStateNormal];
    [columns addObject:[NSNumber numberWithFloat:width]];
    btn.tag = val;
   
    [btn addTarget:obj action:sel forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn];
}



-(CGFloat) SumColumns
{
    CGFloat sum=0;
    for (NSNumber *num in columns) {
        sum=sum+num.floatValue+(2*columnpadding);
    }      
        
    return sum;
}

- (void)setColumn:(NSString *) strValue tag:(int) val
{
    UILabel *label=(UILabel*)[self viewWithTag:val];
    label.text=strValue;
}

- (void)setColumnButton:(NSString *) strValue tag:(int) val
{
    UIButton *button=(UIButton*)[self viewWithTag:val];
    button.titleLabel.text=strValue;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // Use the same color and width as the default cell separator for now
    //CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(ctx, 0.5);
    

    CGFloat sum=0;
   /* for (NSNumber *num in columns) {
        sum=sum+num.floatValue+columnpadding;
        CGContextMoveToPoint(ctx, sum, 0);
        CGContextAddLineToPoint(ctx, sum, self.bounds.size.height);
        
    }*/
    int x=0;
    for(NSNumber *num in alltags)
    {
        UIView *view =[self viewWithTag:num.integerValue];
        x= view.frame.origin.x + view.frame.size.width + columnpadding;
        CGContextMoveToPoint(ctx, x, 0);
        CGContextAddLineToPoint(ctx, x, self.bounds.size.height);
        //int x1= view.frame.origin.x - columnpadding;
        //CGContextMoveToPoint(ctx, x1, 0);
        //CGContextAddLineToPoint(ctx, x1, self.bounds.size.height);
    }
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (void)ResetAllColumnPositions
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;  
    for(NSNumber *num in alltags)
    {
        UIView *view =[self viewWithTag:num.integerValue];
              
        
        //if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
        if((orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight))   
        
        {
            if(!self.originalOrientationIsLandscape)
            {
                CGRect newframe= view.frame;
                newframe.origin.x = view.frame.origin.x * 1024/768;
                if(![view isKindOfClass:[UIButton class]])
                    newframe.size.width = view.frame.size.width * 1024/768;
                view.frame=newframe;
                
            }
        }
        
        //if(UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
        else
        {
            if(!self.originalOrientationIsPortrait)
            {
                CGRect newframe= view.frame;
                newframe.origin.x = view.frame.origin.x * 768/1024;
                if(![view isKindOfClass:[UIButton class]])
                    newframe.size.width = view.frame.size.width * 768/1024;
                view.frame=newframe;

            }
        }
        
    }
    //if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    if((orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight)) 
    {
        if(!self.originalOrientationIsLandscape)
        {
            self.originalOrientationIsLandscape = YES;
            self.originalOrientationIsPortrait = NO;
            
        }
    }
    
    //if(UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    if((orientation == UIInterfaceOrientationPortrait) || (orientation == UIInterfaceOrientationPortraitUpsideDown))
    {
        if(!self.originalOrientationIsPortrait)
        {
            self.originalOrientationIsLandscape = NO;
            self.originalOrientationIsPortrait = YES;
        }
    }
    
}



@end
