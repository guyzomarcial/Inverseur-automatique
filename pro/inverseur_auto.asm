
_led:

;inverseur_auto.c,54 :: 		void led(){
;inverseur_auto.c,55 :: 		if(set_led==5 | m){
	LDS        R16, _set_led+0
	CPI        R16, 5
	LDI        R17, 0
	BRNE       L__led680
	LDI        R17, 1
L__led680:
	LDS        R16, _m+0
	OR         R16, R17
	BRNE       L__led681
	JMP        L_led0
L__led681:
;inverseur_auto.c,56 :: 		LED_FLASH = led_timer.B5;
	LDS        R27, _led_timer+0
	BST        R27, 5
	IN         R27, PORTB+0
	BLD        R27, 5
	OUT        PORTB+0, R27
;inverseur_auto.c,57 :: 		}
	JMP        L_led1
L_led0:
;inverseur_auto.c,58 :: 		else if(set_led==4){
	LDS        R16, _set_led+0
	CPI        R16, 4
	BREQ       L__led682
	JMP        L_led2
L__led682:
;inverseur_auto.c,59 :: 		LED_FLASH = led_timer.B3;
	LDS        R27, _led_timer+0
	BST        R27, 3
	IN         R27, PORTB+0
	BLD        R27, 5
	OUT        PORTB+0, R27
;inverseur_auto.c,60 :: 		}
	JMP        L_led3
L_led2:
;inverseur_auto.c,61 :: 		else if(set_led==3){
	LDS        R16, _set_led+0
	CPI        R16, 3
	BREQ       L__led683
	JMP        L_led4
L__led683:
;inverseur_auto.c,62 :: 		LED_FLASH = led_timer.B2;
	LDS        R27, _led_timer+0
	BST        R27, 2
	IN         R27, PORTB+0
	BLD        R27, 5
	OUT        PORTB+0, R27
;inverseur_auto.c,63 :: 		}
	JMP        L_led5
L_led4:
;inverseur_auto.c,64 :: 		else if(set_led==2){
	LDS        R16, _set_led+0
	CPI        R16, 2
	BREQ       L__led684
	JMP        L_led6
L__led684:
;inverseur_auto.c,65 :: 		LED_FLASH = led_timer.B1;
	LDS        R27, _led_timer+0
	BST        R27, 1
	IN         R27, PORTB+0
	BLD        R27, 5
	OUT        PORTB+0, R27
;inverseur_auto.c,66 :: 		}
	JMP        L_led7
L_led6:
;inverseur_auto.c,67 :: 		else if(set_led==0){
	LDS        R16, _set_led+0
	CPI        R16, 0
	BREQ       L__led685
	JMP        L_led8
L__led685:
;inverseur_auto.c,68 :: 		LED_FLASH = 0;
	IN         R27, PORTB+0
	CBR        R27, 32
	OUT        PORTB+0, R27
;inverseur_auto.c,69 :: 		}
L_led8:
L_led7:
L_led5:
L_led3:
L_led1:
;inverseur_auto.c,70 :: 		}
L_end_led:
	RET
; end of _led

_timer_0:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;inverseur_auto.c,75 :: 		void timer_0() iv IVT_ADDR_TIMER0_OVF ics ICS_AUTO {
;inverseur_auto.c,77 :: 		led_timer++;
	LDS        R16, _led_timer+0
	SUBI       R16, 255
	STS        _led_timer+0, R16
;inverseur_auto.c,78 :: 		if(m_timer>=31){
	LDS        R16, _m_timer+0
	CPI        R16, 31
	BRSH       L__timer_0687
	JMP        L_timer_09
L__timer_0687:
;inverseur_auto.c,82 :: 		}
L_timer_09:
;inverseur_auto.c,88 :: 		}
L_end_timer_0:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _timer_0

_interrupt_:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;inverseur_auto.c,90 :: 		void interrupt_() iv IVT_ADDR_PCINT1 ics ICS_AUTO {
;inverseur_auto.c,91 :: 		if(PINC.B0 != hg.B0){
	IN         R1, PINC+0
	LDS        R0, _hg+0
	BST        R0, 0
	SBRC       R1, 0
	RJMP       L__interrupt_691
	BRTC       L__interrupt_690
L__interrupt_689:
	RJMP       L__interrupt_692
L__interrupt_691:
	BRTC       L__interrupt_689
L__interrupt_690:
	JMP        L_interrupt_10
L__interrupt_692:
;inverseur_auto.c,92 :: 		yz++;
	LDS        R16, _yz+0
	SUBI       R16, 255
	STS        _yz+0, R16
;inverseur_auto.c,93 :: 		hg=PINC;
	IN         R16, PINC+0
	STS        _hg+0, R16
;inverseur_auto.c,94 :: 		if(angle<11 || angle>15){
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__interrupt_693
	CPI        R18, 0
	BRNE       L__interrupt_693
	CPI        R17, 0
	BRNE       L__interrupt_693
	CPI        R16, 11
L__interrupt_693:
	BRSH       L__interrupt_694
	JMP        L__interrupt_463
L__interrupt_694:
	LDS        R20, _angle+0
	LDS        R21, _angle+1
	LDS        R22, _angle+2
	LDS        R23, _angle+3
	LDI        R16, 15
	LDI        R17, 0
	LDI        R18, 0
	LDI        R19, 0
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__interrupt_695
	JMP        L__interrupt_462
L__interrupt_695:
	JMP        L_interrupt_13
L__interrupt_463:
L__interrupt_462:
;inverseur_auto.c,96 :: 		}
L_interrupt_13:
;inverseur_auto.c,98 :: 		}
L_interrupt_10:
;inverseur_auto.c,99 :: 		if(PINC.B1 != hg.B1){
	IN         R1, PINC+0
	LDS        R0, _hg+0
	BST        R0, 1
	SBRC       R1, 1
	RJMP       L__interrupt_698
	BRTC       L__interrupt_697
L__interrupt_696:
	RJMP       L__interrupt_699
L__interrupt_698:
	BRTC       L__interrupt_696
L__interrupt_697:
	JMP        L_interrupt_14
L__interrupt_699:
;inverseur_auto.c,100 :: 		hg=PINC;
	IN         R16, PINC+0
	STS        _hg+0, R16
;inverseur_auto.c,101 :: 		if(angle<5 || angle>8){
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__interrupt_700
	CPI        R18, 0
	BRNE       L__interrupt_700
	CPI        R17, 0
	BRNE       L__interrupt_700
	CPI        R16, 5
L__interrupt_700:
	BRSH       L__interrupt_701
	JMP        L__interrupt_465
L__interrupt_701:
	LDS        R20, _angle+0
	LDS        R21, _angle+1
	LDS        R22, _angle+2
	LDS        R23, _angle+3
	LDI        R16, 8
	LDI        R17, 0
	LDI        R18, 0
	LDI        R19, 0
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__interrupt_702
	JMP        L__interrupt_464
L__interrupt_702:
	JMP        L_interrupt_17
L__interrupt_465:
L__interrupt_464:
;inverseur_auto.c,103 :: 		}
L_interrupt_17:
;inverseur_auto.c,105 :: 		}
L_interrupt_14:
;inverseur_auto.c,106 :: 		}
L_end_interrupt_:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _interrupt_

_Timer2_:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;inverseur_auto.c,109 :: 		void Timer2_() iv IVT_ADDR_TIMER2_OVF ics ICS_AUTO {
;inverseur_auto.c,110 :: 		TCNT2 = 131;
	LDI        R27, 131
	STS        TCNT2+0, R27
;inverseur_auto.c,111 :: 		tr2++;
	LDS        R16, _tr2+0
	LDS        R17, _tr2+1
	LDS        R18, _tr2+2
	LDS        R19, _tr2+3
	MOVW       R20, R16
	MOVW       R22, R18
	SUBI       R20, 255
	SBCI       R21, 255
	SBCI       R22, 255
	SBCI       R23, 255
	STS        _tr2+0, R20
	STS        _tr2+1, R21
	STS        _tr2+2, R22
	STS        _tr2+3, R23
;inverseur_auto.c,112 :: 		angle++;
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	SUBI       R16, 255
	SBCI       R17, 255
	SBCI       R18, 255
	SBCI       R19, 255
	STS        _angle+0, R16
	STS        _angle+1, R17
	STS        _angle+2, R18
	STS        _angle+3, R19
;inverseur_auto.c,113 :: 		if(tr2>=1000){   m_timer++;
	CPI        R23, 0
	BRNE       L__Timer2_704
	CPI        R22, 0
	BRNE       L__Timer2_704
	CPI        R21, 3
	BRNE       L__Timer2_704
	CPI        R20, 232
L__Timer2_704:
	BRSH       L__Timer2_705
	JMP        L_Timer2_18
L__Timer2_705:
	LDS        R16, _m_timer+0
	SUBI       R16, 255
	STS        _m_timer+0, R16
;inverseur_auto.c,114 :: 		if(ELECTRO_VANNE)
	IN         R27, PORTB+0
	SBRS       R27, 2
	JMP        L_Timer2_19
;inverseur_auto.c,115 :: 		LED_FLASH = !LED_FLASH;
	IN         R0, PORTB+0
	LDI        R27, 32
	EOR        R0, R27
	OUT        PORTB+0, R0
	JMP        L_Timer2_20
L_Timer2_19:
;inverseur_auto.c,117 :: 		LED_FLASH = 0;
	IN         R27, PORTB+0
	CBR        R27, 32
	OUT        PORTB+0, R27
L_Timer2_20:
;inverseur_auto.c,118 :: 		frequence=yz/2;
	LDS        R16, _yz+0
	LSR        R16
	STS        _frequence+0, R16
;inverseur_auto.c,119 :: 		yz=0;
	LDI        R27, 0
	STS        _yz+0, R27
;inverseur_auto.c,120 :: 		delay_extinsion++;
	LDS        R16, _delay_extinsion+0
	SUBI       R16, 255
	STS        _delay_extinsion+0, R16
;inverseur_auto.c,121 :: 		cycle_aff++;
	LDS        R16, _cycle_aff+0
	SUBI       R16, 255
	STS        _cycle_aff+0, R16
;inverseur_auto.c,122 :: 		if(cycle_aff>=11)
	CPI        R16, 11
	BRSH       L__Timer2_708
	JMP        L_Timer2_21
L__Timer2_708:
;inverseur_auto.c,123 :: 		cycle_aff=0;
	LDI        R27, 0
	STS        _cycle_aff+0, R27
L_Timer2_21:
;inverseur_auto.c,124 :: 		if(t_sect && t_sect!=255)
	LDS        R16, _t_sect+0
	TST        R16
	BRNE       L__Timer2_709
	JMP        L__Timer2_472
L__Timer2_709:
	LDS        R16, _t_sect+0
	CPI        R16, 255
	BRNE       L__Timer2_710
	JMP        L__Timer2_471
L__Timer2_710:
L__Timer2_470:
;inverseur_auto.c,125 :: 		t_sect--;
	LDS        R16, _t_sect+0
	SUBI       R16, 1
	STS        _t_sect+0, R16
;inverseur_auto.c,124 :: 		if(t_sect && t_sect!=255)
L__Timer2_472:
L__Timer2_471:
;inverseur_auto.c,126 :: 		if(t_group && t_group!=255)
	LDS        R16, _t_group+0
	TST        R16
	BRNE       L__Timer2_711
	JMP        L__Timer2_474
L__Timer2_711:
	LDS        R16, _t_group+0
	CPI        R16, 255
	BRNE       L__Timer2_712
	JMP        L__Timer2_473
L__Timer2_712:
L__Timer2_469:
;inverseur_auto.c,127 :: 		t_group--;
	LDS        R16, _t_group+0
	SUBI       R16, 1
	STS        _t_group+0, R16
;inverseur_auto.c,126 :: 		if(t_group && t_group!=255)
L__Timer2_474:
L__Timer2_473:
;inverseur_auto.c,128 :: 		if(t_arret && t_arret != 255)
	LDS        R16, _t_arret+0
	TST        R16
	BRNE       L__Timer2_713
	JMP        L__Timer2_476
L__Timer2_713:
	LDS        R16, _t_arret+0
	CPI        R16, 255
	BRNE       L__Timer2_714
	JMP        L__Timer2_475
L__Timer2_714:
L__Timer2_468:
;inverseur_auto.c,129 :: 		t_arret--;
	LDS        R16, _t_arret+0
	SUBI       R16, 1
	STS        _t_arret+0, R16
;inverseur_auto.c,128 :: 		if(t_arret && t_arret != 255)
L__Timer2_476:
L__Timer2_475:
;inverseur_auto.c,130 :: 		tr2=0;
	LDI        R27, 0
	STS        _tr2+0, R27
	STS        _tr2+1, R27
	STS        _tr2+2, R27
	STS        _tr2+3, R27
;inverseur_auto.c,131 :: 		}
L_Timer2_18:
;inverseur_auto.c,132 :: 		if(milli)
	LDS        R16, _milli+0
	LDS        R17, _milli+1
	LDS        R18, _milli+2
	LDS        R19, _milli+3
	MOV        R27, R16
	OR         R27, R17
	OR         R27, R18
	OR         R27, R19
	BRNE       L__Timer2_715
	JMP        L_Timer2_31
L__Timer2_715:
;inverseur_auto.c,133 :: 		milli--;
	LDS        R16, _milli+0
	LDS        R17, _milli+1
	LDS        R18, _milli+2
	LDS        R19, _milli+3
	SUBI       R16, 1
	SBCI       R17, 0
	SBCI       R18, 0
	SBCI       R19, 0
	STS        _milli+0, R16
	STS        _milli+1, R17
	STS        _milli+2, R18
	STS        _milli+3, R19
L_Timer2_31:
;inverseur_auto.c,134 :: 		if(timer_defaut_sect != 25500 && timer_defaut_sect)
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	CPI        R17, 99
	BRNE       L__Timer2_716
	CPI        R16, 156
L__Timer2_716:
	BRNE       L__Timer2_717
	JMP        L__Timer2_478
L__Timer2_717:
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__Timer2_718
	JMP        L__Timer2_477
L__Timer2_718:
L__Timer2_467:
;inverseur_auto.c,135 :: 		timer_defaut_sect--;
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _timer_defaut_sect+0, R16
	STS        _timer_defaut_sect+1, R17
;inverseur_auto.c,134 :: 		if(timer_defaut_sect != 25500 && timer_defaut_sect)
L__Timer2_478:
L__Timer2_477:
;inverseur_auto.c,136 :: 		if(timer_defaut_group != 25500 && timer_defaut_group)
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	CPI        R17, 99
	BRNE       L__Timer2_719
	CPI        R16, 156
L__Timer2_719:
	BRNE       L__Timer2_720
	JMP        L__Timer2_480
L__Timer2_720:
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__Timer2_721
	JMP        L__Timer2_479
L__Timer2_721:
L__Timer2_466:
;inverseur_auto.c,137 :: 		timer_defaut_group--;
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _timer_defaut_group+0, R16
	STS        _timer_defaut_group+1, R17
;inverseur_auto.c,136 :: 		if(timer_defaut_group != 25500 && timer_defaut_group)
L__Timer2_480:
L__Timer2_479:
;inverseur_auto.c,138 :: 		}
L_end_Timer2_:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer2_

