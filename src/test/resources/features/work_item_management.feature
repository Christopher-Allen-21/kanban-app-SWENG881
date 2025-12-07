Feature: Kanban Board Management System

  # Board Management
  @board-management
  Scenario: TC-BOARD-001 - Create board with valid name
    Given the board management system is ready
    When I create a board with name "Test Board"
    Then the board "Test Board" should be created and visible in the board list

  @board-management
  Scenario: TC-BOARD-002 - Successfully rename board
    Given a board named "Old Name" exists
    When I rename the board to "New Name"
    Then the board name should be updated to "New Name" everywhere

  @board-management
  Scenario: TC-BOARD-003 - Delete board and its contents
    Given a board "Board to Delete" exists with columns and cards
    When I delete the board "Board to Delete"
    Then the board and all its child columns and cards should be removed

  @board-management @negative
  Scenario: TC-BOARD-004 - Reject board with empty name
    Given the board management system is ready
    When I attempt to create a board with an empty name
    Then an error should be thrown and board creation should be prevented

  # Column Management
  @column-management
  Scenario: TC-COLUMN-001 - Add valid column
    Given a board named "Test Board" with only one column exists
    When I add a column named "Review" to the board
    Then the column should be added to the board

  @column-management
  Scenario: TC-COLUMN-002 - Reorder columns
    Given a board exists with columns "Column1,Column2,Column3"
    When I reorder columns to "Column2,Column1,Column3"
    Then the columns should be reordered correctly

  @column-management @negative
  Scenario: TC-COLUMN-003 - Prevent duplicate column name within the same board
    Given a board "Test Board" exists with column "To Do"
    When I attempt to add another column named "To Do"
    Then an error should be thrown and duplicate column creation prevented

  @column-management @error-handling
  Scenario: TC-COLUMN-004 - Handle move/delete for invalid column
    Given a board "Test Board" exists
    When I attempt to move or delete a non-existent column "InvalidColumn"
    Then the system should prevent the invalid column action

  # Card/Work Item Management
  @card-management
  Scenario: TC-CARD-001 - Add valid card to column
    Given a board with column "To Do" exists
    When I add a card "Test Card" to column "To Do"
    Then the card should appear in the correct column

  @card-management
  Scenario: TC-CARD-002 - Update card and its attributes
    Given a card "Test Card" exists in column "To Do"
    When I update the card title to "Updated Card" and description to "New description"
    Then the card should show the updated title and description

  @card-management @negative
  Scenario: TC-CARD-003 - Prevent invalid data card creation
    Given a board with column "To Do" exists
    When I attempt to create a card with invalid data
    Then card creation should be blocked with appropriate error

  @card-management
  Scenario: TC-CARD-004 - Delete card from column
    Given a card "Card to Delete" exists in column "To Do"
    When I delete the card from the column
    Then the card should be removed from the board

  # Drag and Move
  @drag-move
  Scenario: TC-MOVE-001 - Move card between columns
    Given a board exists with columns "To Do,In Progress"
    And I add a card "Move Card" to column "To Do"
    When I move the card "Move Card" to column "In Progress"
    Then the card should be moved to the correct column

  @drag-move
  Scenario: TC-MOVE-002 - Reorder cards within same column
    Given a column "To Do" has cards "Card1,Card2,Card3"
    When I reorder cards to "Card2,Card1,Card3"
    Then the card indexing should be updated

  @drag-move @error-handling
  Scenario: TC-MOVE-003 - Prevent move to invalid/non-existent column
    Given a card "Test Card" exists in column "To Do"
    When I attempt to move the card to a non-existent column "InvalidColumn"
    Then the operation should be rejected

  @drag-move @boundary
  Scenario: TC-MOVE-004 - Move card from/to extreme indices
    Given a column has 10 cards
    When I move a card from index 0 to index 9 or vice versa
    Then the boundary rules should be enforced correctly

  # Persistence Layer
  @persistence
  Scenario: TC-PERSIST-001 - Save board
    Given a board with columns and cards exists
    When I save the board to a file
    Then the file should be saved correctly with all data

  @persistence
  Scenario: TC-PERSIST-002 - Load board
    Given a valid board data file exists
    When I load the board from the file
    Then the board should be restored correctly

  @persistence
  Scenario: TC-PERSIST-003 - Overwrite board data
    Given a board data file exists with old data
    When I save new board data to the same file
    Then the new data should replace the old data safely

  @persistence @error-handling
  Scenario: TC-PERSIST-004 - Test data cleanup
    Given temporary board files exist
    When the application cleans up temporary files
    Then temporary files should be handled properly

  # Error Handling, Boundaries, and Regression
  @error-handling
  Scenario: TC-ERROR-001 - Null input handling
    Given the board management system is ready
    When I provide null inputs to board operations
    Then all operations should be null-safe and handle gracefully

  @error-handling
  Scenario: TC-ERROR-002 - Invalid states
    Given a board is in an inconsistent state
    When I perform operations on the invalid state
    Then the system should reject illegal operations

  @regression
  Scenario: TC-REGRESSION-001 - Re-run full suite
    Given all previous tests have passed
    When I re-run the complete test suite
    Then all previously passing tests should still pass

  @boundary
  Scenario: TC-BOUNDARY-001 - Max cards per column
    Given a column can hold a maximum of N cards
    When I add the maximum number of cards to a column
    Then the system should handle the boundary correctly

  # Work Item Management Scenarios
  @work-item-creation
  Scenario: Successfully create a work item
    Given a kanban board exists with three phases
    When I create a new work item
    Then the work item exists on the board

  @work-item-movement
  Scenario: Move work item between phases
    Given a work item exists in the first phase
    When I move the work item to the next phase
    Then the work item is in the next phase
