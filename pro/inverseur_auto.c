
sbit LCD_RS at PORTD3_bit;
sbit LCD_EN at PORTD4_bit;
sbit LCD_D4 at PORTD5_bit;
sbit LCD_D5 at PORTD6_bit;
sbit LCD_D6 at PORTD7_bit;
sbit LCD_D7 at PORTB0_bit;

sbit LCD_RS_Direction at DDD3_bit;
sbit LCD_EN_Direction at DDD4_bit;
sbit LCD_D4_Direction at DDD5_bit;
sbit LCD_D5_Direction at DDD6_bit;
sbit LCD_D6_Direction at DDD7_bit;
sbit LCD_D7_Direction at DDB0_bit;

sbit SET at PIND.B0;
sbit B_MENU at PIND.B1;
sbit L at PIND.B0;
sbit H at PIND.B1;

sbit DEMAREUR at PORTB.B1;
sbit ELECTRO_VANNE at PORTB.B2;
sbit SUR_SECTEUR at PORTB.B3;
sbit SUR_GROUP at PORTB.B4;
sbit LED_FLASH at PORTB.B5;





const char *c_chaine[27] = {" __PARAMETTRES__", "Seuil bas      ", "Seuil haut     ", "  __DEMARREUR__",
"  __INVERSEUR__ ", "  ___TENSION___ ", "   __PHASES__   ", "Delay demarreur ", " INITIALISATION",
"HAGNAND INDUSTRY", "<< Retour       ", "Delay secteur   ", "Point zero      ", " Secteur   --Hz ",
" Group en marche", "Demarrage.......", "Arret en cour...", "Delay arret     ", " Echec demarrage",
"   POINT ZERO   ", "Delay groupe    ", "Activation      ", "Calibrage       ", "SECTOR ON",
" GROUP ON", "AUTO   ", "MANUEL "};

char m=0,m_timer=0, led_timer=0, set_led=0, v=255, frequence=0, cycle_aff=0, _aff=0,
 t_sect=0, t_group=0, t_arret=255, auto_=255, manual_=0;

char config=0;
void menu();
void delay(char t);
void m_Lcd_Out(char lin, char col, char index);
void demarrage();
void inverser(char i);
char start(); 
void system();

unsigned long int PHASE_SECT1=0, PHASE_SECT2=0, PHASE_SECT3=0, PHASE_GROUP1=0, angle=0;
char delay_extinsion = 0;
unsigned  int timer_defaut_sect=0, timer_defaut_group=0;

void led(){
        if(set_led==5 | m){
                LED_FLASH = led_timer.B5;
        }
        else if(set_led==4){
                LED_FLASH = led_timer.B3;
        }
        else if(set_led==3){
                LED_FLASH = led_timer.B2;
        }
        else if(set_led==2){
                LED_FLASH = led_timer.B1;
        }
        else if(set_led==0){
               LED_FLASH = 0;
        }
}

char counter=0;
char yz=0,hg=0;

void timer_0() iv IVT_ADDR_TIMER0_OVF ics ICS_AUTO {
       // m_timer++;
        led_timer++;
        if(m_timer>=31){
               // portd.b7 = !portd.b7;
               // m_timer=0;

        }
        /*
        if(timer_defaut_sect != 255 && timer_defaut_sect)
                timer_defaut_sect--;
        if(timer_defaut_group != 255 && timer_defaut_group)
                timer_defaut_group--; */
}

void interrupt_() iv IVT_ADDR_PCINT1 ics ICS_AUTO {
        if(PINC.B0 != hg.B0){
                yz++;
                hg=PINC;
                if(angle<11 || angle>15){
                // erreur phase
                }
               // angle = 0;
        } 
        if(PINC.B1 != hg.B1){
                hg=PINC;
                if(angle<5 || angle>8){
                // erreur phase
                }
               // angle = 0;
        }
}

unsigned long int tr2 = 0, milli=0;
void Timer2_() iv IVT_ADDR_TIMER2_OVF ics ICS_AUTO {
    TCNT2 = 131;
    tr2++; 
    angle++;
    if(tr2>=1000){   m_timer++;
       if(ELECTRO_VANNE)
          LED_FLASH = !LED_FLASH;
       else
          LED_FLASH = 0;
       frequence=yz/2;
       yz=0;
       delay_extinsion++;
       cycle_aff++;
       if(cycle_aff>=11)
       cycle_aff=0;
       if(t_sect && t_sect!=255)
           t_sect--;
       if(t_group && t_group!=255)
           t_group--;
       if(t_arret && t_arret != 255)
           t_arret--;
       tr2=0;
    }
    if(milli)
       milli--;
    if(timer_defaut_sect != 25500 && timer_defaut_sect)
            timer_defaut_sect--;
    if(timer_defaut_group != 25500 && timer_defaut_group)
            timer_defaut_group--;
}

