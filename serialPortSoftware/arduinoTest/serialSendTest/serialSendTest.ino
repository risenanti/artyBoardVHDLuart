static int i = 0;
float x;
unsigned char *c = (unsigned char *)&x;

//unsigned char *c = (unsigned char *)"ABCD";

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {

  x = 3.145673;

  for (i = 0; i < sizeof(float); ++i)
  {
    Serial.write(c[i]);
  }

    x = 55.32467;

  for (i = 0; i < sizeof(float); ++i)
  {
    Serial.write(c[i]);
  }

    x = 23.5372893;

  for (i = 0; i < sizeof(float); ++i)
  {
    Serial.write(c[i]);
  }
  Serial.write("\n");
  delay(2000);
  

}