_ordre_phase:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 15
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,140 :: 		char ordre_phase(){
;inverseur_auto.c,142 :: 		angle=0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 0
	STS        _angle+0, R27
	STS        _angle+1, R27
	STS        _angle+2, R27
	STS        _angle+3, R27
;inverseur_auto.c,143 :: 		while(PINC.b0 && angle<200);
L_ordre_phase38:
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__ordre_phase489
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase723
	CPI        R18, 0
	BRNE       L__ordre_phase723
	CPI        R17, 0
	BRNE       L__ordre_phase723
	CPI        R16, 200
L__ordre_phase723:
	BRLO       L__ordre_phase724
	JMP        L__ordre_phase488
L__ordre_phase724:
L__ordre_phase487:
	JMP        L_ordre_phase38
L__ordre_phase489:
L__ordre_phase488:
;inverseur_auto.c,144 :: 		angle=0;
	LDI        R27, 0
	STS        _angle+0, R27
	STS        _angle+1, R27
	STS        _angle+2, R27
	STS        _angle+3, R27
;inverseur_auto.c,145 :: 		while(!PINC.b0 && angle<50);
L_ordre_phase42:
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__ordre_phase491
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase725
	CPI        R18, 0
	BRNE       L__ordre_phase725
	CPI        R17, 0
	BRNE       L__ordre_phase725
	CPI        R16, 50
L__ordre_phase725:
	BRLO       L__ordre_phase726
	JMP        L__ordre_phase490
L__ordre_phase726:
L__ordre_phase486:
	JMP        L_ordre_phase42
L__ordre_phase491:
L__ordre_phase490:
;inverseur_auto.c,146 :: 		angle=0;
	LDI        R27, 0
	STS        _angle+0, R27
	STS        _angle+1, R27
	STS        _angle+2, R27
	STS        _angle+3, R27
;inverseur_auto.c,147 :: 		while(!PINC.b1 && angle<50);
L_ordre_phase46:
	IN         R27, PINC+0
	SBRC       R27, 1
	JMP        L__ordre_phase493
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase727
	CPI        R18, 0
	BRNE       L__ordre_phase727
	CPI        R17, 0
	BRNE       L__ordre_phase727
	CPI        R16, 50
L__ordre_phase727:
	BRLO       L__ordre_phase728
	JMP        L__ordre_phase492
L__ordre_phase728:
L__ordre_phase485:
	JMP        L_ordre_phase46
L__ordre_phase493:
L__ordre_phase492:
;inverseur_auto.c,148 :: 		if(angle<5 || angle>8){
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase729
	CPI        R18, 0
	BRNE       L__ordre_phase729
	CPI        R17, 0
	BRNE       L__ordre_phase729
	CPI        R16, 5
L__ordre_phase729:
	BRSH       L__ordre_phase730
	JMP        L__ordre_phase495
L__ordre_phase730:
	LDS        R20, _angle+0
	LDS        R21, _angle+1
	LDS        R22, _angle+2
	LDS        R23, _angle+3
	LDI        R16, 8
	LDI        R17, 0
	LDI        R18, 0
	LDI        R19, 0
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__ordre_phase731
	JMP        L__ordre_phase494
L__ordre_phase731:
	JMP        L_ordre_phase52
L__ordre_phase495:
L__ordre_phase494:
;inverseur_auto.c,149 :: 		Lcd_Out(1,1,"P1 >> P2        ");
	LDI        R27, #lo_addr(?lstr28_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr28_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,150 :: 		IntToStr(angle, txt);
	MOVW       R16, R28
	MOVW       R4, R16
	LDS        R2, _angle+0
	LDS        R3, _angle+1
	CALL       _IntToStr+0
;inverseur_auto.c,151 :: 		Lcd_Out(1,10,Ltrim(txt));
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,152 :: 		delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_ordre_phase53:
	DEC        R16
	BRNE       L_ordre_phase53
	DEC        R17
	BRNE       L_ordre_phase53
	DEC        R18
	BRNE       L_ordre_phase53
;inverseur_auto.c,153 :: 		return 0;
	LDI        R16, 0
	JMP        L_end_ordre_phase
;inverseur_auto.c,154 :: 		}
L_ordre_phase52:
;inverseur_auto.c,155 :: 		angle=0;
	LDI        R27, 0
	STS        _angle+0, R27
	STS        _angle+1, R27
	STS        _angle+2, R27
	STS        _angle+3, R27
;inverseur_auto.c,156 :: 		while(PINC.b1 && angle<50);
L_ordre_phase55:
	IN         R27, PINC+0
	SBRS       R27, 1
	JMP        L__ordre_phase497
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase732
	CPI        R18, 0
	BRNE       L__ordre_phase732
	CPI        R17, 0
	BRNE       L__ordre_phase732
	CPI        R16, 50
L__ordre_phase732:
	BRLO       L__ordre_phase733
	JMP        L__ordre_phase496
L__ordre_phase733:
L__ordre_phase483:
	JMP        L_ordre_phase55
L__ordre_phase497:
L__ordre_phase496:
;inverseur_auto.c,157 :: 		while(!PINC.b0 && angle<50);
L_ordre_phase59:
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__ordre_phase499
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase734
	CPI        R18, 0
	BRNE       L__ordre_phase734
	CPI        R17, 0
	BRNE       L__ordre_phase734
	CPI        R16, 50
L__ordre_phase734:
	BRLO       L__ordre_phase735
	JMP        L__ordre_phase498
L__ordre_phase735:
L__ordre_phase482:
	JMP        L_ordre_phase59
L__ordre_phase499:
L__ordre_phase498:
;inverseur_auto.c,158 :: 		if(angle<11 || angle>15){
	LDS        R16, _angle+0
	LDS        R17, _angle+1
	LDS        R18, _angle+2
	LDS        R19, _angle+3
	CPI        R19, 0
	BRNE       L__ordre_phase736
	CPI        R18, 0
	BRNE       L__ordre_phase736
	CPI        R17, 0
	BRNE       L__ordre_phase736
	CPI        R16, 11
L__ordre_phase736:
	BRSH       L__ordre_phase737
	JMP        L__ordre_phase501
L__ordre_phase737:
	LDS        R20, _angle+0
	LDS        R21, _angle+1
	LDS        R22, _angle+2
	LDS        R23, _angle+3
	LDI        R16, 15
	LDI        R17, 0
	LDI        R18, 0
	LDI        R19, 0
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__ordre_phase738
	JMP        L__ordre_phase500
L__ordre_phase738:
	JMP        L_ordre_phase65
L__ordre_phase501:
L__ordre_phase500:
;inverseur_auto.c,159 :: 		Lcd_Out(1,1,"P2 >> P3        ");
	LDI        R27, #lo_addr(?lstr29_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr29_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,160 :: 		IntToStr(angle, txt);
	MOVW       R16, R28
	MOVW       R4, R16
	LDS        R2, _angle+0
	LDS        R3, _angle+1
	CALL       _IntToStr+0
;inverseur_auto.c,161 :: 		Lcd_Out(1,10,Ltrim(txt));
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,162 :: 		delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_ordre_phase66:
	DEC        R16
	BRNE       L_ordre_phase66
	DEC        R17
	BRNE       L_ordre_phase66
	DEC        R18
	BRNE       L_ordre_phase66
;inverseur_auto.c,163 :: 		return 0;
	LDI        R16, 0
	JMP        L_end_ordre_phase
;inverseur_auto.c,164 :: 		}
L_ordre_phase65:
;inverseur_auto.c,165 :: 		return 255;
	LDI        R16, 255
;inverseur_auto.c,166 :: 		}
;inverseur_auto.c,165 :: 		return 255;
;inverseur_auto.c,166 :: 		}
L_end_ordre_phase:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 14
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ordre_phase

