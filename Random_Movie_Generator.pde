import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.util.TimeZone;
import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.text.ParseException;
JSONObject json;
PrintWriter output;
PImage img,IMDB_logo;
String movie_name;
String imdb_ID;
String time_final;
String ye;
Table table;
String rating;
int choice,runtime;
ArrayList<String> title_arr = new ArrayList();
ArrayList<String> id = new ArrayList();
ArrayList<String> Runtime = new ArrayList();
ArrayList<String> year = new ArrayList();
ArrayList<Integer> running_time = new ArrayList();
 PFont font;
String giveMeTextBetween(String s, String startTag, String endTag) {
  // Find the index of the beginning tag
  int startIndex = s.indexOf(startTag);
  // If I don't find anything
  if (startIndex == -1) {
    return "";
  }
  // Move to the end of the beginning tag
  startIndex += startTag.length();

  // Find the index of the end tag
  int endIndex = s.indexOf(endTag, startIndex);
  
  // If I don't find the end tag,
  if (endIndex == -1) {
    return "";
  }
  // Return the text in between
  return s.substring(startIndex, endIndex);
}



void setup(){
  size(600,600);
  background(51);
  output = createWriter("json.txt"); 
   table = loadTable("Movies.csv", "header");
   int i=0;
    for (TableRow row : table.rows()){
      String title = row.getString("Title");
      String ID      = row.getString("Const");
      String time = row.getString("Runtime (mins)");
      String Year = row.getString("Year");
      title_arr.add(title);
      id.add(ID);
      Runtime.add(time);
      year.add(Year);
    }
  
  font = loadFont("MicrosoftYaHeiUI-30.vlw");
  textFont(font, 32);
}

int generator = -1;  
void draw(){
  if(generator == -1){
    translate(width/2,height/2);
    textSize(20);
    fill(255,255,255);
    textFont(font, 20);
    text("Random Movie Generator",-120,-20);    
    text("Get started by clicking anywhere on the screen...",-220,20);
    
}
  
  if(generator == 1){
    background(51);
    choice = (int)random(title_arr.size()-1);
    json = loadJSONObject("http://www.omdbapi.com/?i="+id.get(choice)+"&apikey=c0062749");
    movie_name = json.getString("Title");
    imdb_ID = json.getString("imdbID");
    ye = json.getString("Year");
    runtime = Integer.parseInt(Runtime.get(choice));
    generator=0;
    println("Runtime:"+runtime+"minutes");
  }
  
  if(generator == 0){
    background(51);
    fill(255,255,255);
    textSize(20);
    textAlign(CENTER,BOTTOM);
    text(movie_name+"("+ye+")",width/2,120 );
    
    
    //text(movie_name,215,75 );
    /*int hour = runtime / 60;
    int minute = runtime - (hour*60);
    
    if(hour<10)
    {
      time_final= "0"+hour+":"+minute+":00";
    }
    
    if(hour<10 && minute<10)
    {
      time_final= "0"+hour+":0"+minute+":00";
    }
    SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");  
    Date date = new Date();
    String curr_time = formatter.format(date);  
    System.out.println(curr_time+" "+time_final);
     SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
     timeFormat.setTimeZone(TimeZone.getTimeZone("IST"));
    
      try{
    Date date1 = timeFormat.parse(time_final);
    Date date2 = timeFormat.parse(curr_time);
    long sum = date1.getTime() + date2.getTime();

    String date3 = timeFormat.format(new Date(sum));
    System.out.println("The sum is "+date3);
      }catch(ParseException e){}
    */
    
    String url = "http://www.imdb.com/title/"+id.get(choice);
    String[] lines = loadStrings(url);
    String html = join(lines, " ");
    // output.println(html); 
    //output.flush(); 
    //output.close();
    String posterurl = giveMeTextBetween(html,"Poster\" src=","/>");
    posterurl= posterurl.substring(1,posterurl.length()-2);
    rating = giveMeTextBetween(html,"ratingValue\": \"","\"   }");
    println(rating);
    fill(255,255,255);
    img = loadImage(posterurl,"jpg");
    IMDB_logo = loadImage("https://m.media-amazon.com/images/G/01/imdb/images/plugins/imdb_46x22-2264473254._CB470047279_.png","png");
    translate(width/2,height/2);
    imageMode(CENTER);
    image(img,0,0); 
    imageMode(CENTER);
    image(IMDB_logo,-20,170);
    text(rating,20,183);
    
  }
  
}

void mousePressed(){
  background(51);
  generator=1;
  textSize(32);
  textAlign(CENTER,CENTER);
  text("Loading...",0,0);
}
