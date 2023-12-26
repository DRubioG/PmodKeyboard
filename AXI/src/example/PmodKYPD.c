#include "PmodKYPD.h"

void enableKeyboard(){
    Xil_Out32(BASE_ADDDR, 0x01);
}

void disableKeyboard(){
    Xil_Out32(BASE_ADDDR, 0x00);
}

int getKeyboardValue(){
    float data = 0;
	data = Xil_In32(BASE_ADDDR+0x4);
    switch(data){
        case 0x0001:
            return 0;
        case 0x0002:
            return 1;
        case 0x0004:
            return 2;
        case 0x0008:
            return 3;
        case 0x0010:
            return 4;
        case 0x0020:
            return 5;
        case 0x0040:
            return 6;
        case 0x0080:
            return 7;
        case 0x0100:
            return 8;
        case 0x0200:
            return 9;
        case 0x0400:
            return 10;
        case 0x0800:
            return 11;
        case 0x1000:
            return 12;
        case 0x2000:
            return 13;
        case 0x4000:
            return 14;
        case 0x8000:
            return 15;
    }
}