//
//  UITableView_AccordionViewController.m
//  UITableView_Accordion
//
//  Created by Dekus on 1/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableView_AccordionViewController.h"
#import <QuartzCore/QuartzCore.h>

// How long it should wait before displaying the cell content
#define HARDCODED_REAPPEAR_DELAY 0.20

@implementation UITableView_AccordionViewController

@synthesize tableArray, indexPathSelected, footer;
@synthesize recentDrawingCell, matchMatchCell, jackpotWinnersCell, drawingVideoCell, emptyCell, detailCellArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Memory management

- (void)dealloc
{
    [tableArray release];
    [indexPathSelected release];
    [recentDrawingCell release];
    [matchMatchCell release];
    [jackpotWinnersCell release];
    [drawingVideoCell release];
    [detailCellArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"You are in: %s", __FUNCTION__);
    [super viewDidLoad];
    isSelected = NO;
    
    // Initialize the title cell for the accordion
    self.tableArray = [NSMutableArray arrayWithObjects:@"Recent Drawing", @"Matched Numbers", @"Jackpot Winners", @"Drawing Video", nil];

    // put all custom table cell outlets into the array for later access
    [[NSBundle mainBundle] loadNibNamed:@"CustomAccordionCells" owner:self options:nil];
    self.detailCellArray = [NSArray arrayWithObjects:recentDrawingCell, matchMatchCell, jackpotWinnersCell, drawingVideoCell, nil];
    
    // set each cell height into array of CGFloat
    NSLog(@"height is : %f ", recentDrawingCell.contentView.bounds.size.height);
    customCellHeight[0] = recentDrawingCell.contentView.bounds.size.height;
    customCellHeight[1] = matchMatchCell.contentView.bounds.size.height;
    customCellHeight[2] = jackpotWinnersCell.contentView.bounds.size.height;
    customCellHeight[3] = drawingVideoCell.contentView.bounds.size.height;
    
    // Slight gap for header and no gap for footer
    self.tableView.sectionHeaderHeight = 1.0;
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Mark first title as the default title
    self.indexPathSelected = [NSIndexPath indexPathForRow:0 inSection:0]; 
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Add the footer to the tableView's super view
    self.footer.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - self.footer.frame.size.height/2);
    [self.view addSubview:self.footer];
}


- (void)viewDidUnload
{
    NSLog(@"You are in: %s", __FUNCTION__);
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableArray = nil;
    self.indexPathSelected = nil;
    self.recentDrawingCell = nil;
    self.matchMatchCell = nil;
    self.jackpotWinnersCell = nil;
    self.drawingVideoCell = nil;
    self.detailCellArray = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:animated];
//    [self.tableView reloadData];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"You are in: %s", __FUNCTION__);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"You are in: %s", __FUNCTION__);
    return [tableArray count] + [detailCellArray count]; // sum of title and detail content rows
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"You are in: %s", __FUNCTION__);
    static NSString *CellIdentifier = @"Accordion";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // Configure the cell...
    
    if (indexPath.row % 2 == 0) //if the row is odd number row
        cell.textLabel.text = [tableArray objectAtIndex: indexPath.row / 2];   
    else //if (self.indexPathSelected.row == indexPath.row - 1)
    {
        cell = [self.detailCellArray objectAtIndex:(indexPath.row - 1) / 2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (self.indexPathSelected.row != (indexPath.row - 1))
            cell.hidden=YES;
    }
        
    return cell;
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // rows in section 0 should not be selectable
//    if (indexPath.row % 2 != 0)    
//        return nil;
//    // By default, allow row to be selected
//    return indexPath;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    NSLog(@"You are in: %s, #####  cell height is : %f", __FUNCTION__, [tableView cellForRowAtIndexPath:indexPath].contentView.bounds.size.width);
    NSLog(@"selected BEFORE: %d  selected NOW: %d \n", self.indexPathSelected.row, indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // make highlight goes away
    
    if (indexPath.row == self.indexPathSelected.row + 1) return;
    if (self.indexPathSelected != indexPath)
    {      
        [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexPathSelected.row+1 inSection:self.indexPathSelected.section]].hidden=YES;     
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
        
        [tableView beginUpdates];
        
        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] performSelector:@selector(setHidden:) withObject:NO afterDelay: HARDCODED_REAPPEAR_DELAY];
        
        self.indexPathSelected = indexPath;
        
        [tableView endUpdates];
        
        return ;
    }
    
    
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"You are in: %s", __FUNCTION__);
    if (indexPath.row % 2 == 0) // if the row is odd number
        return 41.0;    // just to make title cell smaller to reflect the max content cell height, so the overall tableview will be fit on the screen without scrolling yet!
    else if (self.indexPathSelected.row == indexPath.row - 1)
        return (customCellHeight[(indexPath.row -1) / 2]) + 0.0;
    else
        return 0.0;  // hide the row if all failed.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"You are in: %s", __FUNCTION__);
    if (indexPath.row % 2 == 0) //if the row is odd number row
    {
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }  
    else
    {
        cell.backgroundColor = [UIColor blackColor];
    }
}


- (IBAction) playVideo:(id)sender
{
    // some MPMoviePlayerController going on here. MediaPlayer.framework already imported
    
    NSLog(@"You are in: %s", __FUNCTION__);
    
    
    // Video streaming testing code
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mov"];
//    NSURL *url = [NSURL URLWithString:@"http://someURL.supportedmediatype"];
//    MPMoviePlayerViewController *playerViewController =
//    [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//    playerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentMoviePlayerViewControllerAnimated:playerViewController];
//    [playerViewController release];
}

@end
