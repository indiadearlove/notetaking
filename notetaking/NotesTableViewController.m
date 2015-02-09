#import "NotesTableViewController.h"

#import "NoteAdapter.h"
#import "Note.h"

#import "NoteViewController.h"

@interface NotesTableViewController ()

@property NSMutableArray *notes;
@property NoteAdapter *noteAdapter;

@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.noteAdapter = [[NoteAdapter alloc] init];
    
    // We need this for swipe to remove
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    self.notes = [NSMutableArray arrayWithArray:[self.noteAdapter allNotes]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get a reference to the cell we want to display at indexPath
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultNoteCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Note *note = [self.notes objectAtIndex:indexPath.row];
    [cell.textLabel setText:note.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Deselect row / remove highlight
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // Get note for this cell
    Note *note = [self.notes objectAtIndex:indexPath.row];
    
    // Get controller
    NoteViewController *c = [self noteViewController];
    
    // Configure controller
    c.note = note;
    
    // Show controller
    [self.navigationController showViewController:c sender:self];
}

- (IBAction)addNoteButtonPressed:(id)sender {
    // Get controller
    NoteViewController *c = [self noteViewController];
    
    // Configure controller
    c.note = nil; // no note as we want to create a new one
    
    // Show controller
    [self.navigationController showViewController:c sender:self];
}

- (NoteViewController*)noteViewController {
    // Create controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // get detail view controller
    NoteViewController *c = [storyboard instantiateViewControllerWithIdentifier:@"NoteScene"];
    return c;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Get note object for this row
        Note *note = [self.notes objectAtIndex:indexPath.row];
        // Delete note object
        [self.noteAdapter deleteNote:note];
        // Delete note from array
        [self.notes removeObjectAtIndex:indexPath.row];
        // Delete the row from table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