char ordre_phase(){
    char txt[15];
    angle=0;
    while(PINC.b0 && angle<200);
    angle=0;
    while(!PINC.b0 && angle<50);
    angle=0;
    while(!PINC.b1 && angle<50);
    if(angle<5 || angle>8){ 
        Lcd_Out(1,1,"P1 >> P2        ");
        IntToStr(angle, txt);
        Lcd_Out(1,10,Ltrim(txt));
        delay_ms(1000);
        return 0;
    }
    angle=0;
    while(PINC.b1 && angle<50);
    while(!PINC.b0 && angle<50);
    if(angle<11 || angle>15){
        Lcd_Out(1,1,"P2 >> P3        ");
        IntToStr(angle, txt);
        Lcd_Out(1,10,Ltrim(txt));
        delay_ms(1000);
        return 0;
    }
    return 255;
}

char mesures(){
        char txt[15];
        unsigned long int calibre=0;
        PHASE_GROUP1=ADC_Read(5);
        PHASE_SECT1=ADC_Read(4);
        PHASE_SECT2=ADC_Read(2);
        PHASE_SECT3=ADC_Read(3);


        calibre = EEPROM_Read(33);
        calibre = calibre<<8;
        calibre = calibre + EEPROM_Read(34);
        txt[0]= EEPROM_Read(32);

        PHASE_GROUP1 = PHASE_GROUP1 * txt[0];
        PHASE_GROUP1 = PHASE_GROUP1/calibre;
        /*
        calibre = EEPROM_Read(37);
        calibre = calibre<<8;
        calibre = calibre + EEPROM_Read(38);
        txt[0]= EEPROM_Read(36);
        */
        PHASE_SECT1 = PHASE_SECT1 * txt[0];
        PHASE_SECT1 = PHASE_SECT1/calibre;

        PHASE_SECT2 = PHASE_SECT2 * txt[0];
        PHASE_SECT2 = PHASE_SECT2/calibre;

        PHASE_SECT3 = PHASE_SECT3 * txt[0];
        PHASE_SECT3 = PHASE_SECT3/calibre;

        if(_aff != cycle_aff && (timer_defaut_sect==25500 || timer_defaut_sect ==0) && t_arret>5){
                if(SUR_SECTEUR && !SUR_GROUP){
                        m_Lcd_Out(2, 1, 19);
                }
                else if(!SUR_SECTEUR && !SUR_GROUP){
                            m_Lcd_Out(2, 8, 23);
                    if(auto_)
                        m_Lcd_Out(2, 1, 25);
                    else
                        m_Lcd_Out(2, 1, 26);
                     if(cycle_aff.B1)
                         Lcd_Out(2,7,">");
                }
                else if(SUR_SECTEUR && SUR_GROUP){
                                m_Lcd_Out(2, 8, 24);
                    if(auto_)
                        m_Lcd_Out(2, 1, 25);
                    else
                        m_Lcd_Out(2, 1, 26);
                     if(cycle_aff.B1)
                         Lcd_Out(2,7,">");
                }
                _aff = cycle_aff;
        }
        
        if(cycle_aff==0){
                m_Lcd_Out(1, 1, 9);
                cycle_aff=1;
        }
        else if(cycle_aff==3){
                Lcd_Out(1,1,"SECT: V_   ");
                calibre = PHASE_SECT1 + PHASE_SECT2 + PHASE_SECT3;
                calibre = calibre/3;
                IntToStr(calibre, txt);
                Lcd_Out(1,9,Ltrim(txt));
                IntToStr(frequence, txt);
                Lcd_Out(1,12," 00Hz");
                Lcd_Out(1,13,Ltrim(txt));
                cycle_aff=4;
        }
        else if(cycle_aff==7){
                Lcd_Out(1,1,"GROUP: V_   ");
                IntToStr(PHASE_GROUP1, txt);
                Lcd_Out(1,10,Ltrim(txt));
                Lcd_Out(1,13,"    ");
                cycle_aff=8;
        }
        txt[0]= EEPROM_Read(30);
        txt[1]= EEPROM_Read(31);
        txt[2]= 0;
        txt[3]= 0;
        if(PHASE_SECT1 < txt[0]*10 || PHASE_SECT2 < txt[0]*10 || PHASE_SECT3 < txt[0]*10 || PHASE_SECT1 > txt[1]*10 || PHASE_SECT2 > txt[1]*10 || PHASE_SECT3 > txt[1]*10){

                if(timer_defaut_sect==25500){
                    timer_defaut_sect=EEPROM_Read(35)*100;
                    if(timer_defaut_sect==25500){
                        timer_defaut_sect = 20;
                        EEPROM_Write(35, timer_defaut_sect);
                        timer_defaut_sect *= 20;
                    }
                }
                txt[2]=timer_defaut_sect;
                if(txt[2].b7 != config.B7 && t_arret>5){
                    char time_out[15];
                    config.b7=txt[2].B7;
                    IntToStr(timer_defaut_sect, time_out);
                    Lcd_Out(2,1,"DEFAUT >>       ");
                    Lcd_Out(2,12,Ltrim(time_out));
                }
                txt[2]= 255;
        }
        else{
                timer_defaut_sect=25500;
        }
        if(PHASE_GROUP1 < txt[0]*10 || PHASE_GROUP1 > txt[1]*10){
                txt[3]= 255;
                if(timer_defaut_group==25500){
                  timer_defaut_group=EEPROM_Read(35)*100;
                  if(timer_defaut_group==25500){
                      timer_defaut_group = 2000;
                      EEPROM_Write(35, timer_defaut_group);
                  }
                  timer_defaut_group = timer_defaut_group/4;
                }
        }
        else{
                timer_defaut_group=25500;
        }
        
        
        if(txt[2] && txt[3] && !timer_defaut_sect && !timer_defaut_group){
                return 0;
        }
        else if(txt[2] && !timer_defaut_sect){
                return  1 ;
        }
        else if(txt[3] && !timer_defaut_group){
                return  2 ;
        }
        else{
           return  255 ;
        }
}

