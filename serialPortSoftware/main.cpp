#include <iostream>
#include <QCoreApplication>
#include <QtSerialPort>
#include <QStringList>
#include <QTextStream>
#include <QTimer>
#include <QByteArray>

using namespace std;

#define SERIALPORTNAME "/dev/ttyACM0"
#define SERIALBAUDRATE 9600

int main(int argc, char *argv[])
{
     //qstring to cout
     //QTextStream cout(stdout);

     QSerialPort m_serialPort;
     QByteArray  inBits;

     m_serialPort.setPortName(SERIALPORTNAME);
     m_serialPort.setBaudRate(SERIALBAUDRATE);

     static int i = 0;

     if(!m_serialPort.open(QIODevice::ReadOnly)){
         cout << "ERROR CANNOT OPEN SERIAL PORT"<<endl;
    }

    cout << "Waiting for Data\n";

    // read request
    inBits = m_serialPort.readAll();
    while (m_serialPort.waitForReadyRead(3000))
       {
        inBits.append(m_serialPort.readAll());
        i++;
        if(i>8) break;
    }
    m_serialPort.close();
    
    string conversionString = inBits.toStdString();

    return 0;
}

//µRI@RI@vL]B^L¼A\nµRI@vL]B^L¼A\nµRI@vL]B^L¼A\n
