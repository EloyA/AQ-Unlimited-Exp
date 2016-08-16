Func experience()
		Local $totalLoops = 0
		Local $successfulLoops = 0
		Local $expGained = 0

        While 1
				$totalLoops += 1

                ;if the AQ is available, attack Goblin Picnic with her
                If ChkQueenAvailability() Then
                        Click(66 + Random(-5,5,1), 607+ Random(-5,5,1));attack button

                        Local $loadedGobScreen = _WaitForPixel(819, 17, 923, 21, Hex(0xF88488, 6), 5, 30) ;determines if gob attack is loaded, wait max 30 seconds
                        If IsArray($loadedGobScreen) = False Then
                                SetLog("Failed to reach attack screen...", $COLOR_RED)
								errorReturnHome()
								ContinueLoop
                        EndIf
						_Sleep(200)
                        Local $atBottom = _WaitForPixel(840, 580, 844, 584, Hex(0x403828, 6), 5, 1) ;determines if at bottom already, wait max 1 second Hex(0x403828,6)(842,582)
                        If IsArray($atBottom) = False Then
                                SetLog("Need to scroll to bottom!", $COLOR_BLUE)
                                For $i = 0 To 9
                                        ControlSend($Title, "", "", "{UP}") ; scroll to the bottom of the goblin page
                                        If _Sleep(500) Then Return
                                Next
                        EndIf

						_PostMessage_ClickDrag(510 + Random(-5,5,1), 11 + Random(-5,5,1), 695 + Random(-5,5,1), 661 + Random(-5,5,1), "left", 1000)
						If _Sleep(250) Then Return

                        Local $gobCircle = _WaitForPixel(567, 190, 569, 300, Hex(0xD85400, 6), 5, 2) ;determines if gob circle is there, wait max 2 seconds
                        If IsArray($gobCircle) = False Then
                                SetLog("Failed to find goblin base circle...", $COLOR_RED)
								errorReturnHome()
								ContinueLoop
                        EndIf

						Click($gobCircle[0]+ Random(-5,5,1), $gobCircle[1]+ Random(-5,5,1));choose Goblin Picnic

                        Local $gobAttack = _WaitForPixel(573, 225, 577, 335, Hex(0xA6A39E, 6), 5, 2) ;determines if gob attack is there, wait max 2 seconds
                        If IsArray($gobAttack) = False Then
                                SetLog("Failed to find goblin attack button...", $COLOR_RED)
								errorReturnHome()
								ContinueLoop
                        EndIf
						_Sleep(50)

						Click($gobCircle[0]+ Random(-5,5,1), $gobCircle[1]+ Random(-5,5,1) + 35);Attack Goblin Picnic

                        SetLog(GetLangText("msgAttackingGoblin"), $COLOR_BLUE)

                        Local $loadedBaseLoc = _WaitForPixel(428, 427, 432, 431, Hex(0x6D8034, 6), 5, 10) ;determines if base is loaded, wait max 2 seconds
                        If IsArray($loadedBaseLoc) = False Then
                                SetLog("Failed to attack base...", $COLOR_RED)
                                If $DebugMode = 2 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "ExpNoBase-" & @HOUR & @MIN & @SEC & ".png")
								errorReturnHome()
								ContinueLoop
                        EndIf

                        Local $queenPos = getQueenPos() ; find AQ, make sure you have AQ
                        If $queenPos = -1 Then
							SetLog("Cannot find AQ. Try again...", $COLOR_RED)
							_Sleep(100)
							$queenPos = getQueenPos() ; find AQ, make sure you have AQ
							If $queenPos = -1 Then
								SetLog("Cannot find AQ. Return Home", $COLOR_RED)
								errorReturnHome()
								ContinueLoop
							EndIf
						EndIf

						dropQueen(323+ Random(-5,5,1), 202+ Random(-5,5,1), $queenPos) ; drop your AQ

                        Local $firstStar = _WaitForPixel(428, 358, 432, 362, Hex(0xC0C8C0, 6), 20, 8) ;Waits for the first star, wait max 15 seconds
                        If IsArray($firstStar) = False Then
                                Local $firstStar2 = _WaitForPixel(711, 536, 715, 540, Hex(0xC0C8C0, 6), 5, 2) ;Waits for the first star, wait max 2 seconds
                                If IsArray($firstStar2) = False Then
                                        SetLog("Failed to destroy TH...", $COLOR_RED)
                                        If $DebugMode = 2 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "ExpFailedAtk-" & @HOUR & @MIN & @SEC & ".png")
										errorReturnHome()
										ContinueLoop
                                EndIf
                        EndIf

                        Click(70+ Random(-5,5,1), 530+ Random(-5,5,1)) ;End Battle button

                        Local $okayButton = _WaitForPixel(513, 398, 517, 402, Hex(0x354217, 6), 5, 2) ;finds Okay button, wait max 2 seconds
                        If IsArray($okayButton) = False Then
                                SetLog("Failed to find Okay button...", $COLOR_RED)
								errorReturnHome()
								ContinueLoop
                        EndIf

                        Click(515+ Random(-5,5,1), 400+ Random(-5,5,1)) ;Confirm button

                        Local $returnButton = _WaitForPixel(426, 542, 430, 548, Hex(0xFFFFFF, 6), 5, 2) ;finds Return Home button, wait max 2 seconds
                        If IsArray($returnButton) = False Then
                                SetLog("Failed to find Return Home button...", $COLOR_RED)
								errorReturnHome()
								ContinueLoop
                        EndIf

                        Click(428+ Random(-5,5,1), 544+ Random(-5,5,1)) ;return home button

                        Local $homeScreen = _WaitForPixel(818, 178, 822, 182, Hex(0xD0EC7C, 6), 5, 5) ;Waits for main screen to load, wait max 5 seconds
                        If IsArray($homeScreen) = False Then
                                SetLog("Failed to return home...", $COLOR_RED)
                                If $DebugMode = 2 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "ExpFailedRtnHome-" & @HOUR & @MIN & @SEC & ".png")
								errorReturnHome()
								ContinueLoop
                        EndIf
						$successfulLoops += 1
						$expGained += 5
                        SetLog(GetLangText("msgVictory") & " " & $successfulLoops & " out of " & $totalLoops & " successful. " & $expGained & " Exp gained since start", $COLOR_BLUE)


                ;If the AQ is unavailable, attack the 2nd goblin base with the Barb King
                ElseIf ChkKingAvailability() Then

                        Click(66 + Random(-5,5,1), 607 + Random(-5,5,1));attack button
                        If _Sleep(500) Then Return

                        For $i = 0 To 20
                                ControlSend($Title, "", "", "{DOWN}") ; scroll up the goblin page
                                If _Sleep(500) Then Return
                        Next

                        If _Sleep(3000) Then Return

                        Click(674 + Random(-5,5,1), 208 + Random(-5,5,1));choose 2nd goblin base
                        If _Sleep(500) Then Return
                        Click(665 + Random(-5,5,1), 247 + Random(-5,5,1));attack goblin button
                        SetLog(GetLangText("msgAttackingGoblin"), $COLOR_BLUE)

                        _CaptureRegion()
                        While 1
                                If _ColorCheck(_GetPixelColor(430, 430), Hex(0x8D864A, 6), 5) Then
                                        ExitLoop
                                Else
                                        If _Sleep(1000) Then Return
                                        _CaptureRegion()
                                EndIf
                        WEnd

                        If _Sleep(500) Then Return
                        Local $kingPos = getKingPos() ; find king, make sure you have king
                        If $kingPos <> -1 Then dropKing(402 + Random(-5,5,1), 325 + Random(-5,5,1), $kingPos) ; drop your king

                        _CaptureRegion()
                        While 1
                                If _ColorCheck(_GetPixelColor(430, 530), Hex(0xD0E873, 6), 5) Then
                                        ExitLoop
                                Else
                                        If _Sleep(1000) Then Return
                                        _CaptureRegion()
                                EndIf
                        WEnd

                        Click(428 + Random(-5,5,1), 544 + Random(-5,5,1)) ;return home button
                        If _Sleep(1000) Then Return

                        _CaptureRegion()
                        While 1
                                If _ColorCheck(_GetPixelColor(820, 180), Hex(0xD0EC7C, 6), 5) Then
                                        ExitLoop
                                Else
                                        If _Sleep(1000) Then Return
                                        _CaptureRegion()
                                EndIf
                        WEnd

						$successfulLoops += 1
                        $expGained += 1
                        SetLog(GetLangText("msgVictory") & " " & $successfulLoops & " out of " & $totalLoops & " successful. " & $expGained & " Exp gained since start", $COLOR_BLUE)
                        If _Sleep(1000) Then Return

                ;If neither hero is available, wait 30 seconds then check heroes again

                Else
						$totalLoops -= 1
                        SetLog("Waiting for Hero...", $COLOR_BLUE)
                        If _Sleep(30000) Then Return
                EndIf

        WEnd
