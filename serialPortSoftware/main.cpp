#include <iostream>
#include <QtWidgets>
#include <QObject>
#include <QDebug>
#include <QCoreApplication>
#include <QtSerialPort>
#include <QTextStream>
#include <QTimer>
#include <QByteArray>
#include <QApplication>

using namespace std;

int main(int argc, char *argv[])
{
     QSerialPort m_serialPort;
     QByteArray  inBits;
     QString output;
     QTextStream cout(stdout);
     
     m_serialPort.setPortName("tty/USB0");
     m_serialPort.setBaudRate(9600);
     
     static int i = 0;
     
     if(!m_serialPort.open(QIODevice::ReadOnly)){
		 cout<<"ERROR CANNOT OPEN SERIAL PORT"<<endl;
	 }
     
     if (m_serialPort.waitForReadyRead(10)) {
				// read request
				inBits = m_serialPort.readAll();
				while (m_serialPort.waitForReadyRead(10))
				   { 
					inBits += m_serialPort.readAll();
					i++;
					if(i>12) break;
				}
			}
			output = inBits.data();
			cout<<output<<endl;

    return 0;
}
