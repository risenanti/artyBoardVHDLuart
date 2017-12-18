#include <iostream>
#include <QtSerialPort>
#include <QStringList>
#include <QTextStream>
#include <QByteArray>
#include <vector>

using namespace std;

#define SERIALPORTNAME "/dev/ttyACM0"
#define SERIALBAUDRATE 9600

int main(void)
{
     //qstring to cout
     //QTextStream cout(stdout);
    QByteArray  inBits;

     QSerialPort m_serialPort;
     m_serialPort.setPortName(SERIALPORTNAME);
     m_serialPort.setBaudRate(SERIALBAUDRATE);

     if(!m_serialPort.open(QIODevice::ReadOnly)){
         cout << "ERROR CANNOT OPEN SERIAL PORT"<<endl;
    }

    cout << "Waiting for Data\n";
    for (int i = 0; i < 4; i++)
    {
        m_serialPort.waitForReadyRead(-1);

        inBits.append(m_serialPort.readAll());
    }
    m_serialPort.close();

    string conversionString = inBits.toStdString();

    int cursor = conversionString.find("\n");

    vector<unsigned char> tempChar;
    for (int i = cursor+1; i < conversionString.size(); ++i){
         tempChar.push_back(conversionString.at(i));
    }

    //rebuild floats
    vector<float> finalVar;
    //4 bytes in a float
    for (int i = 0; i < (tempChar.size()); i+=4){
        ////rebuild here
        float tempFloat = 0;
        for (int j = 3+i; j > -1+i; --j){

            if(j>tempChar.size()) break;

            unsigned char *c = (unsigned char *)&tempChar[j];
            *((unsigned char*)(&tempFloat) + (j-i)) = c[0];
        }
        cout<<tempFloat<<endl;
        finalVar.push_back(tempFloat);
    }

    return 0;
}