EndFunc   ;==>experience

Func getKingPos()
        ;   SetLog("Finding king pos", $COLOR_BLUE)
        Local $pos = -1
        For $i = 0 To 8
                Local $troop = IdentifyTroopKind($i)
                If $troop = $eKing Then
                        $pos = $i
                        ExitLoop
                EndIf
        Next
        Return $pos
EndFunc   ;==>getKingPos

Func dropKing($x = 10, $y = 10, $num = 2)
        If $num <> -1 Then
                ;         SetLog("Dropping King", $COLOR_BLUE)
                Click(68 + (72 * $num) + Random(-5,5,1), 595 + Random(-5,5,1)) ;Select King
                If _Sleep(500) Then Return
                Click($x, $y)
                If _Sleep(5000) Then Return ;  wait 5 seconds
                Click(68 + (72 * $num) + Random(-5,5,1), 595 + Random(-5,5,1)) ; before activate king power
        EndIf
EndFunc   ;==>dropKing

Func getQueenPos()
        ;   SetLog("Finding queen pos", $COLOR_BLUE)
        Local $pos = -1
        For $i = 0 To 8
                Local $troop = IdentifyTroopKind($i)
                If $troop = $eQueen Then
                        $pos = $i
                        ExitLoop
                EndIf
        Next
        Return $pos