void delay(char t){
        led_timer = 0;
        SREG_I_bit = 1;
        while(t>0){
                if(led_timer>=30){
                        t--;
                        led_timer=0;
                }
        }
}

void delayms(char t){
    TCCR2B = 0b100;
    SREG_I_bit = 1;
    TIMSK2.TOIE0 = 1;
    milli = t*100;
    while(milli>0);
}

void main() {
        char x = 0;
        char txt[15];
        DDRB = 255;
        PORTB=0;
        LED_FLASH=1;
        DDRC = 0;
        portc=0b01000011;
        DDRD = 0;
        portd = 255;
        ADC_Init();
        Lcd_Init();

        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Cmd(_LCD_CURSOR_OFF);
        m_Lcd_Out(1, 1, 8);


        SREG_I_bit = 0;
        PCICR.PCIE1=1;
        PCMSK1=255;

        TCCR0B = 0b101;
        TIMSK0.TOIE0 = 1;

        TCCR2B = 0b100;
        TIMSK2.TOIE0 = 1;
		
		
        while(x<17){
           x++;
           Lcd_Out(2, x, ".");
           delay_ms(100);
        }
        
		if(EEPROM_Read(32)==255){
			EEPROM_Write(33, 602>>8);
			delay_ms(100);
			EEPROM_Write(34, 602);
			delay_ms(100);
			EEPROM_Write(32, 215);
			delay_ms(100);
		}
		
		
        auto_ = EEPROM_Read(30);
        if(auto_>240)
            EEPROM_Write(30, 100);
        auto_ = EEPROM_Read(31);
        if(auto_>240)
            EEPROM_Write(31, 240);
		
        Lcd_Cmd(_LCD_CLEAR);
        auto_ = EEPROM_Read(50);
        mesures();

        led_timer=200;
        LED_FLASH=0;       //auto_=0;
        system();
        timer_defaut_sect=0;
        timer_defaut_group=0;
        SUR_SECTEUR = 1;
        SUR_GROUP = 0;
        
        while(1){
                SREG_I_bit = 1;
                menu();   /*
                if(m_timer==5){
                    ordre_phase();
                    m_timer=0;
                }        */
                if(!SET && !m){ 
                        set_led=5;
                        led_timer=0;
                        while(!SET && led_timer<100)
                            LED_FLASH=1;
                        if(led_timer>=100){
                                auto_ = ~auto_;
                                if(auto_){/*
                                        t_sect = 255;
                                        t_group = 255;*/
                                }
                                EEPROM_Write(50, auto_);
                                if(auto_){
                                    Lcd_Out(2,1,"    MODE AUTO   ");
                                    config.b1 = 0;
                                }
                                else{
                                    Lcd_Out(2,1,"   MODE MANUEL  ");
                                    t_arret = 0;
                                }
                        }
                        else if(led_timer>=5 && !auto_){
                                if(!SUR_SECTEUR && !manual_){
                                        manual_=1;
                                        SUR_SECTEUR = 1;
                                        SUR_GROUP = 0;
                                    Lcd_Out(2,1,"   POINT ZERO   ");
                                }
                                else if(SUR_SECTEUR && !SUR_GROUP && manual_==1){
                                        manual_=0;
                                        SUR_SECTEUR = 1;
                                        SUR_GROUP = 1;
                                    Lcd_Out(2,1,"   SUR GROUPE   ");
                                }
                                else if(SUR_GROUP && !manual_){
                                        manual_=2;
                                        SUR_SECTEUR = 1;
                                        SUR_GROUP = 0;
                                    Lcd_Out(2,1,"   POINT ZERO   ");
                                }
                                else if(SUR_SECTEUR && !SUR_GROUP && manual_==2){
                                        manual_=0;
                                        SUR_GROUP = 0;
                                        SUR_SECTEUR = 0;
                                    Lcd_Out(2,1,"   SUR SECTEUR  ");
                                }
                                else{
                                        manual_=0;
                                        SUR_GROUP = 0;
                                        SUR_SECTEUR = 0;
                                    Lcd_Out(2,1,"   SUR SECTEUR  ");
                                }
                        }
                        else if(auto_){
                           Lcd_Out(2,1,"    MODE AUTO   ");
                        }
                        else
                           Lcd_Out(2,1,"   MODE MANUEL  ");
                        config.b1 = 0;
                        while(!SET);
                        delay_ms(2000);
                        set_led=0;
                }
                if(auto_ && !m){
                        inverser(3);
                }
                else if(!m)
                        mesures();
        }
}

