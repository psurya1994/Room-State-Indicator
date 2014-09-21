int Array[8][32] = {
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0},
  {0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0},
  {0,1,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0},
  {0,1,1,1,1,1,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0},
  {0,1,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0},
  {0,1,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
};

int ArrayClipper = 0;
int clip = 0;

int rowPins[8] = {6,3,8,2,15,9,17,10};
int columnPins[8] = {19,18,14,7,13,5,4,16};

void setup()
{
  Serial.begin(9600);
  for(int i =0;i < 8;i++)
  {
    pinMode(rowPins[i],OUTPUT);
    pinMode(columnPins[i],OUTPUT);
    digitalWrite(columnPins[i],HIGH);
  }
}

void loop()
{
  show(Array,100);
}

void show(int image[8][32], unsigned long duration)
{
  clip = (ArrayClipper%32);
  unsigned long start = millis();
  while(start+duration>millis())
  {
    for(int row = 0; row < 8; row++)
    {
      digitalWrite(rowPins[row], HIGH);
      for(int column=(0+clip); column < 8+clip; column ++)
      {
        boolean pixel = image[row][column%32];
        if(pixel==1)
        {
          digitalWrite(columnPins[column-clip], LOW);
        }
        delayMicroseconds(300);
        digitalWrite(columnPins[column-clip],HIGH);
      }
    digitalWrite(rowPins[row], LOW);
    }
  }
  ArrayClipper+=1;
}
