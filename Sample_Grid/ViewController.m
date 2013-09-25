//
//  ViewController.m
//  Sample_Grid
//

//

#import "ViewController.h"
#import "MyCell.h"
#import "Data1.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView1;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self FillSampleData];
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)  name:UIDeviceOrientationDidChangeNotification  object:nil];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)orientationChanged:(NSNotification *)notification{
    [tableView1 reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) FillSampleData
{
    if(arrayData==nil)
    {
        arrayData = [[NSMutableArray alloc] init];
    }
    [arrayData removeAllObjects];
    for(int i=0;i<20;i++)
    {
        Data1 *obj = [[Data1 alloc] init];
        obj.col1 = [NSString stringWithFormat:@"Col 1 - Row %d", i];
        obj.col2 = [NSString stringWithFormat:@"Col 2 - Row %d", i];
        obj.col3 = [NSString stringWithFormat:@"Col 3 - Row %d", i];
        obj.col4 = [NSString stringWithFormat:@"Col 4 - Row %d", i];
        obj.col5 = [NSString stringWithFormat:@"Col 5 - Row %d", i];
        obj.col6 = [NSString stringWithFormat:@"Col 6 - Row %d", i];
        obj.col7 = [NSString stringWithFormat:@"Col 7 - Row %d", i];
        obj.col8 = [NSString stringWithFormat:@"Col 8 - Row %d", i];
        [arrayData addObject:obj];
        
    }
}

#pragma mark - Table Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
        
    MyCell *cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
    if (cell == nil)
    {            
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier ];
            // cell.selectionStyle = UITableViewCellSelectionStyleN;
            
            //UIImage *selectionBackground = [UIImage imageNamed:@"grid-color-active.png"];
           // UIImageView *iview=[[UIImageView alloc] initWithImage:selectionBackground];
           // [cell setSelectedBackgroundView:iview];
            
            cell.originalOrientationIsPortrait = YES;
            cell.originalOrientationIsLandscape=NO;
            cell.rowheight=tableView.rowHeight;
            cell.columnpadding=10;
            
            //[cell addColumn:-15 tag:0 alignment:NSTextAlignmentLeft];
            [cell addColumn:70 tag:1 alignment:NSTextAlignmentRight];
            [cell addColumn:70 tag:2 alignment:NSTextAlignmentCenter];
            [cell addColumn:70 tag:3 alignment:NSTextAlignmentLeft];
            [cell addColumn:70 tag:4 alignment:NSTextAlignmentLeft];
            [cell addColumn:70 tag:5 alignment:NSTextAlignmentLeft];
            [cell addColumn:70 tag:6 alignment:NSTextAlignmentLeft];
            [cell addColumn:70 tag:7 alignment:NSTextAlignmentLeft];
            [cell addColumn:70 tag:8 alignment:NSTextAlignmentRight];

            //[cell addButton:28 height:28 tag:11 imageName:@"arrow.png" target:self selector:@selector(buttonDrillDown:) ];
        }
        
        //////////////
        Data1 *detail = [arrayData objectAtIndex:indexPath.row];
        [cell setColumn:detail.col1 tag:1];
        [cell setColumn:detail.col2 tag:2];
        [cell setColumn:detail.col3 tag:3];        
        [cell setColumn:detail.col4 tag:4];
        [cell setColumn:detail.col5 tag:5];
        [cell setColumn:detail.col6 tag:6];
        [cell setColumn:detail.col7 tag:7];
        [cell setColumn:detail.col8 tag:8];

        //[cell setColumnButton:[NSString stringWithFormat:@"%d", indexPath.row] tag:11];
        
        [cell ResetAllColumnPositions];
        
        return cell;
    
        
    
}

@end