void system(){
    char sys = 0, i = 0;
    delay_ms(200);
    sys = EEPROM_Read(100);
    while(H && !L && i<5){
       delay_ms(500);
       if(!H){
          sys = 230;
          i = 200;
       }
       LED_FLASH=!LED_FLASH;
       i++;
    }
    while(L && !H && i<5){
       delay_ms(500);
       if(!L){
          sys = 0;
          i = 200;
       }
       LED_FLASH=!LED_FLASH;
       i++;
    }
    LED_FLASH=1;
    if(sys<255){
        sys++;
        EEPROM_Write(100,sys);
    }
    else{
       Lcd_Cmd(_LCD_CLEAR);
       Lcd_Out(1, 1, " ERREUR SYSTEME!");
       Lcd_Out(2, 1, "________________");
       while(1);
    }
}

void demarrage(){
   char x = 3;
   PHASE_GROUP1=ADC_Read(5);
   while(PHASE_GROUP1<200 && x && !start()){
		if(!SET){
			x=0;
		}
		else{
			x--;
			delay(8);
			PHASE_GROUP1=ADC_Read(5);
		}
   }
   
   while(!SET)
	   LED_FLASH=1;
   
   if(!x){
      ELECTRO_VANNE = 0;
      config.b1 = 1;
      t_arret=255;
	  delayms(10);
   }
   else{
       t_arret=255;
   }
}