EndFunc   ;==>getQueenPos

Func dropQueen($x = 10, $y = 10, $num = 2)
        If $num <> -1 Then
                ;         SetLog("Dropping Queen", $COLOR_BLUE)
                Click(68 + (72 * $num) + Random(-5,5,1), 595 + Random(-5,5,1)) ;Select Queen
                If _Sleep(500) Then Return
                Click($x, $y)
                If _Sleep(250) Then Return ;  wait 0.25 seconds
                Click(68 + (72 * $num) + Random(-5,5,1), 595 + Random(-5,5,1)) ; before activate queen power
        EndIf
EndFunc   ;==>dropQueen

 Func errorReturnHome()
		SetLog("Attempting to return home.", $COLOR_BLUE)
		Local $redX = _WaitForPixel(819, 17, 923, 21, Hex(0xF88488, 6), 5, 1) ;determines if gob attack is open, wait max 1 seconds
		If IsArray($redX) = True Then
				;SetLog("Found red X, clicking should return home.", $COLOR_BLUE)
				Click(823 + Random(-5,5,1),32 + Random(-5,5,1))
		Else
				Local $endNowButton = _WaitForPixel(68, 528, 72, 532, Hex(0xFEFCFC, 6), 5, 1) ;finds End Now button, wait max 1 seconds
				If IsArray($endNowButton) = True Then
						;SetLog("Click End Now/Surrender button.", $COLOR_BLUE)
						Click(70 + Random(-5,5,1), 530 + Random(-5,5,1)) ;End Battle button
				EndIf

				Local $okayButton = _WaitForPixel(513, 398, 517, 402, Hex(0x354217, 6), 5, 1) ;finds Okay button, wait max 1 seconds
				If IsArray($okayButton) = True Then
						;SetLog("Click Okay button.", $COLOR_BLUE)
						Click(515 + Random(-5,5,1), 400 + Random(-5,5,1)) ;Confirm button
				EndIf

				Local $returnButton = _WaitForPixel(426, 542, 430, 548, Hex(0xFFFFFF, 6), 5, 1) ;finds Return Home button, wait max 1 seconds
				If IsArray($returnButton) = True Then
						;SetLog("Click Return Home button.", $COLOR_BLUE)
						Click(428 + Random(-5,5,1), 544 + Random(-5,5,1)) ;return home button
				EndIf

		EndIf

		Local $homeScreen = _WaitForPixel(818, 178, 822, 182, Hex(0xD0EC7C, 6), 5, 10) ;Waits for main screen to load, wait max 10 seconds
		If IsArray($homeScreen) = True Then
				SetLog("Made it back home!", $COLOR_BLUE)
		Else
				ReturnHome(False,False)
		EndIf

EndFunc