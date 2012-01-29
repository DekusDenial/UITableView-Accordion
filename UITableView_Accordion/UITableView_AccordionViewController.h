//
//  UITableView_AccordionViewController.h
//  UITableView_Accordion
//
//  Created by Dekus on 1/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MediaPlayer/MediaPlayer.h>

@interface UITableView_AccordionViewController : UITableViewController {
    BOOL isSelected;
    CGFloat customCellHeight[4];
}

@property (nonatomic, retain) NSArray *tableArray;
@property (nonatomic, retain) NSIndexPath *indexPathSelected;

@property (nonatomic, assign) IBOutlet UITableViewCell * recentDrawingCell;
@property (nonatomic, assign) IBOutlet UITableViewCell * matchMatchCell;
@property (nonatomic, assign) IBOutlet UITableViewCell * jackpotWinnersCell;
@property (nonatomic, assign) IBOutlet UITableViewCell * drawingVideoCell;
@property (nonatomic, assign) IBOutlet UITableViewCell * emptyCell;
@property (nonatomic, assign) IBOutlet UILabel * footer;
@property (nonatomic, retain) NSArray * detailCellArray;

- (IBAction) playVideo: (id)sender;

@end