void inverser(char i){
        char xp = mesures();
        if(!xp && i==3 || !i){
                SUR_SECTEUR = 1;
                SUR_GROUP = 0;
                if(auto_ && !config.b1)
                    demarrage();
                t_sect=255;
                t_group=255;
        }
        else if(xp==1){
            t_sect=255;
            SUR_SECTEUR = 1;
        }
        else if(xp==2){
            t_group=255;
            SUR_GROUP = 0;
        }
        
        
        if(xp && xp !=  1 && !t_sect && i==3 || i==1){
                char x = EEPROM_Read(21);
                SUR_GROUP = 0;
                delayms(x);
                SUR_SECTEUR = 0;
                t_sect=255;
                config.b1 = 0;
                t_arret = EEPROM_Read(11);
                if(t_arret==255){
                   t_arret = 120;
                }
                system();
        }
        else if(xp && xp !=  2 &&  !t_group && i==3 || i==2){
                char x = EEPROM_Read(21);
                SUR_SECTEUR = 1;
                delayms(x);
                SUR_GROUP = 1;
                config.b1 = 0;
                t_group=255;
                t_arret=255;
        }
        else if(!SUR_GROUP && t_arret==255)
           t_arret = EEPROM_Read(11);
        
        if(xp && xp !=  1 && t_sect==255 && SUR_SECTEUR)
            t_sect=EEPROM_Read(20);
        else if((xp==1 || !xp) && t_sect != 255)
            t_sect=255;
        
        if(xp == 1 && t_group==255 && SUR_SECTEUR && !SUR_GROUP)
            t_group=EEPROM_Read(22);
        else if((xp==2 || !xp) && t_group != 255)
            t_group=255;
            
        if(t_arret<=5){
           char txt[5];
           m_Lcd_Out(2, 1, 16);
           ByteToStr(t_arret, txt);
           Lcd_Out(2,16,Ltrim(txt));
        }

        if(!t_arret){
          ELECTRO_VANNE=0;
          t_arret=255;
        }
}

void m_Lcd_Out(char lin, char col, char index){
        char i =0;
        for(i=0;c_chaine[index][i]!='\0';i++){
                Lcd_Chr(lin, col, c_chaine[index][i]);
                if(col<16)
                        col++;
        }
}


char start(){
     char tt = EEPROM_Read(1); 
     char x = 0;
	 if(!SET)
		return;
     set_led=4;
     m_Lcd_Out(1, 1, 9);
     m_Lcd_Out(2, 1, 15);

     ELECTRO_VANNE = 1;
     DEMAREUR = 1;
     delayms(tt);
     DEMAREUR = 0;

     delay(5);
     PHASE_GROUP1=ADC_Read(5);
     if(PHASE_GROUP1<200){
       DEMAREUR = 0;
       ELECTRO_VANNE = 1;
       m_Lcd_Out(2, 1, 18);
       led_timer = 0;
       set_led=3;
       return 0;
     }
     m_Lcd_Out(1, 1, 14); 
     delay(2);
     mesures();
     set_led=5;
     return 255;
}


void affiche(){
        if(m==0){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 9);
                mesures();
        }
        else if(m<6){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 0);
                if(m==1){
                Lcd_Out(2, 1, "Demarreur");
        }
        else if(m==2){
                Lcd_Out(2, 1, "Invertion auto  ");
        }
        else if(m==3){
                Lcd_Out(2, 1, "Seuil de tension");
        }
        else if(m==4){
                Lcd_Out(2, 1, "Ordre des phases");
        }
        else if(m==5){
                m_Lcd_Out(2, 1, 10);
        }
        }
        else if(m==10){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 3);
                m_Lcd_Out(2, 1, 7);
        }
        else if(m==11){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 3);
                m_Lcd_Out(2, 1, 17);
        }
        else if(m==12){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 3);
                m_Lcd_Out(2, 1, 10);
        }
        else if(m==13){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 3);
                m_Lcd_Out(2, 1, 21);
        }
        else if(m==20){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 4);
                m_Lcd_Out(2, 1, 11);
        }
        else if(m==21){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 4);
                m_Lcd_Out(2, 1, 12);
        }
        else if(m==22){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 4);
                m_Lcd_Out(2, 1, 20);
        }
        else if(m==23){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 4);
                m_Lcd_Out(2, 1, 10);
        }
        else if(m==30){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 5);
                m_Lcd_Out(2, 1, 1);
        }
        else if(m==31){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 5);
                m_Lcd_Out(2, 1, 2);
        }
        else if(m==32){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 5);
                m_Lcd_Out(2, 1, 22);
        }
        else if(m==33){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 5);
                Lcd_Out(2, 1, "Delay defaut    ");
        }
        else if(m==34){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 5);
                Lcd_Out(2, 1, "Calib sect     ");
        }
        else if(m==35){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 5);
                m_Lcd_Out(2, 1, 10);
        }
        else if(m==40){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 6);
                m_Lcd_Out(2, 1, 21);
        }
        else if(m==41){
                Lcd_Cmd(_LCD_CLEAR);
                m_Lcd_Out(1, 1, 6);
                m_Lcd_Out(2, 1, 10);
        }
}

void av(){
        char txt[4];
        ByteToStr(v, txt);
        Lcd_Out(2, 14, txt);

}

