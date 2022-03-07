import de.bezier.guido.*;
private static final int NUM_ROWS = 10;
private static final int NUM_COLS = 10;
private static final int mineNum = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    setMines();
}
public void setMines(){
    //your code
    while(mines.size() < mineNum){
        MSButton temp = buttons[(int)(Math.random() * NUM_ROWS)][(int)(Math.random() * NUM_COLS)];
        if(!mines.contains(temp)){
            mines.add(temp);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int h = 0; h < mines.size(); h++){
      if(mines.get(h).isFlagged() == false){
        return false;
      }
     }
    return true;
}
public void displayLosingMessage()
{
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLabel("L");
    }
  }
}
public void displayWinningMessage()
{
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLabel("W");
      }
    }
}
public boolean isValid(int r, int c)
{
   if(r< NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0){
    return true;
  }
  else{
    return false;
  
}

}
public int countMines(int row, int col)
{
 int numMines = 0;
 //your code here
 if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1])){
   numMines++;
 }
 if(isValid(row-1,col) && mines.contains(buttons[row-1][col])){
   numMines++;
 }
 if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1])){
   numMines++;
 }
 if(isValid(row,col-1) && mines.contains(buttons[row][col-1])){
   numMines++;
 }
 if(isValid(row,col+1) && mines.contains(buttons[row][col+1])){
   numMines++;
 }
 if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1])){
   numMines++;
 }
 if(isValid(row+1,col) && mines.contains(buttons[row+1][col])){
   numMines++;
 }
 if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1])){
   numMines++;
 }
 return numMines;
}

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;

        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton ==RIGHT){
          flagged = !flagged;
          if(flagged == false){
            clicked = false;
          }
        }
          else if(mines.contains(this)){
            displayLosingMessage();
          }
          else if(countMines(myRow,myCol) > 0){
            setLabel(countMines(myRow,myCol));
          }
          else{
            for(int r = myRow-1; r < myRow+2; r++){
              for(int c = myCol-1; c < myCol+2; c++){
                if(isValid(r,c) && buttons[r][c].clicked == false){
                  buttons[r][c].mousePressed();
                }
              }
            }
          }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(135, 206, 235);
         else if( clicked && mines.contains(this) ) 
             fill(244, 191, 246);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        textSize(25);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

