// Question Class

class Question  //(1)
{
  int id=0;
  String question="";
  String answer1, answer2, answer3="";
  int total1, total2, total3 = 0;
  int myAnswer, correctAnswer;

  Question(String _row)  //(2)
  {
    String[] parts = split(_row, '\t');    //(3)
    if (parts.length == 4)
    {
      question = parts[0];
      answer1 = parts[1];
      answer2 = parts[2];
      answer3 = parts[3];
    }
  }

  Question(int _id, String q, String a1, String a2, String a3)  //(4)
  {
    id = _id;
    question = q;
    answer1 = a1;
    answer2 = a2;
    answer3 = a3;
  } 

  void updateStats(int s1, int s2, int s3)  //(5)
  {
    total1 = s1;
    total2 = s2;
    total3 = s3;
  }
  void processAnswerStat(int _answer)  //(6)
  {
    if (_answer == 1)  
      total1++;
    else if (_answer == 2)
      total2++;
    else if (_answer == 3)
      total3++;
  }

  void setAnswer(int _answer)
  {
    myAnswer = _answer;
    processAnswerStat(_answer);
  }

  float getAnswerStat(int _answer)  //(7)
  {
    if (_answer == 1)  
      return total1;
    else if (_answer == 2)
      return total2;
    else if (_answer == 3)
      return total3;
    return 0;
  }

  void saveResults()  //(8)
  {
    String line = question + "\t" + 
      answer1 + "\t" + total1 + "\t";
    line += answer2 + "\t" + total2 + "\t" + 
      answer3 + "\t" + total3;
  }

  boolean isAnswered()
  {
    if (myAnswer == 0)
      return false;
    return true;
  }

  void display(int x, int y) //(9)
  { 
    pushStyle();
    pushMatrix();
    translate(x, y);
    if (myAnswer == 0  && !isServer)
    {
      text(id+") " + question + "\n\n" + 
        "[1] " + answer1 + "\n" +
        "[2] " + answer2 + "\n" + 
        "[3] " + answer3, 0, 0);
    }
    else
    {

      float total = total1+total2+total3;

      //avoid div by 0
      if (total == 0)
        total = 1;

      float lineheight = textAscent()+textDescent();
      lineheight = 20;
      text( id+") " + question, 0, 0);

      textAlign(LEFT, TOP);
      translate(0, lineheight*2);

      text(answer1 + " (" + nf((total1/total)*100, 2, 2) + " %) ", 0, 0);
      translate(0, lineheight*1.5);
      rect(0, 0, map((total1/total)*100, 0, 100, 0, width-150), lineheight-5);
      translate(0, lineheight*1.5);

      text(answer2 + " (" +nf( (total2/total)*100, 2, 2 ) + " %) ", 0, 0);
      translate(0, lineheight*1.5);
      rect(0, 0, map((total2/total)*100, 0, 100, 0, width-150), lineheight-5);
      translate(0, lineheight*1.5);


      text(answer3 + " (" +nf( (total3/total)*100, 2, 2) + " %) ", 0, 0);
      translate(0, lineheight*1.5);
      rect(0, 0, map((total3/total)*100, 0, 100, 0, width-150), lineheight-5);
      translate(0, lineheight*2.5);

      if (isServer)
        text("Number of Answers for this question: " + total, 0, 0);
    }
    popMatrix();
    popStyle();
  }
}