void setval(char mm){
	char txt[15];
        if(mm==32){
			PHASE_GROUP1 = ADC_Read(5);
			EEPROM_Write(33, PHASE_GROUP1>>8);
			EEPROM_Write(34, PHASE_GROUP1);
        }
        if(mm==34){
			PHASE_SECT1=ADC_Read(4);
			EEPROM_Write(37, PHASE_SECT1>>8);
			EEPROM_Write(38, PHASE_SECT1);
        }
        av();
		
		
		IntToStr(PHASE_GROUP1, txt);
		Lcd_Out(1,1,"      /         ");
		Lcd_Out(1,1,Ltrim(txt));
		
		IntToStr(v, txt);
		Lcd_Out(1,9,"     V  ");
		Lcd_Out(1,9,Ltrim(txt));
		delayms(20);
		
        EEPROM_Write(mm, v);
}
void getval(char mm){
        v = EEPROM_Read(mm);
        if(v>=255){
                v=0;
                delay_ms(100);
                EEPROM_Write(mm, v);
                delay_ms(100);
        }
        av();
}

void retour(char p){
        delay_extinsion=0;
        if(!p){
                if(m<10)
                        m = 0;
                        else{
                        m = m/10;
                }
        }
        V=255;
        affiche();
        while(!SET);
                delay_ms(200);
        led_timer=200;
}
void SET_menu(){
    if(m<10 && m>=6)
        m=1;
    else if(m<20 && m>12)
        m=10;
    else if(m<30 && m>=24)
        m=20;
    else if(m<40 && m>=36)
        m=30;
    else if(m<50 && m>=42)
        m=40;
    affiche();
    if(v!=255 && m==10){
        if(v>100)
            v=0;
        setval(1);
    }
    if(v!=255 && m==11){
        setval(2);
    }
    if(v!=255 && m<25){
        if(m==20){
            setval(20);
        }
        else if(m==21){
            setval(21);
        }
        else if(m==22){
            setval(22);
        }
    }
    if(v!=255 && m<35){
        if(m==30){
            setval(30);
        }
        else if(m==31){
            setval(31);
        }
        else if(m==32){
            setval(32);
        }
        else if(m==33){
            if(v>100)
               v=0;
            setval(35);
        }
        else if(m==34){
            setval(36);
        }
    }
    if(v!=255 && m<45){
        if(m==40){
            if(v>1)
                v=0;
            setval(40);
        }
    }
}

void menu(){
    if(!B_MENU){
        led_timer=0;
        while((!B_MENU && !m && led_timer<62) | (!B_MENU && led_timer<5));
        if((!B_MENU && !m && led_timer>=62) | (!B_MENU && led_timer>=5 && m)){
            delay_extinsion=0;
            if(v != 255){
                                milli=1000;
                while(!B_MENU && milli);
                if(milli){
                     v++;
                    if(v >= 254)
                       v=0;
                    SET_menu();
                }
                while(!B_MENU && !milli){
                   v = v +10;
                   if(v >= 254)
                       v=0;
                   SET_menu();
                   delay_ms(500);
                }
            }
            else{
                m++;
                SET_menu();
                while(!B_MENU && m==1 && v==255);
            }

        }
    }


    if(!SET && v==255 && m){
        led_timer=0;
        while(!SET && led_timer<5);
        if(!SET && led_timer>=5 && m){
            char d=0;
            delay_extinsion=0;
            if(m==5){
                    retour(0);
            }
            else if(m<9){
                    m = m *10;
                    affiche();
            }
            else if(m==10)
                    getval(1);
            else if(m==11)
                    getval(2);
            else if(m==12)
                    retour(0);
            else if(m==20){
                    getval(20);
            }
            else if(m==21){
                    getval(21);
            }
            else if(m==22){
                    getval(22);
            }
            else if(m==23){
                    retour(0);
            }
            else if(m==30){
                    getval(30);
            }
            else if(m==31){
                    getval(31);
            }
            else if(m==32){
                    getval(32);
            }
            else if(m==33){
                    getval(35);
            }
            else if(m==34){
                 getval(36);
            }
            else if(m==35){
                    retour(0);
            }
            else if(m==40){
                    getval(40);
            }
            else if(m==41){
                    retour(0);
            }
        }
        while(!SET);
                delay_ms(200);
    }
    if(!SET && m && v!=255){
        retour(1);
    }
}