_mesures:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 32
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,168 :: 		char mesures(){
;inverseur_auto.c,170 :: 		unsigned long int calibre=0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
;inverseur_auto.c,171 :: 		PHASE_GROUP1=ADC_Read(5);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	LDI        R27, 0
	STS        _PHASE_GROUP1+2, R27
	STS        _PHASE_GROUP1+3, R27
;inverseur_auto.c,172 :: 		PHASE_SECT1=ADC_Read(4);
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_SECT1+0, R16
	STS        _PHASE_SECT1+1, R17
	LDI        R27, 0
	STS        _PHASE_SECT1+2, R27
	STS        _PHASE_SECT1+3, R27
;inverseur_auto.c,173 :: 		PHASE_SECT2=ADC_Read(2);
	LDI        R27, 2
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_SECT2+0, R16
	STS        _PHASE_SECT2+1, R17
	LDI        R27, 0
	STS        _PHASE_SECT2+2, R27
	STS        _PHASE_SECT2+3, R27
;inverseur_auto.c,174 :: 		PHASE_SECT3=ADC_Read(3);
	LDI        R27, 3
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_SECT3+0, R16
	STS        _PHASE_SECT3+1, R17
	LDI        R27, 0
	STS        _PHASE_SECT3+2, R27
	STS        _PHASE_SECT3+3, R27
;inverseur_auto.c,177 :: 		calibre = EEPROM_Read(33);
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
; calibre start address is: 20 (R20)
	MOV        R20, R16
	LDI        R21, 0
	MOV        R22, R21
	MOV        R23, R21
;inverseur_auto.c,178 :: 		calibre = calibre<<8;
	MOV        R19, R22
	MOV        R18, R21
	MOV        R17, R20
	CLR        R16
	MOVW       R20, R16
	MOVW       R22, R18
;inverseur_auto.c,179 :: 		calibre = calibre + EEPROM_Read(34);
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	ADD        R16, R20
	ADC        R17, R21
	ADC        R18, R22
	ADC        R19, R23
	MOVW       R20, R16
	MOVW       R22, R18
;inverseur_auto.c,180 :: 		txt[0]= EEPROM_Read(32);
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	STD        Y+30, R16
	STD        Y+31, R17
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	LDD        R17, Y+30
	LDD        R18, Y+31
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;inverseur_auto.c,182 :: 		PHASE_GROUP1 = PHASE_GROUP1 * txt[0];
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	STD        Y+30, R16
	STD        Y+31, R17
	MOVW       R30, R16
	LD         R16, Z
	PUSH       R23
	PUSH       R22
	PUSH       R21
	PUSH       R20
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	LDS        R20, _PHASE_GROUP1+0
	LDS        R21, _PHASE_GROUP1+1
	LDS        R22, _PHASE_GROUP1+2
	LDS        R23, _PHASE_GROUP1+3
	CALL       _HWMul_32x32+0
	POP        R20
	POP        R21
	POP        R22
	POP        R23
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	STS        _PHASE_GROUP1+2, R18
	STS        _PHASE_GROUP1+3, R19
;inverseur_auto.c,183 :: 		PHASE_GROUP1 = PHASE_GROUP1/calibre;
	PUSH       R23
	PUSH       R22
	PUSH       R21
	PUSH       R20
	CALL       _Div_32x32_U+0
	MOVW       R16, R22
	MOVW       R18, R24
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	STS        _PHASE_GROUP1+2, R18
	STS        _PHASE_GROUP1+3, R19
;inverseur_auto.c,190 :: 		PHASE_SECT1 = PHASE_SECT1 * txt[0];
	LDD        R30, Y+30
	LDD        R31, Y+31
	LD         R16, Z
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	LDS        R20, _PHASE_SECT1+0
	LDS        R21, _PHASE_SECT1+1
	LDS        R22, _PHASE_SECT1+2
	LDS        R23, _PHASE_SECT1+3
	CALL       _HWMul_32x32+0
	POP        R20
	POP        R21
	POP        R22
	POP        R23
	STS        _PHASE_SECT1+0, R16
	STS        _PHASE_SECT1+1, R17
	STS        _PHASE_SECT1+2, R18
	STS        _PHASE_SECT1+3, R19
;inverseur_auto.c,191 :: 		PHASE_SECT1 = PHASE_SECT1/calibre;
	PUSH       R23
	PUSH       R22
	PUSH       R21
	PUSH       R20
	CALL       _Div_32x32_U+0
	MOVW       R16, R22
	MOVW       R18, R24
	STS        _PHASE_SECT1+0, R16
	STS        _PHASE_SECT1+1, R17
	STS        _PHASE_SECT1+2, R18
	STS        _PHASE_SECT1+3, R19
;inverseur_auto.c,193 :: 		PHASE_SECT2 = PHASE_SECT2 * txt[0];
	LDD        R30, Y+30
	LDD        R31, Y+31
	LD         R16, Z
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	LDS        R20, _PHASE_SECT2+0
	LDS        R21, _PHASE_SECT2+1
	LDS        R22, _PHASE_SECT2+2
	LDS        R23, _PHASE_SECT2+3
	CALL       _HWMul_32x32+0
	POP        R20
	POP        R21
	POP        R22
	POP        R23
	STS        _PHASE_SECT2+0, R16
	STS        _PHASE_SECT2+1, R17
	STS        _PHASE_SECT2+2, R18
	STS        _PHASE_SECT2+3, R19
;inverseur_auto.c,194 :: 		PHASE_SECT2 = PHASE_SECT2/calibre;
	PUSH       R23
	PUSH       R22
	PUSH       R21
	PUSH       R20
	CALL       _Div_32x32_U+0
	MOVW       R16, R22
	MOVW       R18, R24
	STS        _PHASE_SECT2+0, R16
	STS        _PHASE_SECT2+1, R17
	STS        _PHASE_SECT2+2, R18
	STS        _PHASE_SECT2+3, R19
;inverseur_auto.c,196 :: 		PHASE_SECT3 = PHASE_SECT3 * txt[0];
	LDD        R30, Y+30
	LDD        R31, Y+31
	LD         R16, Z
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	LDS        R20, _PHASE_SECT3+0
	LDS        R21, _PHASE_SECT3+1
	LDS        R22, _PHASE_SECT3+2
	LDS        R23, _PHASE_SECT3+3
	CALL       _HWMul_32x32+0
	POP        R20
	POP        R21
	POP        R22
	POP        R23
	STS        _PHASE_SECT3+0, R16
	STS        _PHASE_SECT3+1, R17
	STS        _PHASE_SECT3+2, R18
	STS        _PHASE_SECT3+3, R19
;inverseur_auto.c,197 :: 		PHASE_SECT3 = PHASE_SECT3/calibre;
	CALL       _Div_32x32_U+0
	MOVW       R16, R22
	MOVW       R18, R24
; calibre end address is: 20 (R20)
	STS        _PHASE_SECT3+0, R16
	STS        _PHASE_SECT3+1, R17
	STS        _PHASE_SECT3+2, R18
	STS        _PHASE_SECT3+3, R19
;inverseur_auto.c,199 :: 		if(_aff != cycle_aff && (timer_defaut_sect==25500 || timer_defaut_sect ==0) && t_arret>5){
	LDS        R17, __aff+0
	LDS        R16, _cycle_aff+0
	CP         R17, R16
	BRNE       L__mesures740
	JMP        L__mesures522
L__mesures740:
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	CPI        R17, 99
	BRNE       L__mesures741
	CPI        R16, 156
L__mesures741:
	BRNE       L__mesures742
	JMP        L__mesures514
L__mesures742:
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	CPI        R17, 0
	BRNE       L__mesures743
	CPI        R16, 0
L__mesures743:
	BRNE       L__mesures744
	JMP        L__mesures513
L__mesures744:
	JMP        L_mesures72
L__mesures514:
L__mesures513:
	LDS        R17, _t_arret+0
	LDI        R16, 5
	CP         R16, R17
	BRLO       L__mesures745
	JMP        L__mesures521
L__mesures745:
L__mesures511:
;inverseur_auto.c,200 :: 		if(SUR_SECTEUR && !SUR_GROUP){
	IN         R27, PORTB+0
	SBRS       R27, 3
	JMP        L__mesures516
	IN         R27, PORTB+0
	SBRC       R27, 4
	JMP        L__mesures515
L__mesures510:
;inverseur_auto.c,201 :: 		m_Lcd_Out(2, 1, 19);
	LDI        R27, 19
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,202 :: 		}
	JMP        L_mesures76
;inverseur_auto.c,200 :: 		if(SUR_SECTEUR && !SUR_GROUP){
L__mesures516:
L__mesures515:
;inverseur_auto.c,203 :: 		else if(!SUR_SECTEUR && !SUR_GROUP){
	IN         R27, PORTB+0
	SBRC       R27, 3
	JMP        L__mesures518
	IN         R27, PORTB+0
	SBRC       R27, 4
	JMP        L__mesures517
L__mesures509:
;inverseur_auto.c,204 :: 		m_Lcd_Out(2, 8, 23);
	LDI        R27, 23
	MOV        R4, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,205 :: 		if(auto_)
	LDS        R16, _auto_+0
	TST        R16
	BRNE       L__mesures746
	JMP        L_mesures80
L__mesures746:
;inverseur_auto.c,206 :: 		m_Lcd_Out(2, 1, 25);
	LDI        R27, 25
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
	JMP        L_mesures81
L_mesures80:
;inverseur_auto.c,208 :: 		m_Lcd_Out(2, 1, 26);
	LDI        R27, 26
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
L_mesures81:
;inverseur_auto.c,209 :: 		if(cycle_aff.B1)
	LDS        R27, _cycle_aff+0
	SBRS       R27, 1
	JMP        L_mesures82
;inverseur_auto.c,210 :: 		Lcd_Out(2,7,">");
	LDI        R27, #lo_addr(?lstr30_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr30_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_mesures82:
;inverseur_auto.c,211 :: 		}
	JMP        L_mesures83
;inverseur_auto.c,203 :: 		else if(!SUR_SECTEUR && !SUR_GROUP){
L__mesures518:
L__mesures517:
;inverseur_auto.c,212 :: 		else if(SUR_SECTEUR && SUR_GROUP){
	IN         R27, PORTB+0
	SBRS       R27, 3
	JMP        L__mesures520
	IN         R27, PORTB+0
	SBRS       R27, 4
	JMP        L__mesures519
L__mesures508:
;inverseur_auto.c,213 :: 		m_Lcd_Out(2, 8, 24);
	LDI        R27, 24
	MOV        R4, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,214 :: 		if(auto_)
	LDS        R16, _auto_+0
	TST        R16
	BRNE       L__mesures747
	JMP        L_mesures87
L__mesures747:
;inverseur_auto.c,215 :: 		m_Lcd_Out(2, 1, 25);
	LDI        R27, 25
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
	JMP        L_mesures88
L_mesures87:
;inverseur_auto.c,217 :: 		m_Lcd_Out(2, 1, 26);
	LDI        R27, 26
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
L_mesures88:
;inverseur_auto.c,218 :: 		if(cycle_aff.B1)
	LDS        R27, _cycle_aff+0
	SBRS       R27, 1
	JMP        L_mesures89
;inverseur_auto.c,219 :: 		Lcd_Out(2,7,">");
	LDI        R27, #lo_addr(?lstr31_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr31_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_mesures89:
;inverseur_auto.c,212 :: 		else if(SUR_SECTEUR && SUR_GROUP){
L__mesures520:
L__mesures519:
;inverseur_auto.c,220 :: 		}
L_mesures83:
L_mesures76:
;inverseur_auto.c,221 :: 		_aff = cycle_aff;
	LDS        R16, _cycle_aff+0
	STS        __aff+0, R16
;inverseur_auto.c,222 :: 		}
L_mesures72:
;inverseur_auto.c,199 :: 		if(_aff != cycle_aff && (timer_defaut_sect==25500 || timer_defaut_sect ==0) && t_arret>5){
L__mesures522:
L__mesures521:
;inverseur_auto.c,224 :: 		if(cycle_aff==0){
	LDS        R16, _cycle_aff+0
	CPI        R16, 0
	BREQ       L__mesures748
	JMP        L_mesures90
L__mesures748:
;inverseur_auto.c,225 :: 		m_Lcd_Out(1, 1, 9);
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,226 :: 		cycle_aff=1;
	LDI        R27, 1
	STS        _cycle_aff+0, R27
;inverseur_auto.c,227 :: 		}
	JMP        L_mesures91
L_mesures90:
;inverseur_auto.c,228 :: 		else if(cycle_aff==3){
	LDS        R16, _cycle_aff+0
	CPI        R16, 3
	BREQ       L__mesures749
	JMP        L_mesures92
L__mesures749:
;inverseur_auto.c,229 :: 		Lcd_Out(1,1,"SECT: V_   ");
	LDI        R27, #lo_addr(?lstr32_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr32_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,230 :: 		calibre = PHASE_SECT1 + PHASE_SECT2 + PHASE_SECT3;
	LDS        R20, _PHASE_SECT1+0
	LDS        R21, _PHASE_SECT1+1
	LDS        R22, _PHASE_SECT1+2
	LDS        R23, _PHASE_SECT1+3
	LDS        R16, _PHASE_SECT2+0
	LDS        R17, _PHASE_SECT2+1
	LDS        R18, _PHASE_SECT2+2
	LDS        R19, _PHASE_SECT2+3
	ADD        R20, R16
	ADC        R21, R17
	ADC        R22, R18
	ADC        R23, R19
	LDS        R16, _PHASE_SECT3+0
	LDS        R17, _PHASE_SECT3+1
	LDS        R18, _PHASE_SECT3+2
	LDS        R19, _PHASE_SECT3+3
	ADD        R16, R20
	ADC        R17, R21
	ADC        R18, R22
	ADC        R19, R23
;inverseur_auto.c,231 :: 		calibre = calibre/3;
	LDI        R20, 3
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	CALL       _Div_32x32_U+0
	MOVW       R16, R22
	MOVW       R18, R24
;inverseur_auto.c,232 :: 		IntToStr(calibre, txt);
	MOVW       R20, R28
	SUBI       R20, 241
	SBCI       R21, 255
	MOVW       R4, R20
	MOVW       R2, R16
	CALL       _IntToStr+0
;inverseur_auto.c,233 :: 		Lcd_Out(1,9,Ltrim(txt));
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,234 :: 		IntToStr(frequence, txt);
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R4, R16
	LDS        R2, _frequence+0
	LDI        R27, 0
	MOV        R3, R27
	CALL       _IntToStr+0
;inverseur_auto.c,235 :: 		Lcd_Out(1,12," 00Hz");
	LDI        R27, #lo_addr(?lstr33_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr33_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,236 :: 		Lcd_Out(1,13,Ltrim(txt));
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,237 :: 		cycle_aff=4;
	LDI        R27, 4
	STS        _cycle_aff+0, R27
;inverseur_auto.c,238 :: 		}
	JMP        L_mesures93
L_mesures92:
;inverseur_auto.c,239 :: 		else if(cycle_aff==7){
	LDS        R16, _cycle_aff+0
	CPI        R16, 7
	BREQ       L__mesures750
	JMP        L_mesures94
L__mesures750:
;inverseur_auto.c,240 :: 		Lcd_Out(1,1,"GROUP: V_   ");
	LDI        R27, #lo_addr(?lstr34_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,241 :: 		IntToStr(PHASE_GROUP1, txt);
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R4, R16
	LDS        R2, _PHASE_GROUP1+0
	LDS        R3, _PHASE_GROUP1+1
	CALL       _IntToStr+0
;inverseur_auto.c,242 :: 		Lcd_Out(1,10,Ltrim(txt));
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,243 :: 		Lcd_Out(1,13,"    ");
	LDI        R27, #lo_addr(?lstr35_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr35_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,244 :: 		cycle_aff=8;
	LDI        R27, 8
	STS        _cycle_aff+0, R27
;inverseur_auto.c,245 :: 		}
L_mesures94:
L_mesures93:
L_mesures91:
;inverseur_auto.c,246 :: 		txt[0]= EEPROM_Read(30);
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	STD        Y+30, R16
	STD        Y+31, R17
	LDI        R27, 30
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	LDD        R17, Y+30
	LDD        R18, Y+31
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;inverseur_auto.c,247 :: 		txt[1]= EEPROM_Read(31);
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+30, R16
	STD        Y+31, R17
	LDI        R27, 31
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	LDD        R17, Y+30
	LDD        R18, Y+31
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;inverseur_auto.c,248 :: 		txt[2]= 0;
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LDI        R27, 0
	ST         Z, R27
;inverseur_auto.c,249 :: 		txt[3]= 0;
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 3
	LDI        R27, 0
	ST         Z, R27
;inverseur_auto.c,250 :: 		if(PHASE_SECT1 < txt[0]*10 || PHASE_SECT2 < txt[0]*10 || PHASE_SECT3 < txt[0]*10 || PHASE_SECT1 > txt[1]*10 || PHASE_SECT2 > txt[1]*10 || PHASE_SECT3 > txt[1]*10){
	MOVW       R30, R28
	ADIW       R30, 15
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R20, R0
	LDS        R16, _PHASE_SECT1+0
	LDS        R17, _PHASE_SECT1+1
	LDS        R18, _PHASE_SECT1+2
	LDS        R19, _PHASE_SECT1+3
	CP         R16, R20
	CPC        R17, R21
	LDI        R27, 0
	SBRC       R21, 7
	LDI        R27, 255
	CPC        R18, R27
	CPC        R19, R27
	BRSH       L__mesures751
	JMP        L__mesures528
L__mesures751:
	MOVW       R30, R28
	ADIW       R30, 15
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R20, R0
	LDS        R16, _PHASE_SECT2+0
	LDS        R17, _PHASE_SECT2+1
	LDS        R18, _PHASE_SECT2+2
	LDS        R19, _PHASE_SECT2+3
	CP         R16, R20
	CPC        R17, R21
	LDI        R27, 0
	SBRC       R21, 7
	LDI        R27, 255
	CPC        R18, R27
	CPC        R19, R27
	BRSH       L__mesures752
	JMP        L__mesures527
L__mesures752:
	MOVW       R30, R28
	ADIW       R30, 15
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R20, R0
	LDS        R16, _PHASE_SECT3+0
	LDS        R17, _PHASE_SECT3+1
	LDS        R18, _PHASE_SECT3+2
	LDS        R19, _PHASE_SECT3+3
	CP         R16, R20
	CPC        R17, R21
	LDI        R27, 0
	SBRC       R21, 7
	LDI        R27, 255
	CPC        R18, R27
	CPC        R19, R27
	BRSH       L__mesures753
	JMP        L__mesures526
L__mesures753:
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 1
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R16, R0
	LDS        R20, _PHASE_SECT1+0
	LDS        R21, _PHASE_SECT1+1
	LDS        R22, _PHASE_SECT1+2
	LDS        R23, _PHASE_SECT1+3
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__mesures754
	JMP        L__mesures525
L__mesures754:
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 1
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R16, R0
	LDS        R20, _PHASE_SECT2+0
	LDS        R21, _PHASE_SECT2+1
	LDS        R22, _PHASE_SECT2+2
	LDS        R23, _PHASE_SECT2+3
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__mesures755
	JMP        L__mesures524
L__mesures755:
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 1
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R16, R0
	LDS        R20, _PHASE_SECT3+0
	LDS        R21, _PHASE_SECT3+1
	LDS        R22, _PHASE_SECT3+2
	LDS        R23, _PHASE_SECT3+3
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__mesures756
	JMP        L__mesures523
L__mesures756:
	JMP        L_mesures97
L__mesures528:
L__mesures527:
L__mesures526:
L__mesures525:
L__mesures524:
L__mesures523:
;inverseur_auto.c,252 :: 		if(timer_defaut_sect==25500){
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	CPI        R17, 99
	BRNE       L__mesures757
	CPI        R16, 156
L__mesures757:
	BREQ       L__mesures758
	JMP        L_mesures98
L__mesures758:
;inverseur_auto.c,253 :: 		timer_defaut_sect=EEPROM_Read(35)*100;
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	LDI        R17, 100
	MUL        R16, R17
	MOVW       R16, R0
	STS        _timer_defaut_sect+0, R16
	STS        _timer_defaut_sect+1, R17
;inverseur_auto.c,254 :: 		if(timer_defaut_sect==25500){
	CPI        R17, 99
	BRNE       L__mesures759
	CPI        R16, 156
L__mesures759:
	BREQ       L__mesures760
	JMP        L_mesures99
L__mesures760:
;inverseur_auto.c,255 :: 		timer_defaut_sect = 20;
	LDI        R27, 20
	STS        _timer_defaut_sect+0, R27
	LDI        R27, 0
	STS        _timer_defaut_sect+1, R27
;inverseur_auto.c,256 :: 		EEPROM_Write(35, timer_defaut_sect);
	LDI        R27, 20
	MOV        R4, R27
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,257 :: 		timer_defaut_sect *= 20;
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	LDI        R20, 20
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	STS        _timer_defaut_sect+0, R16
	STS        _timer_defaut_sect+1, R17
;inverseur_auto.c,258 :: 		}
L_mesures99:
;inverseur_auto.c,259 :: 		}
L_mesures98:
;inverseur_auto.c,260 :: 		txt[2]=timer_defaut_sect;
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LDS        R16, _timer_defaut_sect+0
	ST         Z, R16
;inverseur_auto.c,261 :: 		if(txt[2].b7 != config.B7 && t_arret>5){
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R16, Z
	LDS        R0, _config+0
	BST        R0, 7
	SBRC       R16, 7
	RJMP       L__mesures763
	BRTC       L__mesures762
L__mesures761:
	RJMP       L__mesures764
L__mesures763:
	BRTC       L__mesures761
L__mesures762:
	JMP        L__mesures530
L__mesures764:
	LDS        R17, _t_arret+0
	LDI        R16, 5
	CP         R16, R17
	BRLO       L__mesures765
	JMP        L__mesures529
L__mesures765:
L__mesures506:
;inverseur_auto.c,263 :: 		config.b7=txt[2].B7;
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R16, Z
	BST        R16, 7
	LDS        R27, _config+0
	BLD        R27, 7
	STS        _config+0, R27
;inverseur_auto.c,264 :: 		IntToStr(timer_defaut_sect, time_out);
	MOVW       R16, R28
	MOVW       R4, R16
	LDS        R2, _timer_defaut_sect+0
	LDS        R3, _timer_defaut_sect+1
	CALL       _IntToStr+0
;inverseur_auto.c,265 :: 		Lcd_Out(2,1,"DEFAUT >>       ");
	LDI        R27, #lo_addr(?lstr36_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr36_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,266 :: 		Lcd_Out(2,12,Ltrim(time_out));
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,261 :: 		if(txt[2].b7 != config.B7 && t_arret>5){
L__mesures530:
L__mesures529:
;inverseur_auto.c,268 :: 		txt[2]= 255;
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LDI        R27, 255
	ST         Z, R27
;inverseur_auto.c,269 :: 		}
	JMP        L_mesures103
L_mesures97:
;inverseur_auto.c,271 :: 		timer_defaut_sect=25500;
	LDI        R27, 156
	STS        _timer_defaut_sect+0, R27
	LDI        R27, 99
	STS        _timer_defaut_sect+1, R27
;inverseur_auto.c,272 :: 		}
L_mesures103:
;inverseur_auto.c,273 :: 		if(PHASE_GROUP1 < txt[0]*10 || PHASE_GROUP1 > txt[1]*10){
	MOVW       R30, R28
	ADIW       R30, 15
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R20, R0
	LDS        R16, _PHASE_GROUP1+0
	LDS        R17, _PHASE_GROUP1+1
	LDS        R18, _PHASE_GROUP1+2
	LDS        R19, _PHASE_GROUP1+3
	CP         R16, R20
	CPC        R17, R21
	LDI        R27, 0
	SBRC       R21, 7
	LDI        R27, 255
	CPC        R18, R27
	CPC        R19, R27
	BRSH       L__mesures766
	JMP        L__mesures532
L__mesures766:
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 1
	LD         R17, Z
	LDI        R16, 10
	MUL        R17, R16
	MOVW       R16, R0
	LDS        R20, _PHASE_GROUP1+0
	LDS        R21, _PHASE_GROUP1+1
	LDS        R22, _PHASE_GROUP1+2
	LDS        R23, _PHASE_GROUP1+3
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRSH       L__mesures767
	JMP        L__mesures531
L__mesures767:
	JMP        L_mesures106
L__mesures532:
L__mesures531:
;inverseur_auto.c,274 :: 		txt[3]= 255;
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 3
	LDI        R27, 255
	ST         Z, R27
;inverseur_auto.c,275 :: 		if(timer_defaut_group==25500){
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	CPI        R17, 99
	BRNE       L__mesures768
	CPI        R16, 156
L__mesures768:
	BREQ       L__mesures769
	JMP        L_mesures107
L__mesures769:
;inverseur_auto.c,276 :: 		timer_defaut_group=EEPROM_Read(35)*100;
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	LDI        R17, 100
	MUL        R16, R17
	MOVW       R16, R0
	STS        _timer_defaut_group+0, R16
	STS        _timer_defaut_group+1, R17
;inverseur_auto.c,277 :: 		if(timer_defaut_group==25500){
	CPI        R17, 99
	BRNE       L__mesures770
	CPI        R16, 156
L__mesures770:
	BREQ       L__mesures771
	JMP        L_mesures108
L__mesures771:
;inverseur_auto.c,278 :: 		timer_defaut_group = 2000;
	LDI        R27, 208
	STS        _timer_defaut_group+0, R27
	LDI        R27, 7
	STS        _timer_defaut_group+1, R27
;inverseur_auto.c,279 :: 		EEPROM_Write(35, timer_defaut_group);
	LDI        R27, 208
	MOV        R4, R27
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,280 :: 		}
L_mesures108:
;inverseur_auto.c,281 :: 		timer_defaut_group = timer_defaut_group/4;
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	LSR        R17
	ROR        R16
	LSR        R17
	ROR        R16
	STS        _timer_defaut_group+0, R16
	STS        _timer_defaut_group+1, R17
;inverseur_auto.c,282 :: 		}
L_mesures107:
;inverseur_auto.c,283 :: 		}
	JMP        L_mesures109
L_mesures106:
;inverseur_auto.c,285 :: 		timer_defaut_group=25500;
	LDI        R27, 156
	STS        _timer_defaut_group+0, R27
	LDI        R27, 99
	STS        _timer_defaut_group+1, R27
;inverseur_auto.c,286 :: 		}
L_mesures109:
;inverseur_auto.c,289 :: 		if(txt[2] && txt[3] && !timer_defaut_sect && !timer_defaut_group){
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R16, Z
	TST        R16
	BRNE       L__mesures772
	JMP        L__mesures536
L__mesures772:
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R16, Z
	TST        R16
	BRNE       L__mesures773
	JMP        L__mesures535
L__mesures773:
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__mesures774
	JMP        L__mesures534
L__mesures774:
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__mesures775
	JMP        L__mesures533
L__mesures775:
L__mesures504:
;inverseur_auto.c,290 :: 		return 0;
	LDI        R16, 0
	JMP        L_end_mesures
;inverseur_auto.c,289 :: 		if(txt[2] && txt[3] && !timer_defaut_sect && !timer_defaut_group){
L__mesures536:
L__mesures535:
L__mesures534:
L__mesures533:
;inverseur_auto.c,292 :: 		else if(txt[2] && !timer_defaut_sect){
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R16, Z
	TST        R16
	BRNE       L__mesures776
	JMP        L__mesures538
L__mesures776:
	LDS        R16, _timer_defaut_sect+0
	LDS        R17, _timer_defaut_sect+1
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__mesures777
	JMP        L__mesures537
L__mesures777:
L__mesures503:
;inverseur_auto.c,293 :: 		return  1 ;
	LDI        R16, 1
	JMP        L_end_mesures
;inverseur_auto.c,292 :: 		else if(txt[2] && !timer_defaut_sect){
L__mesures538:
L__mesures537:
;inverseur_auto.c,295 :: 		else if(txt[3] && !timer_defaut_group){
	MOVW       R16, R28
	SUBI       R16, 241
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 3
	LD         R16, Z
	TST        R16
	BRNE       L__mesures778
	JMP        L__mesures540
L__mesures778:
	LDS        R16, _timer_defaut_group+0
	LDS        R17, _timer_defaut_group+1
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__mesures779
	JMP        L__mesures539
L__mesures779:
L__mesures502:
;inverseur_auto.c,296 :: 		return  2 ;
	LDI        R16, 2
	JMP        L_end_mesures
;inverseur_auto.c,295 :: 		else if(txt[3] && !timer_defaut_group){
L__mesures540:
L__mesures539:
;inverseur_auto.c,299 :: 		return  255 ;
	LDI        R16, 255
;inverseur_auto.c,301 :: 		}
;inverseur_auto.c,299 :: 		return  255 ;
;inverseur_auto.c,301 :: 		}
L_end_mesures:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 31
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _mesures

_delay:

;inverseur_auto.c,303 :: 		void delay(char t){
;inverseur_auto.c,304 :: 		led_timer = 0;
	LDI        R27, 0
	STS        _led_timer+0, R27
;inverseur_auto.c,305 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;inverseur_auto.c,306 :: 		while(t>0){
L_delay122:
	LDI        R16, 0
	CP         R16, R2
	BRLO       L__delay781
	JMP        L_delay123
L__delay781:
;inverseur_auto.c,307 :: 		if(led_timer>=30){
	LDS        R16, _led_timer+0
	CPI        R16, 30
	BRSH       L__delay782
	JMP        L_delay124
L__delay782:
;inverseur_auto.c,308 :: 		t--;
	MOV        R16, R2
	SUBI       R16, 1
	MOV        R2, R16
;inverseur_auto.c,309 :: 		led_timer=0;
	LDI        R27, 0
	STS        _led_timer+0, R27
;inverseur_auto.c,310 :: 		}
L_delay124:
;inverseur_auto.c,311 :: 		}
	JMP        L_delay122
L_delay123:
;inverseur_auto.c,312 :: 		}
L_end_delay:
	RET
; end of _delay

_delayms:

;inverseur_auto.c,314 :: 		void delayms(char t){
;inverseur_auto.c,315 :: 		TCCR2B = 0b100;
	LDI        R27, 4
	STS        TCCR2B+0, R27
;inverseur_auto.c,316 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;inverseur_auto.c,317 :: 		TIMSK2.TOIE0 = 1;
	LDS        R27, TIMSK2+0
	SBR        R27, 1
	STS        TIMSK2+0, R27
;inverseur_auto.c,318 :: 		milli = t*100;
	LDI        R16, 100
	MUL        R2, R16
	MOVW       R16, R0
	STS        _milli+0, R16
	STS        _milli+1, R17
	LDI        R27, 0
	SBRC       R17, 7
	LDI        R27, 255
	STS        _milli+2, R27
	STS        _milli+3, R27
;inverseur_auto.c,319 :: 		while(milli>0);
L_delayms125:
	LDS        R20, _milli+0
	LDS        R21, _milli+1
	LDS        R22, _milli+2
	LDS        R23, _milli+3
	LDI        R16, 0
	LDI        R17, 0
	LDI        R18, 0
	LDI        R19, 0
	CP         R16, R20
	CPC        R17, R21
	CPC        R18, R22
	CPC        R19, R23
	BRLO       L__delayms784
	JMP        L_delayms126
L__delayms784:
	JMP        L_delayms125
L_delayms126:
;inverseur_auto.c,320 :: 		}
L_end_delayms:
	RET
; end of _delayms

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;inverseur_auto.c,322 :: 		void main() {
;inverseur_auto.c,323 :: 		char x = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
; x start address is: 17 (R17)
	LDI        R17, 0
;inverseur_auto.c,325 :: 		DDRB = 255;
	LDI        R27, 255
	OUT        DDRB+0, R27
;inverseur_auto.c,326 :: 		PORTB=0;
	LDI        R27, 0
	OUT        PORTB+0, R27
;inverseur_auto.c,327 :: 		LED_FLASH=1;
	IN         R27, PORTB+0
	SBR        R27, 32
	OUT        PORTB+0, R27
;inverseur_auto.c,328 :: 		DDRC = 0;
	LDI        R27, 0
	OUT        DDRC+0, R27
;inverseur_auto.c,329 :: 		portc=0b01000011;
	LDI        R27, 67
	OUT        PORTC+0, R27
;inverseur_auto.c,330 :: 		DDRD = 0;
	LDI        R27, 0
	OUT        DDRD+0, R27
;inverseur_auto.c,331 :: 		portd = 255;
	LDI        R27, 255
	OUT        PORTD+0, R27
;inverseur_auto.c,332 :: 		ADC_Init();
	CALL       _ADC_Init+0
;inverseur_auto.c,333 :: 		Lcd_Init();
	PUSH       R17
	CALL       _Lcd_Init+0
;inverseur_auto.c,335 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,336 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,337 :: 		m_Lcd_Out(1, 1, 8);
	LDI        R27, 8
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
	POP        R17
;inverseur_auto.c,340 :: 		SREG_I_bit = 0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;inverseur_auto.c,341 :: 		PCICR.PCIE1=1;
	LDS        R27, PCICR+0
	SBR        R27, 2
	STS        PCICR+0, R27
;inverseur_auto.c,342 :: 		PCMSK1=255;
	LDI        R27, 255
	STS        PCMSK1+0, R27
;inverseur_auto.c,344 :: 		TCCR0B = 0b101;
	LDI        R27, 5
	OUT        TCCR0B+0, R27
;inverseur_auto.c,345 :: 		TIMSK0.TOIE0 = 1;
	LDS        R27, TIMSK0+0
	SBR        R27, 1
	STS        TIMSK0+0, R27
;inverseur_auto.c,347 :: 		TCCR2B = 0b100;
	LDI        R27, 4
	STS        TCCR2B+0, R27
;inverseur_auto.c,348 :: 		TIMSK2.TOIE0 = 1;
	LDS        R27, TIMSK2+0
	SBR        R27, 1
	STS        TIMSK2+0, R27
; x end address is: 17 (R17)
;inverseur_auto.c,351 :: 		while(x<17){
L_main127:
; x start address is: 17 (R17)
	CPI        R17, 17
	BRLO       L__main786
	JMP        L_main128
L__main786:
;inverseur_auto.c,352 :: 		x++;
	MOV        R16, R17
	SUBI       R16, 255
	MOV        R17, R16
;inverseur_auto.c,353 :: 		Lcd_Out(2, x, ".");
	PUSH       R17
	LDI        R27, #lo_addr(?lstr37_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr37_inverseur_auto+0)
	MOV        R5, R27
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,354 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main129:
	DEC        R16
	BRNE       L_main129
	DEC        R17
	BRNE       L_main129
	DEC        R18
	BRNE       L_main129
	POP        R17
;inverseur_auto.c,355 :: 		}
; x end address is: 17 (R17)
	JMP        L_main127
L_main128:
;inverseur_auto.c,357 :: 		if(EEPROM_Read(32)==255){
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	CPI        R16, 255
	BREQ       L__main787
	JMP        L_main131
L__main787:
;inverseur_auto.c,358 :: 		EEPROM_Write(33, 602>>8);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,359 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main132:
	DEC        R16
	BRNE       L_main132
	DEC        R17
	BRNE       L_main132
	DEC        R18
	BRNE       L_main132
;inverseur_auto.c,360 :: 		EEPROM_Write(34, 602);
	LDI        R27, 90
	MOV        R4, R27
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,361 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main134:
	DEC        R16
	BRNE       L_main134
	DEC        R17
	BRNE       L_main134
	DEC        R18
	BRNE       L_main134
;inverseur_auto.c,362 :: 		EEPROM_Write(32, 215);
	LDI        R27, 215
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,363 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main136:
	DEC        R16
	BRNE       L_main136
	DEC        R17
	BRNE       L_main136
	DEC        R18
	BRNE       L_main136
;inverseur_auto.c,364 :: 		}
L_main131:
;inverseur_auto.c,367 :: 		auto_ = EEPROM_Read(30);
	LDI        R27, 30
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _auto_+0, R16
;inverseur_auto.c,368 :: 		if(auto_>240)
	LDI        R17, 240
	CP         R17, R16
	BRLO       L__main788
	JMP        L_main138
L__main788:
;inverseur_auto.c,369 :: 		EEPROM_Write(30, 100);
	LDI        R27, 100
	MOV        R4, R27
	LDI        R27, 30
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_main138:
;inverseur_auto.c,370 :: 		auto_ = EEPROM_Read(31);
	LDI        R27, 31
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _auto_+0, R16
;inverseur_auto.c,371 :: 		if(auto_>240)
	LDI        R17, 240
	CP         R17, R16
	BRLO       L__main789
	JMP        L_main139
L__main789:
;inverseur_auto.c,372 :: 		EEPROM_Write(31, 240);
	LDI        R27, 240
	MOV        R4, R27
	LDI        R27, 31
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_main139:
;inverseur_auto.c,374 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,375 :: 		auto_ = EEPROM_Read(50);
	LDI        R27, 50
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _auto_+0, R16
;inverseur_auto.c,376 :: 		mesures();
	CALL       _mesures+0
;inverseur_auto.c,378 :: 		led_timer=200;
	LDI        R27, 200
	STS        _led_timer+0, R27
;inverseur_auto.c,379 :: 		LED_FLASH=0;       //auto_=0;
	IN         R27, PORTB+0
	CBR        R27, 32
	OUT        PORTB+0, R27
;inverseur_auto.c,380 :: 		system();
	CALL       _system+0
;inverseur_auto.c,381 :: 		timer_defaut_sect=0;
	LDI        R27, 0
	STS        _timer_defaut_sect+0, R27
	STS        _timer_defaut_sect+1, R27
;inverseur_auto.c,382 :: 		timer_defaut_group=0;
	LDI        R27, 0
	STS        _timer_defaut_group+0, R27
	STS        _timer_defaut_group+1, R27
;inverseur_auto.c,383 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,384 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,386 :: 		while(1){
L_main140:
;inverseur_auto.c,387 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;inverseur_auto.c,392 :: 		}        */
	CALL       _menu+0
;inverseur_auto.c,393 :: 		if(!SET && !m){
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__main676
	LDS        R16, _m+0
	TST        R16
	BREQ       L__main790
	JMP        L__main675
L__main790:
L__main660:
;inverseur_auto.c,394 :: 		set_led=5;
	LDI        R27, 5
	STS        _set_led+0, R27
;inverseur_auto.c,395 :: 		led_timer=0;
	LDI        R27, 0
	STS        _led_timer+0, R27
;inverseur_auto.c,396 :: 		while(!SET && led_timer<100)
L_main145:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__main662
	LDS        R16, _led_timer+0
	CPI        R16, 100
	BRLO       L__main791
	JMP        L__main661
L__main791:
L__main659:
;inverseur_auto.c,397 :: 		LED_FLASH=1;
	IN         R27, PORTB+0
	SBR        R27, 32
	OUT        PORTB+0, R27
	JMP        L_main145
;inverseur_auto.c,396 :: 		while(!SET && led_timer<100)
L__main662:
L__main661:
;inverseur_auto.c,398 :: 		if(led_timer>=100){
	LDS        R16, _led_timer+0
	CPI        R16, 100
	BRSH       L__main792
	JMP        L_main149
L__main792:
;inverseur_auto.c,399 :: 		auto_ = ~auto_;
	LDS        R16, _auto_+0
	COM        R16
	STS        _auto_+0, R16
;inverseur_auto.c,402 :: 		t_group = 255;*/
	TST        R16
	BRNE       L__main793
	JMP        L_main150
L__main793:
;inverseur_auto.c,403 :: 		}
L_main150:
;inverseur_auto.c,404 :: 		EEPROM_Write(50, auto_);
	LDS        R4, _auto_+0
	LDI        R27, 50
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,405 :: 		if(auto_){
	LDS        R16, _auto_+0
	TST        R16
	BRNE       L__main794
	JMP        L_main151
L__main794:
;inverseur_auto.c,406 :: 		Lcd_Out(2,1,"    MODE AUTO   ");
	LDI        R27, #lo_addr(?lstr38_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr38_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,407 :: 		config.b1 = 0;
	LDS        R27, _config+0
	CBR        R27, 2
	STS        _config+0, R27
;inverseur_auto.c,408 :: 		}
	JMP        L_main152
L_main151:
;inverseur_auto.c,410 :: 		Lcd_Out(2,1,"   MODE MANUEL  ");
	LDI        R27, #lo_addr(?lstr39_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr39_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,411 :: 		t_arret = 0;
	LDI        R27, 0
	STS        _t_arret+0, R27
;inverseur_auto.c,412 :: 		}
L_main152:
;inverseur_auto.c,413 :: 		}
	JMP        L_main153
L_main149:
;inverseur_auto.c,414 :: 		else if(led_timer>=5 && !auto_){
	LDS        R16, _led_timer+0
	CPI        R16, 5
	BRSH       L__main795
	JMP        L__main674
L__main795:
	LDS        R16, _auto_+0
	TST        R16
	BREQ       L__main796
	JMP        L__main673
L__main796:
L__main658:
;inverseur_auto.c,415 :: 		if(!SUR_SECTEUR && !manual_){
	IN         R27, PORTB+0
	SBRC       R27, 3
	JMP        L__main664
	LDS        R16, _manual_+0
	TST        R16
	BREQ       L__main797
	JMP        L__main663
L__main797:
L__main657:
;inverseur_auto.c,416 :: 		manual_=1;
	LDI        R27, 1
	STS        _manual_+0, R27
;inverseur_auto.c,417 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,418 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,419 :: 		Lcd_Out(2,1,"   POINT ZERO   ");
	LDI        R27, #lo_addr(?lstr40_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,420 :: 		}
	JMP        L_main160
;inverseur_auto.c,415 :: 		if(!SUR_SECTEUR && !manual_){
L__main664:
L__main663:
;inverseur_auto.c,421 :: 		else if(SUR_SECTEUR && !SUR_GROUP && manual_==1){
	IN         R27, PORTB+0
	SBRS       R27, 3
	JMP        L__main667
	IN         R27, PORTB+0
	SBRC       R27, 4
	JMP        L__main666
	LDS        R16, _manual_+0
	CPI        R16, 1
	BREQ       L__main798
	JMP        L__main665
L__main798:
L__main656:
;inverseur_auto.c,422 :: 		manual_=0;
	LDI        R27, 0
	STS        _manual_+0, R27
;inverseur_auto.c,423 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,424 :: 		SUR_GROUP = 1;
	IN         R27, PORTB+0
	SBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,425 :: 		Lcd_Out(2,1,"   SUR GROUPE   ");
	LDI        R27, #lo_addr(?lstr41_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,426 :: 		}
	JMP        L_main164
;inverseur_auto.c,421 :: 		else if(SUR_SECTEUR && !SUR_GROUP && manual_==1){
L__main667:
L__main666:
L__main665:
;inverseur_auto.c,427 :: 		else if(SUR_GROUP && !manual_){
	IN         R27, PORTB+0
	SBRS       R27, 4
	JMP        L__main669
	LDS        R16, _manual_+0
	TST        R16
	BREQ       L__main799
	JMP        L__main668
L__main799:
L__main655:
;inverseur_auto.c,428 :: 		manual_=2;
	LDI        R27, 2
	STS        _manual_+0, R27
;inverseur_auto.c,429 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,430 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,431 :: 		Lcd_Out(2,1,"   POINT ZERO   ");
	LDI        R27, #lo_addr(?lstr42_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr42_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,432 :: 		}
	JMP        L_main168
;inverseur_auto.c,427 :: 		else if(SUR_GROUP && !manual_){
L__main669:
L__main668:
;inverseur_auto.c,433 :: 		else if(SUR_SECTEUR && !SUR_GROUP && manual_==2){
	IN         R27, PORTB+0
	SBRS       R27, 3
	JMP        L__main672
	IN         R27, PORTB+0
	SBRC       R27, 4
	JMP        L__main671
	LDS        R16, _manual_+0
	CPI        R16, 2
	BREQ       L__main800
	JMP        L__main670
L__main800:
L__main654:
;inverseur_auto.c,434 :: 		manual_=0;
	LDI        R27, 0
	STS        _manual_+0, R27
;inverseur_auto.c,435 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,436 :: 		SUR_SECTEUR = 0;
	IN         R27, PORTB+0
	CBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,437 :: 		Lcd_Out(2,1,"   SUR SECTEUR  ");
	LDI        R27, #lo_addr(?lstr43_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr43_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,438 :: 		}
	JMP        L_main172
;inverseur_auto.c,433 :: 		else if(SUR_SECTEUR && !SUR_GROUP && manual_==2){
L__main672:
L__main671:
L__main670:
;inverseur_auto.c,440 :: 		manual_=0;
	LDI        R27, 0
	STS        _manual_+0, R27
;inverseur_auto.c,441 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,442 :: 		SUR_SECTEUR = 0;
	IN         R27, PORTB+0
	CBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,443 :: 		Lcd_Out(2,1,"   SUR SECTEUR  ");
	LDI        R27, #lo_addr(?lstr44_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr44_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,444 :: 		}
L_main172:
L_main168:
L_main164:
L_main160:
;inverseur_auto.c,445 :: 		}
	JMP        L_main173
;inverseur_auto.c,414 :: 		else if(led_timer>=5 && !auto_){
L__main674:
L__main673:
;inverseur_auto.c,446 :: 		else if(auto_){
	LDS        R16, _auto_+0
	TST        R16
	BRNE       L__main801
	JMP        L_main174
L__main801:
;inverseur_auto.c,447 :: 		Lcd_Out(2,1,"    MODE AUTO   ");
	LDI        R27, #lo_addr(?lstr45_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr45_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,448 :: 		}
	JMP        L_main175
L_main174:
;inverseur_auto.c,450 :: 		Lcd_Out(2,1,"   MODE MANUEL  ");
	LDI        R27, #lo_addr(?lstr46_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr46_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_main175:
L_main173:
L_main153:
;inverseur_auto.c,451 :: 		config.b1 = 0;
	LDS        R27, _config+0
	CBR        R27, 2
	STS        _config+0, R27
;inverseur_auto.c,452 :: 		while(!SET);
L_main176:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_main177
	JMP        L_main176
L_main177:
;inverseur_auto.c,453 :: 		delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_main178:
	DEC        R16
	BRNE       L_main178
	DEC        R17
	BRNE       L_main178
	DEC        R18
	BRNE       L_main178
	NOP
	NOP
	NOP
	NOP
;inverseur_auto.c,454 :: 		set_led=0;
	LDI        R27, 0
	STS        _set_led+0, R27
;inverseur_auto.c,393 :: 		if(!SET && !m){
L__main676:
L__main675:
;inverseur_auto.c,456 :: 		if(auto_ && !m){
	LDS        R16, _auto_+0
	TST        R16
	BRNE       L__main802
	JMP        L__main678
L__main802:
	LDS        R16, _m+0
	TST        R16
	BREQ       L__main803
	JMP        L__main677
L__main803:
L__main653:
;inverseur_auto.c,457 :: 		inverser(3);
	LDI        R27, 3
	MOV        R2, R27
	CALL       _inverser+0
;inverseur_auto.c,458 :: 		}
	JMP        L_main183
;inverseur_auto.c,456 :: 		if(auto_ && !m){
L__main678:
L__main677:
;inverseur_auto.c,459 :: 		else if(!m)
	LDS        R16, _m+0
	TST        R16
	BREQ       L__main804
	JMP        L_main184
L__main804:
;inverseur_auto.c,460 :: 		mesures();
	CALL       _mesures+0
L_main184:
L_main183:
;inverseur_auto.c,461 :: 		}
	JMP        L_main140
;inverseur_auto.c,462 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_system:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,464 :: 		void system(){
;inverseur_auto.c,465 :: 		char sys = 0, i = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 0
	STD        Y+0, R27
;inverseur_auto.c,466 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_system185:
	DEC        R16
	BRNE       L_system185
	DEC        R17
	BRNE       L_system185
	DEC        R18
	BRNE       L_system185
	NOP
;inverseur_auto.c,467 :: 		sys = EEPROM_Read(100);
	LDI        R27, 100
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STD        Y+1, R16
;inverseur_auto.c,468 :: 		while(H && !L && i<5){
L_system187:
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__system545
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__system544
	LDD        R16, Y+0
	CPI        R16, 5
	BRLO       L__system807
	JMP        L__system543
L__system807:
L__system542:
;inverseur_auto.c,469 :: 		delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_system191:
	DEC        R16
	BRNE       L_system191
	DEC        R17
	BRNE       L_system191
	DEC        R18
	BRNE       L_system191
	NOP
;inverseur_auto.c,470 :: 		if(!H){
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L_system193
;inverseur_auto.c,471 :: 		sys = 230;
	LDI        R27, 230
	STD        Y+1, R27
;inverseur_auto.c,472 :: 		i = 200;
	LDI        R27, 200
	STD        Y+0, R27
;inverseur_auto.c,473 :: 		}
L_system193:
;inverseur_auto.c,474 :: 		LED_FLASH=!LED_FLASH;
	IN         R0, PORTB+0
	LDI        R27, 32
	EOR        R0, R27
	OUT        PORTB+0, R0
;inverseur_auto.c,475 :: 		i++;
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
;inverseur_auto.c,476 :: 		}
	JMP        L_system187
;inverseur_auto.c,468 :: 		while(H && !L && i<5){
L__system545:
L__system544:
L__system543:
;inverseur_auto.c,477 :: 		while(L && !H && i<5){
L_system194:
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__system548
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__system547
	LDD        R16, Y+0
	CPI        R16, 5
	BRLO       L__system810
	JMP        L__system546
L__system810:
L__system541:
;inverseur_auto.c,478 :: 		delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_system198:
	DEC        R16
	BRNE       L_system198
	DEC        R17
	BRNE       L_system198
	DEC        R18
	BRNE       L_system198
	NOP
;inverseur_auto.c,479 :: 		if(!L){
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_system200
;inverseur_auto.c,480 :: 		sys = 0;
	LDI        R27, 0
	STD        Y+1, R27
;inverseur_auto.c,481 :: 		i = 200;
	LDI        R27, 200
	STD        Y+0, R27
;inverseur_auto.c,482 :: 		}
L_system200:
;inverseur_auto.c,483 :: 		LED_FLASH=!LED_FLASH;
	IN         R0, PORTB+0
	LDI        R27, 32
	EOR        R0, R27
	OUT        PORTB+0, R0
;inverseur_auto.c,484 :: 		i++;
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
;inverseur_auto.c,485 :: 		}
	JMP        L_system194
;inverseur_auto.c,477 :: 		while(L && !H && i<5){
L__system548:
L__system547:
L__system546:
;inverseur_auto.c,486 :: 		LED_FLASH=1;
	IN         R27, PORTB+0
	SBR        R27, 32
	OUT        PORTB+0, R27
;inverseur_auto.c,487 :: 		if(sys<255){
	LDD        R16, Y+1
	CPI        R16, 255
	BRLO       L__system813
	JMP        L_system201
L__system813:
;inverseur_auto.c,488 :: 		sys++;
	LDD        R16, Y+1
	SUBI       R16, 255
;inverseur_auto.c,489 :: 		EEPROM_Write(100,sys);
	MOV        R4, R16
	LDI        R27, 100
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,490 :: 		}
	JMP        L_system202
L_system201:
;inverseur_auto.c,492 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,493 :: 		Lcd_Out(1, 1, " ERREUR SYSTEME!");
	LDI        R27, #lo_addr(?lstr47_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr47_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,494 :: 		Lcd_Out(2, 1, "________________");
	LDI        R27, #lo_addr(?lstr48_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr48_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,495 :: 		while(1);
L_system203:
	JMP        L_system203
;inverseur_auto.c,496 :: 		}
L_system202:
;inverseur_auto.c,497 :: 		}
L_end_system:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _system

_demarrage:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,499 :: 		void demarrage(){
;inverseur_auto.c,500 :: 		char x = 3;
	PUSH       R2
	LDI        R27, 3
	STD        Y+0, R27
;inverseur_auto.c,501 :: 		PHASE_GROUP1=ADC_Read(5);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	LDI        R27, 0
	STS        _PHASE_GROUP1+2, R27
	STS        _PHASE_GROUP1+3, R27
;inverseur_auto.c,502 :: 		while(PHASE_GROUP1<200 && x && !start()){
L_demarrage205:
	LDS        R16, _PHASE_GROUP1+0
	LDS        R17, _PHASE_GROUP1+1
	LDS        R18, _PHASE_GROUP1+2
	LDS        R19, _PHASE_GROUP1+3
	CPI        R19, 0
	BRNE       L__demarrage815
	CPI        R18, 0
	BRNE       L__demarrage815
	CPI        R17, 0
	BRNE       L__demarrage815
	CPI        R16, 200
L__demarrage815:
	BRLO       L__demarrage816
	JMP        L__demarrage607
L__demarrage816:
	LDD        R16, Y+0
	TST        R16
	BRNE       L__demarrage817
	JMP        L__demarrage606
L__demarrage817:
	CALL       _start+0
	TST        R16
	BREQ       L__demarrage818
	JMP        L__demarrage605
L__demarrage818:
L__demarrage604:
;inverseur_auto.c,503 :: 		if(!SET){
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_demarrage209
;inverseur_auto.c,504 :: 		x=0;
	LDI        R27, 0
	STD        Y+0, R27
;inverseur_auto.c,505 :: 		}
	JMP        L_demarrage210
L_demarrage209:
;inverseur_auto.c,507 :: 		x--;
	LDD        R16, Y+0
	SUBI       R16, 1
	STD        Y+0, R16
;inverseur_auto.c,508 :: 		delay(8);
	LDI        R27, 8
	MOV        R2, R27
	CALL       _delay+0
;inverseur_auto.c,509 :: 		PHASE_GROUP1=ADC_Read(5);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	LDI        R27, 0
	STS        _PHASE_GROUP1+2, R27
	STS        _PHASE_GROUP1+3, R27
;inverseur_auto.c,510 :: 		}
L_demarrage210:
;inverseur_auto.c,511 :: 		}
	JMP        L_demarrage205
;inverseur_auto.c,502 :: 		while(PHASE_GROUP1<200 && x && !start()){
L__demarrage607:
L__demarrage606:
L__demarrage605:
;inverseur_auto.c,513 :: 		while(!SET)
L_demarrage211:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_demarrage212
;inverseur_auto.c,514 :: 		LED_FLASH=1;
	IN         R27, PORTB+0
	SBR        R27, 32
	OUT        PORTB+0, R27
	JMP        L_demarrage211
L_demarrage212:
;inverseur_auto.c,516 :: 		if(!x){
	LDD        R16, Y+0
	TST        R16
	BREQ       L__demarrage819
	JMP        L_demarrage213
L__demarrage819:
;inverseur_auto.c,517 :: 		ELECTRO_VANNE = 0;
	IN         R27, PORTB+0
	CBR        R27, 4
	OUT        PORTB+0, R27
;inverseur_auto.c,518 :: 		config.b1 = 1;
	LDS        R27, _config+0
	SBR        R27, 2
	STS        _config+0, R27
;inverseur_auto.c,519 :: 		t_arret=255;
	LDI        R27, 255
	STS        _t_arret+0, R27
;inverseur_auto.c,520 :: 		delayms(10);
	LDI        R27, 10
	MOV        R2, R27
	CALL       _delayms+0
;inverseur_auto.c,521 :: 		}
	JMP        L_demarrage214
L_demarrage213:
;inverseur_auto.c,523 :: 		t_arret=255;
	LDI        R27, 255
	STS        _t_arret+0, R27
;inverseur_auto.c,524 :: 		}
L_demarrage214:
;inverseur_auto.c,525 :: 		}
L_end_demarrage:
	POP        R2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _demarrage

_inverser:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,527 :: 		void inverser(char i){
;inverseur_auto.c,528 :: 		char xp = mesures();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R2
	CALL       _mesures+0
	POP        R2
; xp start address is: 17 (R17)
	MOV        R17, R16
;inverseur_auto.c,529 :: 		if(!xp && i==3 || !i){
	TST        R16
	BREQ       L__inverser821
	JMP        L__inverser623
L__inverser821:
	LDI        R27, 3
	CP         R2, R27
	BREQ       L__inverser822
	JMP        L__inverser622
L__inverser822:
	JMP        L__inverser620
L__inverser623:
L__inverser622:
	TST        R2
	BRNE       L__inverser823
	JMP        L__inverser624
L__inverser823:
	JMP        L_inverser219
L__inverser620:
L__inverser624:
;inverseur_auto.c,530 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,531 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,532 :: 		if(auto_ && !config.b1)
	LDS        R16, _auto_+0
	TST        R16
	BRNE       L__inverser824
	JMP        L__inverser626
L__inverser824:
	LDS        R27, _config+0
	SBRC       R27, 1
	JMP        L__inverser625
L__inverser619:
;inverseur_auto.c,533 :: 		demarrage();
	PUSH       R17
	PUSH       R2
	CALL       _demarrage+0
	POP        R2
	POP        R17
;inverseur_auto.c,532 :: 		if(auto_ && !config.b1)
L__inverser626:
L__inverser625:
;inverseur_auto.c,534 :: 		t_sect=255;
	LDI        R27, 255
	STS        _t_sect+0, R27
;inverseur_auto.c,535 :: 		t_group=255;
	LDI        R27, 255
	STS        _t_group+0, R27
;inverseur_auto.c,536 :: 		}
	JMP        L_inverser223
L_inverser219:
;inverseur_auto.c,537 :: 		else if(xp==1){
	CPI        R17, 1
	BREQ       L__inverser825
	JMP        L_inverser224
L__inverser825:
;inverseur_auto.c,538 :: 		t_sect=255;
	LDI        R27, 255
	STS        _t_sect+0, R27
;inverseur_auto.c,539 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,540 :: 		}
	JMP        L_inverser225
L_inverser224:
;inverseur_auto.c,541 :: 		else if(xp==2){
	CPI        R17, 2
	BREQ       L__inverser826
	JMP        L_inverser226
L__inverser826:
;inverseur_auto.c,542 :: 		t_group=255;
	LDI        R27, 255
	STS        _t_group+0, R27
;inverseur_auto.c,543 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,544 :: 		}
L_inverser226:
L_inverser225:
L_inverser223:
;inverseur_auto.c,547 :: 		if(xp && xp !=  1 && !t_sect && i==3 || i==1){
	TST        R17
	BRNE       L__inverser827
	JMP        L__inverser630
L__inverser827:
	CPI        R17, 1
	BRNE       L__inverser828
	JMP        L__inverser629
L__inverser828:
	LDS        R16, _t_sect+0
	TST        R16
	BREQ       L__inverser829
	JMP        L__inverser628
L__inverser829:
	LDI        R27, 3
	CP         R2, R27
	BREQ       L__inverser830
	JMP        L__inverser627
L__inverser830:
	JMP        L__inverser617
L__inverser630:
L__inverser629:
L__inverser628:
L__inverser627:
	LDI        R27, 1
	CP         R2, R27
	BRNE       L__inverser831
	JMP        L__inverser631
L__inverser831:
	JMP        L_inverser231
L__inverser617:
L__inverser631:
;inverseur_auto.c,548 :: 		char x = EEPROM_Read(21);
	PUSH       R17
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
;inverseur_auto.c,549 :: 		SUR_GROUP = 0;
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,550 :: 		delayms(x);
	MOV        R2, R16
	CALL       _delayms+0
;inverseur_auto.c,551 :: 		SUR_SECTEUR = 0;
	IN         R27, PORTB+0
	CBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,552 :: 		t_sect=255;
	LDI        R27, 255
	STS        _t_sect+0, R27
;inverseur_auto.c,553 :: 		config.b1 = 0;
	LDS        R27, _config+0
	CBR        R27, 2
	STS        _config+0, R27
;inverseur_auto.c,554 :: 		t_arret = EEPROM_Read(11);
	LDI        R27, 11
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	POP        R17
	STS        _t_arret+0, R16
;inverseur_auto.c,555 :: 		if(t_arret==255){
	CPI        R16, 255
	BREQ       L__inverser832
	JMP        L_inverser232
L__inverser832:
;inverseur_auto.c,556 :: 		t_arret = 120;
	LDI        R27, 120
	STS        _t_arret+0, R27
;inverseur_auto.c,557 :: 		}
L_inverser232:
;inverseur_auto.c,558 :: 		system();
	PUSH       R17
	CALL       _system+0
	POP        R17
;inverseur_auto.c,559 :: 		}
	JMP        L_inverser233
L_inverser231:
;inverseur_auto.c,560 :: 		else if(xp && xp !=  2 &&  !t_group && i==3 || i==2){
	TST        R17
	BRNE       L__inverser833
	JMP        L__inverser635
L__inverser833:
	CPI        R17, 2
	BRNE       L__inverser834
	JMP        L__inverser634
L__inverser834:
	LDS        R16, _t_group+0
	TST        R16
	BREQ       L__inverser835
	JMP        L__inverser633
L__inverser835:
	LDI        R27, 3
	CP         R2, R27
	BREQ       L__inverser836
	JMP        L__inverser632
L__inverser836:
	JMP        L__inverser615
L__inverser635:
L__inverser634:
L__inverser633:
L__inverser632:
	LDI        R27, 2
	CP         R2, R27
	BRNE       L__inverser837
	JMP        L__inverser636
L__inverser837:
	JMP        L_inverser238
L__inverser615:
L__inverser636:
;inverseur_auto.c,561 :: 		char x = EEPROM_Read(21);
	PUSH       R17
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
;inverseur_auto.c,562 :: 		SUR_SECTEUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 8
	OUT        PORTB+0, R27
;inverseur_auto.c,563 :: 		delayms(x);
	MOV        R2, R16
	CALL       _delayms+0
	POP        R17
;inverseur_auto.c,564 :: 		SUR_GROUP = 1;
	IN         R27, PORTB+0
	SBR        R27, 16
	OUT        PORTB+0, R27
;inverseur_auto.c,565 :: 		config.b1 = 0;
	LDS        R27, _config+0
	CBR        R27, 2
	STS        _config+0, R27
;inverseur_auto.c,566 :: 		t_group=255;
	LDI        R27, 255
	STS        _t_group+0, R27
;inverseur_auto.c,567 :: 		t_arret=255;
	LDI        R27, 255
	STS        _t_arret+0, R27
;inverseur_auto.c,568 :: 		}
	JMP        L_inverser239
L_inverser238:
;inverseur_auto.c,569 :: 		else if(!SUR_GROUP && t_arret==255)
	IN         R27, PORTB+0
	SBRC       R27, 4
	JMP        L__inverser638
	LDS        R16, _t_arret+0
	CPI        R16, 255
	BREQ       L__inverser838
	JMP        L__inverser637
L__inverser838:
L__inverser614:
;inverseur_auto.c,570 :: 		t_arret = EEPROM_Read(11);
	PUSH       R17
	LDI        R27, 11
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	POP        R17
	STS        _t_arret+0, R16
;inverseur_auto.c,569 :: 		else if(!SUR_GROUP && t_arret==255)
L__inverser638:
L__inverser637:
;inverseur_auto.c,570 :: 		t_arret = EEPROM_Read(11);
L_inverser239:
L_inverser233:
;inverseur_auto.c,572 :: 		if(xp && xp !=  1 && t_sect==255 && SUR_SECTEUR)
	TST        R17
	BRNE       L__inverser839
	JMP        L__inverser642
L__inverser839:
	CPI        R17, 1
	BRNE       L__inverser840
	JMP        L__inverser641
L__inverser840:
	LDS        R16, _t_sect+0
	CPI        R16, 255
	BREQ       L__inverser841
	JMP        L__inverser640
L__inverser841:
	IN         R27, PORTB+0
	SBRS       R27, 3
	JMP        L__inverser639
L__inverser613:
;inverseur_auto.c,573 :: 		t_sect=EEPROM_Read(20);
	PUSH       R17
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	POP        R17
	STS        _t_sect+0, R16
	JMP        L_inverser246
;inverseur_auto.c,572 :: 		if(xp && xp !=  1 && t_sect==255 && SUR_SECTEUR)
L__inverser642:
L__inverser641:
L__inverser640:
L__inverser639:
;inverseur_auto.c,574 :: 		else if((xp==1 || !xp) && t_sect != 255)
	CPI        R17, 1
	BRNE       L__inverser842
	JMP        L__inverser644
L__inverser842:
	TST        R17
	BRNE       L__inverser843
	JMP        L__inverser643
L__inverser843:
	JMP        L_inverser251
L__inverser644:
L__inverser643:
	LDS        R16, _t_sect+0
	CPI        R16, 255
	BRNE       L__inverser844
	JMP        L__inverser645
L__inverser844:
L__inverser611:
;inverseur_auto.c,575 :: 		t_sect=255;
	LDI        R27, 255
	STS        _t_sect+0, R27
L_inverser251:
;inverseur_auto.c,574 :: 		else if((xp==1 || !xp) && t_sect != 255)
L__inverser645:
;inverseur_auto.c,575 :: 		t_sect=255;
L_inverser246:
;inverseur_auto.c,577 :: 		if(xp == 1 && t_group==255 && SUR_SECTEUR && !SUR_GROUP)
	CPI        R17, 1
	BREQ       L__inverser845
	JMP        L__inverser649
L__inverser845:
	LDS        R16, _t_group+0
	CPI        R16, 255
	BREQ       L__inverser846
	JMP        L__inverser648
L__inverser846:
	IN         R27, PORTB+0
	SBRS       R27, 3
	JMP        L__inverser647
	IN         R27, PORTB+0
	SBRC       R27, 4
	JMP        L__inverser646
; xp end address is: 17 (R17)
L__inverser610:
;inverseur_auto.c,578 :: 		t_group=EEPROM_Read(22);
	LDI        R27, 22
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _t_group+0, R16
	JMP        L_inverser255
;inverseur_auto.c,577 :: 		if(xp == 1 && t_group==255 && SUR_SECTEUR && !SUR_GROUP)
L__inverser649:
; xp start address is: 17 (R17)
L__inverser648:
L__inverser647:
L__inverser646:
;inverseur_auto.c,579 :: 		else if((xp==2 || !xp) && t_group != 255)
	CPI        R17, 2
	BRNE       L__inverser847
	JMP        L__inverser651
L__inverser847:
	TST        R17
	BRNE       L__inverser848
	JMP        L__inverser650
L__inverser848:
; xp end address is: 17 (R17)
	JMP        L_inverser260
L__inverser651:
L__inverser650:
	LDS        R16, _t_group+0
	CPI        R16, 255
	BRNE       L__inverser849
	JMP        L__inverser652
L__inverser849:
L__inverser608:
;inverseur_auto.c,580 :: 		t_group=255;
	LDI        R27, 255
	STS        _t_group+0, R27
L_inverser260:
;inverseur_auto.c,579 :: 		else if((xp==2 || !xp) && t_group != 255)
L__inverser652:
;inverseur_auto.c,580 :: 		t_group=255;
L_inverser255:
;inverseur_auto.c,582 :: 		if(t_arret<=5){
	LDS        R17, _t_arret+0
	LDI        R16, 5
	CP         R16, R17
	BRSH       L__inverser850
	JMP        L_inverser261
L__inverser850:
;inverseur_auto.c,584 :: 		m_Lcd_Out(2, 1, 16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,585 :: 		ByteToStr(t_arret, txt);
	MOVW       R16, R28
	MOV        R3, R16
	MOV        R4, R17
	LDS        R2, _t_arret+0
	CALL       _ByteToStr+0
;inverseur_auto.c,586 :: 		Lcd_Out(2,16,Ltrim(txt));
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,587 :: 		}
L_inverser261:
;inverseur_auto.c,589 :: 		if(!t_arret){
	LDS        R16, _t_arret+0
	TST        R16
	BREQ       L__inverser851
	JMP        L_inverser262
L__inverser851:
;inverseur_auto.c,590 :: 		ELECTRO_VANNE=0;
	IN         R27, PORTB+0
	CBR        R27, 4
	OUT        PORTB+0, R27
;inverseur_auto.c,591 :: 		t_arret=255;
	LDI        R27, 255
	STS        _t_arret+0, R27
;inverseur_auto.c,592 :: 		}
L_inverser262:
;inverseur_auto.c,593 :: 		}
L_end_inverser:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _inverser

_m_Lcd_Out:

;inverseur_auto.c,595 :: 		void m_Lcd_Out(char lin, char col, char index){
;inverseur_auto.c,596 :: 		char i =0;
;inverseur_auto.c,597 :: 		for(i=0;c_chaine[index][i]!='\0';i++){
; i start address is: 20 (R20)
	LDI        R20, 0
; i end address is: 20 (R20)
L_m_Lcd_Out263:
; i start address is: 20 (R20)
	MOV        R18, R4
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDI        R16, #lo_addr(_c_chaine+0)
	LDI        R17, hi_addr(_c_chaine+0)
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z+
	LD         R17, Z+
	MOV        R30, R20
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
	CPI        R16, 0
	BRNE       L__m_Lcd_Out853
	JMP        L_m_Lcd_Out264
L__m_Lcd_Out853:
;inverseur_auto.c,598 :: 		Lcd_Chr(lin, col, c_chaine[index][i]);
	MOV        R18, R4
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDI        R16, #lo_addr(_c_chaine+0)
	LDI        R17, hi_addr(_c_chaine+0)
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z+
	LD         R17, Z+
	MOV        R30, R20
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
	PUSH       R4
	PUSH       R2
	MOV        R4, R16
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R4
;inverseur_auto.c,599 :: 		if(col<16)
	LDI        R27, 16
	CP         R3, R27
	BRLO       L__m_Lcd_Out854
	JMP        L_m_Lcd_Out266
L__m_Lcd_Out854:
;inverseur_auto.c,600 :: 		col++;
	MOV        R16, R3
	SUBI       R16, 255
	MOV        R3, R16
L_m_Lcd_Out266:
;inverseur_auto.c,597 :: 		for(i=0;c_chaine[index][i]!='\0';i++){
	MOV        R16, R20
	SUBI       R16, 255
	MOV        R20, R16
;inverseur_auto.c,601 :: 		}
; i end address is: 20 (R20)
	JMP        L_m_Lcd_Out263
L_m_Lcd_Out264:
;inverseur_auto.c,602 :: 		}
L_end_m_Lcd_Out:
	RET
; end of _m_Lcd_Out

_start:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,605 :: 		char start(){
;inverseur_auto.c,606 :: 		char tt = EEPROM_Read(1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STD        Y+0, R16
;inverseur_auto.c,607 :: 		char x = 0;
;inverseur_auto.c,608 :: 		if(!SET)
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_start267
;inverseur_auto.c,609 :: 		return;
	JMP        L_end_start
L_start267:
;inverseur_auto.c,610 :: 		set_led=4;
	LDI        R27, 4
	STS        _set_led+0, R27
;inverseur_auto.c,611 :: 		m_Lcd_Out(1, 1, 9);
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,612 :: 		m_Lcd_Out(2, 1, 15);
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,614 :: 		ELECTRO_VANNE = 1;
	IN         R27, PORTB+0
	SBR        R27, 4
	OUT        PORTB+0, R27
;inverseur_auto.c,615 :: 		DEMAREUR = 1;
	IN         R27, PORTB+0
	SBR        R27, 2
	OUT        PORTB+0, R27
;inverseur_auto.c,616 :: 		delayms(tt);
	LDD        R2, Y+0
	CALL       _delayms+0
;inverseur_auto.c,617 :: 		DEMAREUR = 0;
	IN         R27, PORTB+0
	CBR        R27, 2
	OUT        PORTB+0, R27
;inverseur_auto.c,619 :: 		delay(5);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _delay+0
;inverseur_auto.c,620 :: 		PHASE_GROUP1=ADC_Read(5);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	LDI        R27, 0
	STS        _PHASE_GROUP1+2, R27
	STS        _PHASE_GROUP1+3, R27
;inverseur_auto.c,621 :: 		if(PHASE_GROUP1<200){
	LDS        R16, _PHASE_GROUP1+0
	LDS        R17, _PHASE_GROUP1+1
	LDS        R18, _PHASE_GROUP1+2
	LDS        R19, _PHASE_GROUP1+3
	CPI        R19, 0
	BRNE       L__start856
	CPI        R18, 0
	BRNE       L__start856
	CPI        R17, 0
	BRNE       L__start856
	CPI        R16, 200
L__start856:
	BRLO       L__start857
	JMP        L_start268
L__start857:
;inverseur_auto.c,622 :: 		DEMAREUR = 0;
	IN         R27, PORTB+0
	CBR        R27, 2
	OUT        PORTB+0, R27
;inverseur_auto.c,623 :: 		ELECTRO_VANNE = 1;
	IN         R27, PORTB+0
	SBR        R27, 4
	OUT        PORTB+0, R27
;inverseur_auto.c,624 :: 		m_Lcd_Out(2, 1, 18);
	LDI        R27, 18
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,625 :: 		led_timer = 0;
	LDI        R27, 0
	STS        _led_timer+0, R27
;inverseur_auto.c,626 :: 		set_led=3;
	LDI        R27, 3
	STS        _set_led+0, R27
;inverseur_auto.c,627 :: 		return 0;
	LDI        R16, 0
	JMP        L_end_start
;inverseur_auto.c,628 :: 		}
L_start268:
;inverseur_auto.c,629 :: 		m_Lcd_Out(1, 1, 14);
	LDI        R27, 14
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,630 :: 		delay(2);
	LDI        R27, 2
	MOV        R2, R27
	CALL       _delay+0
;inverseur_auto.c,631 :: 		mesures();
	CALL       _mesures+0
;inverseur_auto.c,632 :: 		set_led=5;
	LDI        R27, 5
	STS        _set_led+0, R27
;inverseur_auto.c,633 :: 		return 255;
	LDI        R16, 255
;inverseur_auto.c,634 :: 		}
;inverseur_auto.c,633 :: 		return 255;
;inverseur_auto.c,634 :: 		}
L_end_start:
	POP        R4
	POP        R3
	POP        R2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _start

_affiche:

;inverseur_auto.c,637 :: 		void affiche(){
;inverseur_auto.c,638 :: 		if(m==0){
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _m+0
	CPI        R16, 0
	BREQ       L__affiche859
	JMP        L_affiche269
L__affiche859:
;inverseur_auto.c,639 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,640 :: 		m_Lcd_Out(1, 1, 9);
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,641 :: 		mesures();
	CALL       _mesures+0
;inverseur_auto.c,642 :: 		}
	JMP        L_affiche270
L_affiche269:
;inverseur_auto.c,643 :: 		else if(m<6){
	LDS        R16, _m+0
	CPI        R16, 6
	BRLO       L__affiche860
	JMP        L_affiche271
L__affiche860:
;inverseur_auto.c,644 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,645 :: 		m_Lcd_Out(1, 1, 0);
	CLR        R4
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,646 :: 		if(m==1){
	LDS        R16, _m+0
	CPI        R16, 1
	BREQ       L__affiche861
	JMP        L_affiche272
L__affiche861:
;inverseur_auto.c,647 :: 		Lcd_Out(2, 1, "Demarreur");
	LDI        R27, #lo_addr(?lstr49_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr49_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,648 :: 		}
	JMP        L_affiche273
L_affiche272:
;inverseur_auto.c,649 :: 		else if(m==2){
	LDS        R16, _m+0
	CPI        R16, 2
	BREQ       L__affiche862
	JMP        L_affiche274
L__affiche862:
;inverseur_auto.c,650 :: 		Lcd_Out(2, 1, "Invertion auto  ");
	LDI        R27, #lo_addr(?lstr50_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr50_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,651 :: 		}
	JMP        L_affiche275
L_affiche274:
;inverseur_auto.c,652 :: 		else if(m==3){
	LDS        R16, _m+0
	CPI        R16, 3
	BREQ       L__affiche863
	JMP        L_affiche276
L__affiche863:
;inverseur_auto.c,653 :: 		Lcd_Out(2, 1, "Seuil de tension");
	LDI        R27, #lo_addr(?lstr51_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr51_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,654 :: 		}
	JMP        L_affiche277
L_affiche276:
;inverseur_auto.c,655 :: 		else if(m==4){
	LDS        R16, _m+0
	CPI        R16, 4
	BREQ       L__affiche864
	JMP        L_affiche278
L__affiche864:
;inverseur_auto.c,656 :: 		Lcd_Out(2, 1, "Ordre des phases");
	LDI        R27, #lo_addr(?lstr52_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr52_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,657 :: 		}
	JMP        L_affiche279
L_affiche278:
;inverseur_auto.c,658 :: 		else if(m==5){
	LDS        R16, _m+0
	CPI        R16, 5
	BREQ       L__affiche865
	JMP        L_affiche280
L__affiche865:
;inverseur_auto.c,659 :: 		m_Lcd_Out(2, 1, 10);
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,660 :: 		}
L_affiche280:
L_affiche279:
L_affiche277:
L_affiche275:
L_affiche273:
;inverseur_auto.c,661 :: 		}
	JMP        L_affiche281
L_affiche271:
;inverseur_auto.c,662 :: 		else if(m==10){
	LDS        R16, _m+0
	CPI        R16, 10
	BREQ       L__affiche866
	JMP        L_affiche282
L__affiche866:
;inverseur_auto.c,663 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,664 :: 		m_Lcd_Out(1, 1, 3);
	LDI        R27, 3
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,665 :: 		m_Lcd_Out(2, 1, 7);
	LDI        R27, 7
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,666 :: 		}
	JMP        L_affiche283
L_affiche282:
;inverseur_auto.c,667 :: 		else if(m==11){
	LDS        R16, _m+0
	CPI        R16, 11
	BREQ       L__affiche867
	JMP        L_affiche284
L__affiche867:
;inverseur_auto.c,668 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,669 :: 		m_Lcd_Out(1, 1, 3);
	LDI        R27, 3
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,670 :: 		m_Lcd_Out(2, 1, 17);
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,671 :: 		}
	JMP        L_affiche285
L_affiche284:
;inverseur_auto.c,672 :: 		else if(m==12){
	LDS        R16, _m+0
	CPI        R16, 12
	BREQ       L__affiche868
	JMP        L_affiche286
L__affiche868:
;inverseur_auto.c,673 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,674 :: 		m_Lcd_Out(1, 1, 3);
	LDI        R27, 3
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,675 :: 		m_Lcd_Out(2, 1, 10);
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,676 :: 		}
	JMP        L_affiche287
L_affiche286:
;inverseur_auto.c,677 :: 		else if(m==13){
	LDS        R16, _m+0
	CPI        R16, 13
	BREQ       L__affiche869
	JMP        L_affiche288
L__affiche869:
;inverseur_auto.c,678 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,679 :: 		m_Lcd_Out(1, 1, 3);
	LDI        R27, 3
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,680 :: 		m_Lcd_Out(2, 1, 21);
	LDI        R27, 21
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,681 :: 		}
	JMP        L_affiche289
L_affiche288:
;inverseur_auto.c,682 :: 		else if(m==20){
	LDS        R16, _m+0
	CPI        R16, 20
	BREQ       L__affiche870
	JMP        L_affiche290
L__affiche870:
;inverseur_auto.c,683 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,684 :: 		m_Lcd_Out(1, 1, 4);
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,685 :: 		m_Lcd_Out(2, 1, 11);
	LDI        R27, 11
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,686 :: 		}
	JMP        L_affiche291
L_affiche290:
;inverseur_auto.c,687 :: 		else if(m==21){
	LDS        R16, _m+0
	CPI        R16, 21
	BREQ       L__affiche871
	JMP        L_affiche292
L__affiche871:
;inverseur_auto.c,688 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,689 :: 		m_Lcd_Out(1, 1, 4);
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,690 :: 		m_Lcd_Out(2, 1, 12);
	LDI        R27, 12
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,691 :: 		}
	JMP        L_affiche293
L_affiche292:
;inverseur_auto.c,692 :: 		else if(m==22){
	LDS        R16, _m+0
	CPI        R16, 22
	BREQ       L__affiche872
	JMP        L_affiche294
L__affiche872:
;inverseur_auto.c,693 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,694 :: 		m_Lcd_Out(1, 1, 4);
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,695 :: 		m_Lcd_Out(2, 1, 20);
	LDI        R27, 20
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,696 :: 		}
	JMP        L_affiche295
L_affiche294:
;inverseur_auto.c,697 :: 		else if(m==23){
	LDS        R16, _m+0
	CPI        R16, 23
	BREQ       L__affiche873
	JMP        L_affiche296
L__affiche873:
;inverseur_auto.c,698 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,699 :: 		m_Lcd_Out(1, 1, 4);
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,700 :: 		m_Lcd_Out(2, 1, 10);
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,701 :: 		}
	JMP        L_affiche297
L_affiche296:
;inverseur_auto.c,702 :: 		else if(m==30){
	LDS        R16, _m+0
	CPI        R16, 30
	BREQ       L__affiche874
	JMP        L_affiche298
L__affiche874:
;inverseur_auto.c,703 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,704 :: 		m_Lcd_Out(1, 1, 5);
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,705 :: 		m_Lcd_Out(2, 1, 1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,706 :: 		}
	JMP        L_affiche299
L_affiche298:
;inverseur_auto.c,707 :: 		else if(m==31){
	LDS        R16, _m+0
	CPI        R16, 31
	BREQ       L__affiche875
	JMP        L_affiche300
L__affiche875:
;inverseur_auto.c,708 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,709 :: 		m_Lcd_Out(1, 1, 5);
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,710 :: 		m_Lcd_Out(2, 1, 2);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,711 :: 		}
	JMP        L_affiche301
L_affiche300:
;inverseur_auto.c,712 :: 		else if(m==32){
	LDS        R16, _m+0
	CPI        R16, 32
	BREQ       L__affiche876
	JMP        L_affiche302
L__affiche876:
;inverseur_auto.c,713 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,714 :: 		m_Lcd_Out(1, 1, 5);
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,715 :: 		m_Lcd_Out(2, 1, 22);
	LDI        R27, 22
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,716 :: 		}
	JMP        L_affiche303
L_affiche302:
;inverseur_auto.c,717 :: 		else if(m==33){
	LDS        R16, _m+0
	CPI        R16, 33
	BREQ       L__affiche877
	JMP        L_affiche304
L__affiche877:
;inverseur_auto.c,718 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,719 :: 		m_Lcd_Out(1, 1, 5);
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,720 :: 		Lcd_Out(2, 1, "Delay defaut    ");
	LDI        R27, #lo_addr(?lstr53_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr53_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,721 :: 		}
	JMP        L_affiche305
L_affiche304:
;inverseur_auto.c,722 :: 		else if(m==34){
	LDS        R16, _m+0
	CPI        R16, 34
	BREQ       L__affiche878
	JMP        L_affiche306
L__affiche878:
;inverseur_auto.c,723 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,724 :: 		m_Lcd_Out(1, 1, 5);
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,725 :: 		Lcd_Out(2, 1, "Calib sect     ");
	LDI        R27, #lo_addr(?lstr54_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr54_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,726 :: 		}
	JMP        L_affiche307
L_affiche306:
;inverseur_auto.c,727 :: 		else if(m==35){
	LDS        R16, _m+0
	CPI        R16, 35
	BREQ       L__affiche879
	JMP        L_affiche308
L__affiche879:
;inverseur_auto.c,728 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,729 :: 		m_Lcd_Out(1, 1, 5);
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,730 :: 		m_Lcd_Out(2, 1, 10);
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,731 :: 		}
	JMP        L_affiche309
L_affiche308:
;inverseur_auto.c,732 :: 		else if(m==40){
	LDS        R16, _m+0
	CPI        R16, 40
	BREQ       L__affiche880
	JMP        L_affiche310
L__affiche880:
;inverseur_auto.c,733 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,734 :: 		m_Lcd_Out(1, 1, 6);
	LDI        R27, 6
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,735 :: 		m_Lcd_Out(2, 1, 21);
	LDI        R27, 21
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,736 :: 		}
	JMP        L_affiche311
L_affiche310:
;inverseur_auto.c,737 :: 		else if(m==41){
	LDS        R16, _m+0
	CPI        R16, 41
	BREQ       L__affiche881
	JMP        L_affiche312
L__affiche881:
;inverseur_auto.c,738 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;inverseur_auto.c,739 :: 		m_Lcd_Out(1, 1, 6);
	LDI        R27, 6
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,740 :: 		m_Lcd_Out(2, 1, 10);
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _m_Lcd_Out+0
;inverseur_auto.c,741 :: 		}
L_affiche312:
L_affiche311:
L_affiche309:
L_affiche307:
L_affiche305:
L_affiche303:
L_affiche301:
L_affiche299:
L_affiche297:
L_affiche295:
L_affiche293:
L_affiche291:
L_affiche289:
L_affiche287:
L_affiche285:
L_affiche283:
L_affiche281:
L_affiche270:
;inverseur_auto.c,742 :: 		}
L_end_affiche:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _affiche

_av:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,744 :: 		void av(){
;inverseur_auto.c,746 :: 		ByteToStr(v, txt);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	MOVW       R16, R28
	MOV        R3, R16
	MOV        R4, R17
	LDS        R2, _v+0
	CALL       _ByteToStr+0
;inverseur_auto.c,747 :: 		Lcd_Out(2, 14, txt);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,749 :: 		}
L_end_av:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 3
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _av

_setval:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 15
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;inverseur_auto.c,751 :: 		void setval(char mm){
;inverseur_auto.c,753 :: 		if(mm==32){
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 32
	CP         R2, R27
	BREQ       L__setval884
	JMP        L_setval313
L__setval884:
;inverseur_auto.c,754 :: 		PHASE_GROUP1 = ADC_Read(5);
	PUSH       R2
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_GROUP1+0, R16
	STS        _PHASE_GROUP1+1, R17
	LDI        R27, 0
	STS        _PHASE_GROUP1+2, R27
	STS        _PHASE_GROUP1+3, R27
;inverseur_auto.c,755 :: 		EEPROM_Write(33, PHASE_GROUP1>>8);
	LDS        R16, _PHASE_GROUP1+0
	LDS        R17, _PHASE_GROUP1+1
	LDS        R18, _PHASE_GROUP1+2
	LDS        R19, _PHASE_GROUP1+3
	MOV        R16, R17
	MOV        R17, R18
	MOV        R18, R19
	LDI        R19, 0
	MOV        R4, R16
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,756 :: 		EEPROM_Write(34, PHASE_GROUP1);
	LDS        R4, _PHASE_GROUP1+0
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
	POP        R2
;inverseur_auto.c,757 :: 		}
L_setval313:
;inverseur_auto.c,758 :: 		if(mm==34){
	LDI        R27, 34
	CP         R2, R27
	BREQ       L__setval885
	JMP        L_setval314
L__setval885:
;inverseur_auto.c,759 :: 		PHASE_SECT1=ADC_Read(4);
	PUSH       R2
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _PHASE_SECT1+0, R16
	STS        _PHASE_SECT1+1, R17
	LDI        R27, 0
	STS        _PHASE_SECT1+2, R27
	STS        _PHASE_SECT1+3, R27
;inverseur_auto.c,760 :: 		EEPROM_Write(37, PHASE_SECT1>>8);
	LDS        R16, _PHASE_SECT1+0
	LDS        R17, _PHASE_SECT1+1
	LDS        R18, _PHASE_SECT1+2
	LDS        R19, _PHASE_SECT1+3
	MOV        R16, R17
	MOV        R17, R18
	MOV        R18, R19
	LDI        R19, 0
	MOV        R4, R16
	LDI        R27, 37
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,761 :: 		EEPROM_Write(38, PHASE_SECT1);
	LDS        R4, _PHASE_SECT1+0
	LDI        R27, 38
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
	POP        R2
;inverseur_auto.c,762 :: 		}
L_setval314:
;inverseur_auto.c,763 :: 		av();
	PUSH       R2
	CALL       _av+0
;inverseur_auto.c,766 :: 		IntToStr(PHASE_GROUP1, txt);
	MOVW       R16, R28
	MOVW       R4, R16
	LDS        R2, _PHASE_GROUP1+0
	LDS        R3, _PHASE_GROUP1+1
	CALL       _IntToStr+0
;inverseur_auto.c,767 :: 		Lcd_Out(1,1,"      /         ");
	LDI        R27, #lo_addr(?lstr55_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr55_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,768 :: 		Lcd_Out(1,1,Ltrim(txt));
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,770 :: 		IntToStr(v, txt);
	MOVW       R16, R28
	MOVW       R4, R16
	LDS        R2, _v+0
	LDI        R27, 0
	MOV        R3, R27
	CALL       _IntToStr+0
;inverseur_auto.c,771 :: 		Lcd_Out(1,9,"     V  ");
	LDI        R27, #lo_addr(?lstr56_inverseur_auto+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr56_inverseur_auto+0)
	MOV        R5, R27
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,772 :: 		Lcd_Out(1,9,Ltrim(txt));
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;inverseur_auto.c,773 :: 		delayms(20);
	LDI        R27, 20
	MOV        R2, R27
	CALL       _delayms+0
	POP        R2
;inverseur_auto.c,775 :: 		EEPROM_Write(mm, v);
	MOV        R16, R2
	LDS        R4, _v+0
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,776 :: 		}
L_end_setval:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 14
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _setval

_getval:

;inverseur_auto.c,777 :: 		void getval(char mm){
;inverseur_auto.c,778 :: 		v = EEPROM_Read(mm);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	MOV        R16, R2
	PUSH       R2
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	POP        R2
	STS        _v+0, R16
;inverseur_auto.c,779 :: 		if(v>=255){
	CPI        R16, 255
	BRSH       L__getval887
	JMP        L_getval315
L__getval887:
;inverseur_auto.c,780 :: 		v=0;
	LDI        R27, 0
	STS        _v+0, R27
;inverseur_auto.c,781 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_getval316:
	DEC        R16
	BRNE       L_getval316
	DEC        R17
	BRNE       L_getval316
	DEC        R18
	BRNE       L_getval316
;inverseur_auto.c,782 :: 		EEPROM_Write(mm, v);
	MOV        R16, R2
	LDS        R4, _v+0
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;inverseur_auto.c,783 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_getval318:
	DEC        R16
	BRNE       L_getval318
	DEC        R17
	BRNE       L_getval318
	DEC        R18
	BRNE       L_getval318
;inverseur_auto.c,784 :: 		}
L_getval315:
;inverseur_auto.c,785 :: 		av();
	CALL       _av+0
;inverseur_auto.c,786 :: 		}
L_end_getval:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _getval

_retour:

;inverseur_auto.c,788 :: 		void retour(char p){
;inverseur_auto.c,789 :: 		delay_extinsion=0;
	LDI        R27, 0
	STS        _delay_extinsion+0, R27
;inverseur_auto.c,790 :: 		if(!p){
	TST        R2
	BREQ       L__retour889
	JMP        L_retour320
L__retour889:
;inverseur_auto.c,791 :: 		if(m<10)
	LDS        R16, _m+0
	CPI        R16, 10
	BRLO       L__retour890
	JMP        L_retour321
L__retour890:
;inverseur_auto.c,792 :: 		m = 0;
	LDI        R27, 0
	STS        _m+0, R27
	JMP        L_retour322
L_retour321:
;inverseur_auto.c,794 :: 		m = m/10;
	LDS        R16, _m+0
	LDI        R20, 10
	CALL       _Div_8x8_U+0
	STS        _m+0, R16
;inverseur_auto.c,795 :: 		}
L_retour322:
;inverseur_auto.c,796 :: 		}
L_retour320:
;inverseur_auto.c,797 :: 		V=255;
	LDI        R27, 255
	STS        _v+0, R27
;inverseur_auto.c,798 :: 		affiche();
	CALL       _affiche+0
;inverseur_auto.c,799 :: 		while(!SET);
L_retour323:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_retour324
	JMP        L_retour323
L_retour324:
;inverseur_auto.c,800 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_retour325:
	DEC        R16
	BRNE       L_retour325
	DEC        R17
	BRNE       L_retour325
	DEC        R18
	BRNE       L_retour325
	NOP
;inverseur_auto.c,801 :: 		led_timer=200;
	LDI        R27, 200
	STS        _led_timer+0, R27
;inverseur_auto.c,802 :: 		}
L_end_retour:
	RET
; end of _retour

_SET_menu:

;inverseur_auto.c,803 :: 		void SET_menu(){
;inverseur_auto.c,804 :: 		if(m<10 && m>=6)
	PUSH       R2
	LDS        R16, _m+0
	CPI        R16, 10
	BRLO       L__SET_menu892
	JMP        L__SET_menu560
L__SET_menu892:
	LDS        R16, _m+0
	CPI        R16, 6
	BRSH       L__SET_menu893
	JMP        L__SET_menu559
L__SET_menu893:
L__SET_menu558:
;inverseur_auto.c,805 :: 		m=1;
	LDI        R27, 1
	STS        _m+0, R27
	JMP        L_SET_menu330
;inverseur_auto.c,804 :: 		if(m<10 && m>=6)
L__SET_menu560:
L__SET_menu559:
;inverseur_auto.c,806 :: 		else if(m<20 && m>12)
	LDS        R16, _m+0
	CPI        R16, 20
	BRLO       L__SET_menu894
	JMP        L__SET_menu562
L__SET_menu894:
	LDS        R17, _m+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SET_menu895
	JMP        L__SET_menu561
L__SET_menu895:
L__SET_menu557:
;inverseur_auto.c,807 :: 		m=10;
	LDI        R27, 10
	STS        _m+0, R27
	JMP        L_SET_menu334
;inverseur_auto.c,806 :: 		else if(m<20 && m>12)
L__SET_menu562:
L__SET_menu561:
;inverseur_auto.c,808 :: 		else if(m<30 && m>=24)
	LDS        R16, _m+0
	CPI        R16, 30
	BRLO       L__SET_menu896
	JMP        L__SET_menu564
L__SET_menu896:
	LDS        R16, _m+0
	CPI        R16, 24
	BRSH       L__SET_menu897
	JMP        L__SET_menu563
L__SET_menu897:
L__SET_menu556:
;inverseur_auto.c,809 :: 		m=20;
	LDI        R27, 20
	STS        _m+0, R27
	JMP        L_SET_menu338
;inverseur_auto.c,808 :: 		else if(m<30 && m>=24)
L__SET_menu564:
L__SET_menu563:
;inverseur_auto.c,810 :: 		else if(m<40 && m>=36)
	LDS        R16, _m+0
	CPI        R16, 40
	BRLO       L__SET_menu898
	JMP        L__SET_menu566
L__SET_menu898:
	LDS        R16, _m+0
	CPI        R16, 36
	BRSH       L__SET_menu899
	JMP        L__SET_menu565
L__SET_menu899:
L__SET_menu555:
;inverseur_auto.c,811 :: 		m=30;
	LDI        R27, 30
	STS        _m+0, R27
	JMP        L_SET_menu342
;inverseur_auto.c,810 :: 		else if(m<40 && m>=36)
L__SET_menu566:
L__SET_menu565:
;inverseur_auto.c,812 :: 		else if(m<50 && m>=42)
	LDS        R16, _m+0
	CPI        R16, 50
	BRLO       L__SET_menu900
	JMP        L__SET_menu568
L__SET_menu900:
	LDS        R16, _m+0
	CPI        R16, 42
	BRSH       L__SET_menu901
	JMP        L__SET_menu567
L__SET_menu901:
L__SET_menu554:
;inverseur_auto.c,813 :: 		m=40;
	LDI        R27, 40
	STS        _m+0, R27
;inverseur_auto.c,812 :: 		else if(m<50 && m>=42)
L__SET_menu568:
L__SET_menu567:
;inverseur_auto.c,813 :: 		m=40;
L_SET_menu342:
L_SET_menu338:
L_SET_menu334:
L_SET_menu330:
;inverseur_auto.c,814 :: 		affiche();
	CALL       _affiche+0
;inverseur_auto.c,815 :: 		if(v!=255 && m==10){
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__SET_menu902
	JMP        L__SET_menu570
L__SET_menu902:
	LDS        R16, _m+0
	CPI        R16, 10
	BREQ       L__SET_menu903
	JMP        L__SET_menu569
L__SET_menu903:
L__SET_menu553:
;inverseur_auto.c,816 :: 		if(v>100)
	LDS        R17, _v+0
	LDI        R16, 100
	CP         R16, R17
	BRLO       L__SET_menu904
	JMP        L_SET_menu349
L__SET_menu904:
;inverseur_auto.c,817 :: 		v=0;
	LDI        R27, 0
	STS        _v+0, R27
L_SET_menu349:
;inverseur_auto.c,818 :: 		setval(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,815 :: 		if(v!=255 && m==10){
L__SET_menu570:
L__SET_menu569:
;inverseur_auto.c,820 :: 		if(v!=255 && m==11){
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__SET_menu905
	JMP        L__SET_menu572
L__SET_menu905:
	LDS        R16, _m+0
	CPI        R16, 11
	BREQ       L__SET_menu906
	JMP        L__SET_menu571
L__SET_menu906:
L__SET_menu552:
;inverseur_auto.c,821 :: 		setval(2);
	LDI        R27, 2
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,820 :: 		if(v!=255 && m==11){
L__SET_menu572:
L__SET_menu571:
;inverseur_auto.c,823 :: 		if(v!=255 && m<25){
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__SET_menu907
	JMP        L__SET_menu574
L__SET_menu907:
	LDS        R16, _m+0
	CPI        R16, 25
	BRLO       L__SET_menu908
	JMP        L__SET_menu573
L__SET_menu908:
L__SET_menu551:
;inverseur_auto.c,824 :: 		if(m==20){
	LDS        R16, _m+0
	CPI        R16, 20
	BREQ       L__SET_menu909
	JMP        L_SET_menu356
L__SET_menu909:
;inverseur_auto.c,825 :: 		setval(20);
	LDI        R27, 20
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,826 :: 		}
	JMP        L_SET_menu357
L_SET_menu356:
;inverseur_auto.c,827 :: 		else if(m==21){
	LDS        R16, _m+0
	CPI        R16, 21
	BREQ       L__SET_menu910
	JMP        L_SET_menu358
L__SET_menu910:
;inverseur_auto.c,828 :: 		setval(21);
	LDI        R27, 21
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,829 :: 		}
	JMP        L_SET_menu359
L_SET_menu358:
;inverseur_auto.c,830 :: 		else if(m==22){
	LDS        R16, _m+0
	CPI        R16, 22
	BREQ       L__SET_menu911
	JMP        L_SET_menu360
L__SET_menu911:
;inverseur_auto.c,831 :: 		setval(22);
	LDI        R27, 22
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,832 :: 		}
L_SET_menu360:
L_SET_menu359:
L_SET_menu357:
;inverseur_auto.c,823 :: 		if(v!=255 && m<25){
L__SET_menu574:
L__SET_menu573:
;inverseur_auto.c,834 :: 		if(v!=255 && m<35){
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__SET_menu912
	JMP        L__SET_menu576
L__SET_menu912:
	LDS        R16, _m+0
	CPI        R16, 35
	BRLO       L__SET_menu913
	JMP        L__SET_menu575
L__SET_menu913:
L__SET_menu550:
;inverseur_auto.c,835 :: 		if(m==30){
	LDS        R16, _m+0
	CPI        R16, 30
	BREQ       L__SET_menu914
	JMP        L_SET_menu364
L__SET_menu914:
;inverseur_auto.c,836 :: 		setval(30);
	LDI        R27, 30
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,837 :: 		}
	JMP        L_SET_menu365
L_SET_menu364:
;inverseur_auto.c,838 :: 		else if(m==31){
	LDS        R16, _m+0
	CPI        R16, 31
	BREQ       L__SET_menu915
	JMP        L_SET_menu366
L__SET_menu915:
;inverseur_auto.c,839 :: 		setval(31);
	LDI        R27, 31
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,840 :: 		}
	JMP        L_SET_menu367
L_SET_menu366:
;inverseur_auto.c,841 :: 		else if(m==32){
	LDS        R16, _m+0
	CPI        R16, 32
	BREQ       L__SET_menu916
	JMP        L_SET_menu368
L__SET_menu916:
;inverseur_auto.c,842 :: 		setval(32);
	LDI        R27, 32
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,843 :: 		}
	JMP        L_SET_menu369
L_SET_menu368:
;inverseur_auto.c,844 :: 		else if(m==33){
	LDS        R16, _m+0
	CPI        R16, 33
	BREQ       L__SET_menu917
	JMP        L_SET_menu370
L__SET_menu917:
;inverseur_auto.c,845 :: 		if(v>100)
	LDS        R17, _v+0
	LDI        R16, 100
	CP         R16, R17
	BRLO       L__SET_menu918
	JMP        L_SET_menu371
L__SET_menu918:
;inverseur_auto.c,846 :: 		v=0;
	LDI        R27, 0
	STS        _v+0, R27
L_SET_menu371:
;inverseur_auto.c,847 :: 		setval(35);
	LDI        R27, 35
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,848 :: 		}
	JMP        L_SET_menu372
L_SET_menu370:
;inverseur_auto.c,849 :: 		else if(m==34){
	LDS        R16, _m+0
	CPI        R16, 34
	BREQ       L__SET_menu919
	JMP        L_SET_menu373
L__SET_menu919:
;inverseur_auto.c,850 :: 		setval(36);
	LDI        R27, 36
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,851 :: 		}
L_SET_menu373:
L_SET_menu372:
L_SET_menu369:
L_SET_menu367:
L_SET_menu365:
;inverseur_auto.c,834 :: 		if(v!=255 && m<35){
L__SET_menu576:
L__SET_menu575:
;inverseur_auto.c,853 :: 		if(v!=255 && m<45){
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__SET_menu920
	JMP        L__SET_menu578
L__SET_menu920:
	LDS        R16, _m+0
	CPI        R16, 45
	BRLO       L__SET_menu921
	JMP        L__SET_menu577
L__SET_menu921:
L__SET_menu549:
;inverseur_auto.c,854 :: 		if(m==40){
	LDS        R16, _m+0
	CPI        R16, 40
	BREQ       L__SET_menu922
	JMP        L_SET_menu377
L__SET_menu922:
;inverseur_auto.c,855 :: 		if(v>1)
	LDS        R17, _v+0
	LDI        R16, 1
	CP         R16, R17
	BRLO       L__SET_menu923
	JMP        L_SET_menu378
L__SET_menu923:
;inverseur_auto.c,856 :: 		v=0;
	LDI        R27, 0
	STS        _v+0, R27
L_SET_menu378:
;inverseur_auto.c,857 :: 		setval(40);
	LDI        R27, 40
	MOV        R2, R27
	CALL       _setval+0
;inverseur_auto.c,858 :: 		}
L_SET_menu377:
;inverseur_auto.c,853 :: 		if(v!=255 && m<45){
L__SET_menu578:
L__SET_menu577:
;inverseur_auto.c,860 :: 		}
L_end_SET_menu:
	POP        R2
	RET
; end of _SET_menu

_menu:

;inverseur_auto.c,862 :: 		void menu(){
;inverseur_auto.c,863 :: 		if(!B_MENU){
	PUSH       R2
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L_menu379
;inverseur_auto.c,864 :: 		led_timer=0;
	LDI        R27, 0
	STS        _led_timer+0, R27
;inverseur_auto.c,865 :: 		while((!B_MENU && !m && led_timer<62) | (!B_MENU && led_timer<5));
L_menu380:
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L_menu383
	LDS        R16, _m+0
	TST        R16
	BREQ       L__menu925
	JMP        L_menu383
L__menu925:
	LDS        R16, _led_timer+0
	CPI        R16, 62
	BRLO       L__menu926
	JMP        L_menu383
L__menu926:
	LDI        R17, 1
	JMP        L_menu382
L_menu383:
	LDI        R17, 0
L_menu382:
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L_menu385
	LDS        R16, _led_timer+0
	CPI        R16, 5
	BRLO       L__menu927
	JMP        L_menu385
L__menu927:
	LDI        R16, 1
	JMP        L_menu384
L_menu385:
	LDI        R16, 0
L_menu384:
	OR         R16, R17
	BRNE       L__menu928
	JMP        L_menu381
L__menu928:
	JMP        L_menu380
L_menu381:
;inverseur_auto.c,866 :: 		if((!B_MENU && !m && led_timer>=62) | (!B_MENU && led_timer>=5 && m)){
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L_menu387
	LDS        R16, _m+0
	TST        R16
	BREQ       L__menu929
	JMP        L_menu387
L__menu929:
	LDS        R16, _led_timer+0
	CPI        R16, 62
	BRSH       L__menu930
	JMP        L_menu387
L__menu930:
	LDI        R17, 1
	JMP        L_menu386
L_menu387:
	LDI        R17, 0
L_menu386:
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L_menu389
	LDS        R16, _led_timer+0
	CPI        R16, 5
	BRSH       L__menu931
	JMP        L_menu389
L__menu931:
	LDS        R16, _m+0
	TST        R16
	BRNE       L__menu932
	JMP        L_menu389
L__menu932:
	LDI        R16, 1
	JMP        L_menu388
L_menu389:
	LDI        R16, 0
L_menu388:
	OR         R16, R17
	BRNE       L__menu933
	JMP        L_menu390
L__menu933:
;inverseur_auto.c,867 :: 		delay_extinsion=0;
	LDI        R27, 0
	STS        _delay_extinsion+0, R27
;inverseur_auto.c,868 :: 		if(v != 255){
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__menu934
	JMP        L_menu391
L__menu934:
;inverseur_auto.c,869 :: 		milli=1000;
	LDI        R27, 232
	STS        _milli+0, R27
	LDI        R27, 3
	STS        _milli+1, R27
	LDI        R27, 0
	STS        _milli+2, R27
	STS        _milli+3, R27
;inverseur_auto.c,870 :: 		while(!B_MENU && milli);
L_menu392:
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__menu587
	LDS        R16, _milli+0
	LDS        R17, _milli+1
	LDS        R18, _milli+2
	LDS        R19, _milli+3
	MOV        R27, R16
	OR         R27, R17
	OR         R27, R18
	OR         R27, R19
	BRNE       L__menu935
	JMP        L__menu586
L__menu935:
L__menu585:
	JMP        L_menu392
L__menu587:
L__menu586:
;inverseur_auto.c,871 :: 		if(milli){
	LDS        R16, _milli+0
	LDS        R17, _milli+1
	LDS        R18, _milli+2
	LDS        R19, _milli+3
	MOV        R27, R16
	OR         R27, R17
	OR         R27, R18
	OR         R27, R19
	BRNE       L__menu936
	JMP        L_menu396
L__menu936:
;inverseur_auto.c,872 :: 		v++;
	LDS        R16, _v+0
	SUBI       R16, 255
	STS        _v+0, R16
;inverseur_auto.c,873 :: 		if(v >= 254)
	CPI        R16, 254
	BRSH       L__menu937
	JMP        L_menu397
L__menu937:
;inverseur_auto.c,874 :: 		v=0;
	LDI        R27, 0
	STS        _v+0, R27
L_menu397:
;inverseur_auto.c,875 :: 		SET_menu();
	CALL       _SET_menu+0
;inverseur_auto.c,876 :: 		}
L_menu396:
;inverseur_auto.c,877 :: 		while(!B_MENU && !milli){
L_menu398:
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__menu589
	LDS        R16, _milli+0
	LDS        R17, _milli+1
	LDS        R18, _milli+2
	LDS        R19, _milli+3
	MOV        R27, R16
	OR         R27, R17
	OR         R27, R18
	OR         R27, R19
	BREQ       L__menu938
	JMP        L__menu588
L__menu938:
L__menu584:
;inverseur_auto.c,878 :: 		v = v +10;
	LDS        R16, _v+0
	SUBI       R16, 246
	STS        _v+0, R16
;inverseur_auto.c,879 :: 		if(v >= 254)
	CPI        R16, 254
	BRSH       L__menu939
	JMP        L_menu402
L__menu939:
;inverseur_auto.c,880 :: 		v=0;
	LDI        R27, 0
	STS        _v+0, R27
L_menu402:
;inverseur_auto.c,881 :: 		SET_menu();
	CALL       _SET_menu+0
;inverseur_auto.c,882 :: 		delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_menu403:
	DEC        R16
	BRNE       L_menu403
	DEC        R17
	BRNE       L_menu403
	DEC        R18
	BRNE       L_menu403
	NOP
;inverseur_auto.c,883 :: 		}
	JMP        L_menu398
;inverseur_auto.c,877 :: 		while(!B_MENU && !milli){
L__menu589:
L__menu588:
;inverseur_auto.c,884 :: 		}
	JMP        L_menu405
L_menu391:
;inverseur_auto.c,886 :: 		m++;
	LDS        R16, _m+0
	SUBI       R16, 255
	STS        _m+0, R16
;inverseur_auto.c,887 :: 		SET_menu();
	CALL       _SET_menu+0
;inverseur_auto.c,888 :: 		while(!B_MENU && m==1 && v==255);
L_menu406:
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__menu592
	LDS        R16, _m+0
	CPI        R16, 1
	BREQ       L__menu940
	JMP        L__menu591
L__menu940:
	LDS        R16, _v+0
	CPI        R16, 255
	BREQ       L__menu941
	JMP        L__menu590
L__menu941:
L__menu583:
	JMP        L_menu406
L__menu592:
L__menu591:
L__menu590:
;inverseur_auto.c,889 :: 		}
L_menu405:
;inverseur_auto.c,891 :: 		}
L_menu390:
;inverseur_auto.c,892 :: 		}
L_menu379:
;inverseur_auto.c,895 :: 		if(!SET && v==255 && m){
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__menu600
	LDS        R16, _v+0
	CPI        R16, 255
	BREQ       L__menu942
	JMP        L__menu599
L__menu942:
	LDS        R16, _m+0
	TST        R16
	BRNE       L__menu943
	JMP        L__menu598
L__menu943:
L__menu582:
;inverseur_auto.c,896 :: 		led_timer=0;
	LDI        R27, 0
	STS        _led_timer+0, R27
;inverseur_auto.c,897 :: 		while(!SET && led_timer<5);
L_menu413:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__menu594
	LDS        R16, _led_timer+0
	CPI        R16, 5
	BRLO       L__menu944
	JMP        L__menu593
L__menu944:
L__menu581:
	JMP        L_menu413
L__menu594:
L__menu593:
;inverseur_auto.c,898 :: 		if(!SET && led_timer>=5 && m){
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__menu597
	LDS        R16, _led_timer+0
	CPI        R16, 5
	BRSH       L__menu945
	JMP        L__menu596
L__menu945:
	LDS        R16, _m+0
	TST        R16
	BRNE       L__menu946
	JMP        L__menu595
L__menu946:
L__menu580:
;inverseur_auto.c,899 :: 		char d=0;
;inverseur_auto.c,900 :: 		delay_extinsion=0;
	LDI        R27, 0
	STS        _delay_extinsion+0, R27
;inverseur_auto.c,901 :: 		if(m==5){
	LDS        R16, _m+0
	CPI        R16, 5
	BREQ       L__menu947
	JMP        L_menu420
L__menu947:
;inverseur_auto.c,902 :: 		retour(0);
	CLR        R2
	CALL       _retour+0
;inverseur_auto.c,903 :: 		}
	JMP        L_menu421
L_menu420:
;inverseur_auto.c,904 :: 		else if(m<9){
	LDS        R16, _m+0
	CPI        R16, 9
	BRLO       L__menu948
	JMP        L_menu422
L__menu948:
;inverseur_auto.c,905 :: 		m = m *10;
	LDS        R17, _m+0
	LDI        R16, 10
	MUL        R17, R16
	MOV        R16, R0
	STS        _m+0, R16
;inverseur_auto.c,906 :: 		affiche();
	CALL       _affiche+0
;inverseur_auto.c,907 :: 		}
	JMP        L_menu423
L_menu422:
;inverseur_auto.c,908 :: 		else if(m==10)
	LDS        R16, _m+0
	CPI        R16, 10
	BREQ       L__menu949
	JMP        L_menu424
L__menu949:
;inverseur_auto.c,909 :: 		getval(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _getval+0
	JMP        L_menu425
L_menu424:
;inverseur_auto.c,910 :: 		else if(m==11)
	LDS        R16, _m+0
	CPI        R16, 11
	BREQ       L__menu950
	JMP        L_menu426
L__menu950:
;inverseur_auto.c,911 :: 		getval(2);
	LDI        R27, 2
	MOV        R2, R27
	CALL       _getval+0
	JMP        L_menu427
L_menu426:
;inverseur_auto.c,912 :: 		else if(m==12)
	LDS        R16, _m+0
	CPI        R16, 12
	BREQ       L__menu951
	JMP        L_menu428
L__menu951:
;inverseur_auto.c,913 :: 		retour(0);
	CLR        R2
	CALL       _retour+0
	JMP        L_menu429
L_menu428:
;inverseur_auto.c,914 :: 		else if(m==20){
	LDS        R16, _m+0
	CPI        R16, 20
	BREQ       L__menu952
	JMP        L_menu430
L__menu952:
;inverseur_auto.c,915 :: 		getval(20);
	LDI        R27, 20
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,916 :: 		}
	JMP        L_menu431
L_menu430:
;inverseur_auto.c,917 :: 		else if(m==21){
	LDS        R16, _m+0
	CPI        R16, 21
	BREQ       L__menu953
	JMP        L_menu432
L__menu953:
;inverseur_auto.c,918 :: 		getval(21);
	LDI        R27, 21
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,919 :: 		}
	JMP        L_menu433
L_menu432:
;inverseur_auto.c,920 :: 		else if(m==22){
	LDS        R16, _m+0
	CPI        R16, 22
	BREQ       L__menu954
	JMP        L_menu434
L__menu954:
;inverseur_auto.c,921 :: 		getval(22);
	LDI        R27, 22
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,922 :: 		}
	JMP        L_menu435
L_menu434:
;inverseur_auto.c,923 :: 		else if(m==23){
	LDS        R16, _m+0
	CPI        R16, 23
	BREQ       L__menu955
	JMP        L_menu436
L__menu955:
;inverseur_auto.c,924 :: 		retour(0);
	CLR        R2
	CALL       _retour+0
;inverseur_auto.c,925 :: 		}
	JMP        L_menu437
L_menu436:
;inverseur_auto.c,926 :: 		else if(m==30){
	LDS        R16, _m+0
	CPI        R16, 30
	BREQ       L__menu956
	JMP        L_menu438
L__menu956:
;inverseur_auto.c,927 :: 		getval(30);
	LDI        R27, 30
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,928 :: 		}
	JMP        L_menu439
L_menu438:
;inverseur_auto.c,929 :: 		else if(m==31){
	LDS        R16, _m+0
	CPI        R16, 31
	BREQ       L__menu957
	JMP        L_menu440
L__menu957:
;inverseur_auto.c,930 :: 		getval(31);
	LDI        R27, 31
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,931 :: 		}
	JMP        L_menu441
L_menu440:
;inverseur_auto.c,932 :: 		else if(m==32){
	LDS        R16, _m+0
	CPI        R16, 32
	BREQ       L__menu958
	JMP        L_menu442
L__menu958:
;inverseur_auto.c,933 :: 		getval(32);
	LDI        R27, 32
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,934 :: 		}
	JMP        L_menu443
L_menu442:
;inverseur_auto.c,935 :: 		else if(m==33){
	LDS        R16, _m+0
	CPI        R16, 33
	BREQ       L__menu959
	JMP        L_menu444
L__menu959:
;inverseur_auto.c,936 :: 		getval(35);
	LDI        R27, 35
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,937 :: 		}
	JMP        L_menu445
L_menu444:
;inverseur_auto.c,938 :: 		else if(m==34){
	LDS        R16, _m+0
	CPI        R16, 34
	BREQ       L__menu960
	JMP        L_menu446
L__menu960:
;inverseur_auto.c,939 :: 		getval(36);
	LDI        R27, 36
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,940 :: 		}
	JMP        L_menu447
L_menu446:
;inverseur_auto.c,941 :: 		else if(m==35){
	LDS        R16, _m+0
	CPI        R16, 35
	BREQ       L__menu961
	JMP        L_menu448
L__menu961:
;inverseur_auto.c,942 :: 		retour(0);
	CLR        R2
	CALL       _retour+0
;inverseur_auto.c,943 :: 		}
	JMP        L_menu449
L_menu448:
;inverseur_auto.c,944 :: 		else if(m==40){
	LDS        R16, _m+0
	CPI        R16, 40
	BREQ       L__menu962
	JMP        L_menu450
L__menu962:
;inverseur_auto.c,945 :: 		getval(40);
	LDI        R27, 40
	MOV        R2, R27
	CALL       _getval+0
;inverseur_auto.c,946 :: 		}
	JMP        L_menu451
L_menu450:
;inverseur_auto.c,947 :: 		else if(m==41){
	LDS        R16, _m+0
	CPI        R16, 41
	BREQ       L__menu963
	JMP        L_menu452
L__menu963:
;inverseur_auto.c,948 :: 		retour(0);
	CLR        R2
	CALL       _retour+0
;inverseur_auto.c,949 :: 		}
L_menu452:
L_menu451:
L_menu449:
L_menu447:
L_menu445:
L_menu443:
L_menu441:
L_menu439:
L_menu437:
L_menu435:
L_menu433:
L_menu431:
L_menu429:
L_menu427:
L_menu425:
L_menu423:
L_menu421:
;inverseur_auto.c,898 :: 		if(!SET && led_timer>=5 && m){
L__menu597:
L__menu596:
L__menu595:
;inverseur_auto.c,951 :: 		while(!SET);
L_menu453:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L_menu454
	JMP        L_menu453
L_menu454:
;inverseur_auto.c,952 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_menu455:
	DEC        R16
	BRNE       L_menu455
	DEC        R17
	BRNE       L_menu455
	DEC        R18
	BRNE       L_menu455
	NOP
;inverseur_auto.c,895 :: 		if(!SET && v==255 && m){
L__menu600:
L__menu599:
L__menu598:
;inverseur_auto.c,954 :: 		if(!SET && m && v!=255){
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__menu603
	LDS        R16, _m+0
	TST        R16
	BRNE       L__menu964
	JMP        L__menu602
L__menu964:
	LDS        R16, _v+0
	CPI        R16, 255
	BRNE       L__menu965
	JMP        L__menu601
L__menu965:
L__menu579:
;inverseur_auto.c,955 :: 		retour(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _retour+0
;inverseur_auto.c,954 :: 		if(!SET && m && v!=255){
L__menu603:
L__menu602:
L__menu601:
;inverseur_auto.c,957 :: 		}
L_end_menu:
	POP        R2
	RET
; end of _menu
