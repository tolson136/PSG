/*wrvsr.p*/
/* Weekly Rolling VOlume */

/*      3//13/2018   TO    Changed SS layout */

DEFINE SHARED VARIABLE XCOM AS INTEGER FORMAT "ZZ".
DEFINE SHARED VARIABLE XDIV AS INTEGER FORMAT "ZZ".
DEFINE SHARED VARIABLE XCOM-N AS CHAR FORMAT "X(30)".
DEFINE SHARED VARIABLE XDIV-N AS CHAR FORMAT "X(30)".

DEFINE VARIABLE BEG#             AS DATE FORMAT "99/99/9999"
  LABEL "ENTER SATURDAY DATE FOR REPORT".
DEFINE VARIABLE T-PRT            AS LOGICAL LABEL "SUMMARY ONLY REPORT?".
DEFINE VARIABLE H-FREQ           AS CHAR FORMAT "X(10)".
DEFINE VARIABLE D2               AS DECIMAL FORMAT "9999.99".
DEFINE VARIABLE D3               AS DECIMAL FORMAT "9999".
DEFINE VARIABLE D4               AS DECIMAL FORMAT "9999.99".
DEFINE VARIABLE D5               AS INTEGER FORMAT "9999" LABEL "YEAR (4 DIGITS)".
DEFINE VARIABLE L-YEAR           AS LOGICAL.
DEFINE VARIABLE TICKS            AS INTEGER FORMAT "9999".
DEFINE VARIABLE F-TICK           AS LOGICAL.
DEFINE VARIABLE H-WEEK           AS INTEGER FORMAT "9".
DEFINE VARIABLE DY               AS INTEGER FORMAT "99".
DEFINE VARIABLE UP-LIM           AS INTEGER FORMAT "99".
DEFINE VARIABLE C-DATE           AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE T-DL             AS DECIMAL FORMAT "$->,>>>,>>>.99".
DEFINE VARIABLE T-BILL           AS DECIMAL FORMAT "$->,>>>,>>>.99".
DEFINE VARIABLE H-MON            AS CHARACTER FORMAT "X(10)".
DEFINE VARIABLE EXP-CHECK        AS CHARACTER FORMAT "XXX".
DEFINE VARIABLE HAR-DESP         AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE PrintDescription AS LOGICAL LABEL "INCLUDE DESCRIPTIONS ON REPORT ?".
DEFINE VARIABLE XSUB             AS INTEGER FORMAT "ZZ" LABEL "ENTER SUB-DIVISION #".
DEFINE VARIABLE XROUTE           AS INTEGER FORMAT "ZZ" LABEL "ENTER ROUTE #".
DEFINE VARIABLE xweek            AS INTEGER.
DEFINE VARIABLE xday             AS INTEGER.
DEFINE VARIABLE SheetCount       AS INT.
DEFINE VARIABLE DayOfWeek        AS CHAR.
DEFINE VARIABLE CodOnly          AS LOGICAL INIT NO LABEL "COD Only".
DEFINE VARIABLE ExcelCode        AS CHAR.
DEFINE VARIABLE FirstMonthDate   AS DATE NO-UNDO.
DEFINE VARIABLE LastMonthDate    AS DATE NO-UNDO.
DEFINE VARIABLE MonthName        AS CHAR NO-UNDO.
DEFINE VARIABLE DayDate          AS CHAR EXTENT 6 NO-UNDO.
DEFINE VARIABLE BlankLines       AS INT.

DEFINE VARIABLE chExcel          AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE chWorkbook       AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE chWorksheet      AS COM-HANDLE NO-UNDO.


DEF VAR OutputToExcel AS LOG INIT NO LABEL "To Excel?".

DEFINE NEW SHARED TEMP-TABLE RollVol1
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime FORMAT "XX:XX XX"
    FIELD EndTime LIKE pro-desp.endtime
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.

DEFINE NEW SHARED TEMP-TABLE RollVol2
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol3
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol4
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol5
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol6
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol7
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol8
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol9
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol10
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol11
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
DEFINE NEW SHARED TEMP-TABLE RollVol12
    FIELD Location AS CHAR
    FIELD Address AS CHAR
    FIELD City AS CHAR
    FIELD tICKET AS CHAR
    FIELD Freq AS CHAR
    FIELD DAY AS CHAR
    FIELD CompletedDate AS DATE
    FIELD StartTime LIKE pro-desp.starttime
    FIELD EndTime LIKE pro-desp.endtime    
    FIELD EmployeeName AS CHAR
    FIELD Vol AS DEC
    FIELD COD AS DEC
    FIELD Notes AS CHAR.
    
 
    
{slibooxml/slibxlsx.i}

{slib/slibos.i}

{slib/sliberr.i}

{include/stdutils.i}

IF (USERID = "LANDMARK") OR (USERID = "GARCIA")
THEN DO:
    MESSAGE "YOU ARE NOT AUTHORIZED TO RUN THIS PROCEDURE".
    RETURN.
END.
T-DL = 0.00.
T-BILL = 0.00.
DISPLAY SPACE(7)
"W E E K L Y   R O L L I N G   V O L U M E   S U B   &   R O U T E"
    SKIP(1) SPACE(20)
XCOM-N LABEL "COMPANY" SKIP(0) SPACE(20) XDIV-N LABEL "DIVISION"
SKIP(5) WITH FRAME A NO-BOX SIDE-LABELS.

UPDATE OutputToExcel skip(2)
    BEG# with frame a no-box side-labels.

IF OutputToExcel THEN UPDATE CodOnly LABEL "COD Only?" WITH FRAME a.

xday = weekday(beg#).
if xday <> 7 then do:
    message "Please enter a valid Saturday date".
    undo, retry.
end.

IF NOT OutputToExcel THEN DO:
   update SKIP(0) PrintDescription SKIP(0) T-PRT SKIP(2)
          XSUB SPACE(5) XROUTE WITH frame a NO-BOX SIDE-LABELS.
END.
ELSE ASSIGN xroute = 0. 

   if day(beg#) < 8 then xweek = 1.
if day(beg#) < 15 and day(beg#) > 7 then xweek = 2.
if day(beg#) < 22 and day(beg#) > 14 then xweek = 3.
if day(beg#) < 29 and day(beg#) > 21 then xweek = 4.
if day(beg#) > 28 and (month(beg#) = month(beg# - 28)) then xweek = 5.
hide.
IF LASTKEY = KEYCODE("F4") THEN LEAVE.
IF LASTKEY = KEYCODE("ESC") THEN LEAVE.

ASSIGN 
  FirstMonthDate  = DATE(MONTH(BEG#),1,YEAR(BEG#))
  LastMonthDate   = DATE(MONTH(BEG#),DaysInMonth(MONTH(BEG#),YEAR(BEG#)),YEAR(BEG#))
  MonthName       = ENTRY(MONTH(BEG#), "Jan,Feb,Mar,Apr,May,June,July,Aug,Sept,Oct,Nov,Dec")
  DayDate[1] = "Sat " + ENTRY(1,STRING(Beg#,"99/99/99"),"/")     + "/" + ENTRY(2,STRING(Beg#,"99/99/99"),"/")
  DayDate[2] = "Mon " + ENTRY(1,STRING(Beg# + 2,"99/99/99"),"/") + "/" + ENTRY(2,STRING(Beg# + 2,"99/99/99"),"/")
  DayDate[3] = "Tue " + ENTRY(1,STRING(Beg# + 3,"99/99/99"),"/") + "/" + ENTRY(2,STRING(Beg# + 3,"99/99/99"),"/")
  DayDate[4] = "Wed " + ENTRY(1,STRING(Beg# + 4,"99/99/99"),"/") + "/" + ENTRY(2,STRING(Beg# + 4,"99/99/99"),"/")
  DayDate[5] = "Thu " + ENTRY(1,STRING(Beg# + 5,"99/99/99"),"/") + "/" + ENTRY(2,STRING(Beg# + 5,"99/99/99"),"/")
  DayDate[6] = "Fri " + ENTRY(1,STRING(Beg# + 6,"99/99/99"),"/") + "/" + ENTRY(2,STRING(Beg# + 6,"99/99/99"),"/").


IF NOT OutputToExcel THEN do:
    OUTPUT TO PRINTER.
END.
ELSE DO:

END. /* OutPutToExcel; */
   MESSAGE COLOR red "Processing".
    FOR EACH PROPSL WHERE PROPSL.COMP# = XCOM AND
                          PROPSL.DIV# = XDIV  AND
                          ( Propsl.StartDate LE LastMonthDate OR Propsl.StartDate = ?) AND
                          ( Propsl.EndDate GE FirstMonthDate OR Propsl.EndDate = ?)
                          NO-LOCK BY PROPSL.C-NAME BY PROPSL.PROPSL#:
    FIND FIRST ACCT-RCV WHERE ACCT-RCV.COMP# = XCOM AND
                        ACCT-RCV.DIV# = XDIV AND
                        ACCT-RCV.CUST# = PROPSL.CUST# AND
                        ACCT-RCV.C-STATUS <> "I" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE ACCT-RCV THEN NEXT.
    IF TODAY + 90 >= ACCT-RCV.EXPIRE-DT THEN EXP-CHECK = "***".
    ELSE EXP-CHECK = "".
    FOR EACH PRO-DESP /* USE-INDEX INDX2 */
                      WHERE PRO-DESP.COMP# = XCOM AND
                            PRO-DESP.DIV# = XDIV AND
                            PRO-DESP.CUST# = ACCT-RCV.CUST# AND
                            PRO-DESP.PROPSL# = PROPSL.PROPSL# AND
                            PRO-DESP.SUB# = XSUB AND
                            PRO-DESP.ROUTE# = (IF xroute NE 0 THEN XROUTE ELSE pro-desp.route#)
                            NO-LOCK BY PRO-DESP.ITEM#:

       FIND FIRST AR-DESP WHERE AR-DESP.COMP# = XCOM AND
                                AR-DESP.DIV# = XDIV AND
                                AR-DESP.CUST# = ACCT-RCV.CUST# AND
                                AR-DESP.PROPSL# = PRO-DESP.PROPSL# AND
                                AR-DESP.ITEM# = PRO-DESP.ITEM# NO-LOCK NO-ERROR.
       IF NOT AVAILABLE AR-DESP
           THEN HAR-DESP = "NO DESCRIPTION AVAILABLE".
       ELSE HAR-DESP = AR-DESP.DESC01.

IF NOT OutputToExcel THEN DO:

   IF NOT PrintDescription THEN DO:
      FORM HEADER TODAY FORMAT "99/99/9999"
      "WEEKLY ROLLING VOLUME SUB & ROUTE LIST" AT 20 H-MON AT 70 SKIP(1)
      XCOM-N AT 01 XDIV-N AT 40 SKIP(1)
      "SUB-DIVISION" AT 20 XSUB "ROUTE" AT 50 XROUTE SKIP(1)
      "CUSTOMER" AT 1 "LOCATION" AT 36 "FREQUENCY" AT 60 SKIP(0)
      "TICKET #" AT 1 "BILLING" AT 61 "D/L" AT 76 SKIP(1)
      WITH FRAME X PAGE-TOP NO-BOX NO-LABELS NO-UNDERLINE.
      VIEW FRAME X.
   END.
   ELSE DO:
      FORM HEADER TODAY FORMAT "99/99/9999"
      "WEEKLY ROLLING VOLUME SUB & ROUTE LIST" AT 20 H-MON AT 70 SKIP(1)
      XCOM-N AT 01 XDIV-N AT 40 SKIP(1)
      "SUB-DIVISION" AT 20 XSUB "ROUTE" AT 50 XROUTE SKIP(1)
      "CUSTOMER" AT 1 "LOCATION" AT 36 "FREQUENCY" AT 60 SKIP(0)
      "BRIEF DESCRIPTION" AT 1 SKIP(0)
      "TICKET #" AT 1 "BILLING" AT 61 "D/L" AT 76 SKIP(1)
      WITH FRAME Y PAGE-TOP NO-BOX NO-LABELS NO-UNDERLINE.
      VIEW FRAME Y.
   END.
END.

      F-TICK = no.
      H-FREQ = "          ".
      IF PRO-DESP.FREQ = "DAILY" THEN DO:
              H-FREQ = "D".
              TICKS = 7.
              F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "TWO_TIMES_PER_WEEK" THEN DO:
          H-FREQ = "2XW".
          TICKS = 0.
          F-TICK = yes.
          REPEAT DY = 0 to 6:
              C-DATE = BEG# + DY.
              H-WEEK = WEEKDAY(C-DATE).
              IF H-WEEK = 1 AND PRO-DESP.WKDAY[2] THEN TICKS = TICKS + 1.
              IF H-WEEK = 2 AND PRO-DESP.WKDAY[3] THEN TICKS = TICKS + 1.
              IF H-WEEK = 3 AND PRO-DESP.WKDAY[4] THEN TICKS = TICKS + 1.
              IF H-WEEK = 4 AND PRO-DESP.WKDAY[5] THEN TICKS = TICKS + 1.
              IF H-WEEK = 5 AND PRO-DESP.WKDAY[6] THEN TICKS = TICKS + 1.
              IF H-WEEK = 6 AND PRO-DESP.WKDAY[7] THEN TICKS = TICKS + 1.
              IF H-WEEK = 7 AND PRO-DESP.WKDAY[1] THEN TICKS = TICKS + 1.
          END.
      END.
      IF PRO-DESP.FREQ = "THREE_TIMES_PER_WEEK" THEN DO:
          H-FREQ = "3XW".
          TICKS = 0.
          F-TICK = yes.
          REPEAT DY = 0 to 6:
              C-DATE = BEG# + DY.
              H-WEEK = WEEKDAY(C-DATE).
              IF H-WEEK = 1 AND PRO-DESP.WKDAY[2] THEN TICKS = TICKS + 1.
              IF H-WEEK = 2 AND PRO-DESP.WKDAY[3] THEN TICKS = TICKS + 1.
              IF H-WEEK = 3 AND PRO-DESP.WKDAY[4] THEN TICKS = TICKS + 1.
              IF H-WEEK = 4 AND PRO-DESP.WKDAY[5] THEN TICKS = TICKS + 1.
              IF H-WEEK = 5 AND PRO-DESP.WKDAY[6] THEN TICKS = TICKS + 1.
              IF H-WEEK = 6 AND PRO-DESP.WKDAY[7] THEN TICKS = TICKS + 1.
              IF H-WEEK = 7 AND PRO-DESP.WKDAY[1] THEN TICKS = TICKS + 1.
          END.
      END.
      IF PRO-DESP.FREQ = "FOUR_TIMES_PER_WEEK" THEN DO:
          H-FREQ = "4XW".
          TICKS = 0.
          F-TICK = yes.
          REPEAT DY = 0 to 6:
              C-DATE = BEG# + DY.
              H-WEEK = WEEKDAY(C-DATE).
              IF H-WEEK = 1 AND PRO-DESP.WKDAY[2] THEN TICKS = TICKS + 1.
              IF H-WEEK = 2 AND PRO-DESP.WKDAY[3] THEN TICKS = TICKS + 1.
              IF H-WEEK = 3 AND PRO-DESP.WKDAY[4] THEN TICKS = TICKS + 1.
              IF H-WEEK = 4 AND PRO-DESP.WKDAY[5] THEN TICKS = TICKS + 1.
              IF H-WEEK = 5 AND PRO-DESP.WKDAY[6] THEN TICKS = TICKS + 1.
              IF H-WEEK = 6 AND PRO-DESP.WKDAY[7] THEN TICKS = TICKS + 1.
              IF H-WEEK = 7 AND PRO-DESP.WKDAY[1] THEN TICKS = TICKS + 1.
          END.
      END.
      IF PRO-DESP.FREQ = "FIVE_TIMES_PER_WEEK" THEN DO:
          H-FREQ = "5XW".
          TICKS = 0.
          F-TICK = yes.
          REPEAT DY = 0 to 6:
              C-DATE = BEG# + DY.
              H-WEEK = WEEKDAY(C-DATE).
              IF H-WEEK = 1 AND PRO-DESP.WKDAY[2] THEN TICKS = TICKS + 1.
              IF H-WEEK = 2 AND PRO-DESP.WKDAY[3] THEN TICKS = TICKS + 1.
              IF H-WEEK = 3 AND PRO-DESP.WKDAY[4] THEN TICKS = TICKS + 1.
              IF H-WEEK = 4 AND PRO-DESP.WKDAY[5] THEN TICKS = TICKS + 1.
              IF H-WEEK = 5 AND PRO-DESP.WKDAY[6] THEN TICKS = TICKS + 1.
              IF H-WEEK = 6 AND PRO-DESP.WKDAY[7] THEN TICKS = TICKS + 1.
              IF H-WEEK = 7 AND PRO-DESP.WKDAY[1] THEN TICKS = TICKS + 1.
          END.
      END.
      IF PRO-DESP.FREQ = "SIX_TIMES_PER_WEEK" THEN DO:
          H-FREQ = "6XW".
          TICKS = 0.
          F-TICK = yes.
          REPEAT DY = 0 to 6:
              C-DATE = BEG# + DY.
              H-WEEK = WEEKDAY(C-DATE).
              IF H-WEEK = 1 AND PRO-DESP.WKDAY[2] THEN TICKS = TICKS + 1.
              IF H-WEEK = 2 AND PRO-DESP.WKDAY[3] THEN TICKS = TICKS + 1.
              IF H-WEEK = 3 AND PRO-DESP.WKDAY[4] THEN TICKS = TICKS + 1.
              IF H-WEEK = 4 AND PRO-DESP.WKDAY[5] THEN TICKS = TICKS + 1.
              IF H-WEEK = 5 AND PRO-DESP.WKDAY[6] THEN TICKS = TICKS + 1.
              IF H-WEEK = 6 AND PRO-DESP.WKDAY[7] THEN TICKS = TICKS + 1.
              IF H-WEEK = 7 AND PRO-DESP.WKDAY[1] THEN TICKS = TICKS + 1.
          END.
      END.
      IF PRO-DESP.FREQ = "WEEKLY" THEN DO:
          H-FREQ = "W".
          TICKS = 0.
          F-TICK = yes.
          REPEAT DY = 0 to 6:
              C-DATE = BEG# + DY.
              H-WEEK = WEEKDAY(C-DATE).
              IF H-WEEK = 1 AND PRO-DESP.WKDAY[2] THEN TICKS = TICKS + 1.
              IF H-WEEK = 2 AND PRO-DESP.WKDAY[3] THEN TICKS = TICKS + 1.
              IF H-WEEK = 3 AND PRO-DESP.WKDAY[4] THEN TICKS = TICKS + 1.
              IF H-WEEK = 4 AND PRO-DESP.WKDAY[5] THEN TICKS = TICKS + 1.
              IF H-WEEK = 5 AND PRO-DESP.WKDAY[6] THEN TICKS = TICKS + 1.
              IF H-WEEK = 6 AND PRO-DESP.WKDAY[7] THEN TICKS = TICKS + 1.
              IF H-WEEK = 7 AND PRO-DESP.WKDAY[1] THEN TICKS = TICKS + 1.
          END.
      END.
      IF PRO-DESP.FREQ = "EVERY_TWO_WEEKS" THEN DO:
          H-FREQ = "2W".
          TICKS = 0.
          F-TICK = yes.
          IF PRO-DESP.CL-DATE + 14 >= beg# AND
             PRO-DESP.CL-DATE + 14 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 28 >= beg# AND
             PRO-DESP.CL-DATE + 28 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 42 >= beg# AND
             PRO-DESP.CL-DATE + 42 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 56 >= beg# AND
             PRO-DESP.CL-DATE + 56 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 70 >= beg# AND
             PRO-DESP.CL-DATE + 70 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE =01/01/1901 THEN TICKS = 2.
      END.
      IF PRO-DESP.FREQ = "EVERY_THREE_WEEKS" THEN DO:
          H-FREQ = "3W".
          TICKS = 0.
          F-TICK = yes.
          IF PRO-DESP.CL-DATE + 21 >= beg# AND
             PRO-DESP.CL-DATE + 21 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 42 >= beg# AND
             PRO-DESP.CL-DATE + 42 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 63 >= beg# AND
             PRO-DESP.CL-DATE + 63 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE =01/01/1901 THEN TICKS = 1.
      END.
      IF PRO-DESP.FREQ = "EVERY_FOUR_WEEKS" THEN DO:
          H-FREQ = "4W".
          TICKS = 0.
          F-TICK = yes.
          IF PRO-DESP.CL-DATE + 28 >= beg# AND
             PRO-DESP.CL-DATE + 28 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 56 >= beg# AND
             PRO-DESP.CL-DATE + 56 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 84 >= beg# AND
             PRO-DESP.CL-DATE + 84 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE =01/01/1901 THEN TICKS = 1.
      END.

      IF PRO-DESP.FREQ = "EVERY_FIVE_WEEKS" THEN DO:
          H-FREQ = "5W".
          TICKS = 0.
          F-TICK = yes.
          IF PRO-DESP.CL-DATE + 35 >= beg# AND
             PRO-DESP.CL-DATE + 35 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 70 >= beg# AND
             PRO-DESP.CL-DATE + 70 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE =01/01/1901 THEN TICKS = 1.
      END.
      IF PRO-DESP.FREQ = "EVERY_SIX_WEEKS" THEN DO:
          H-FREQ = "6W".
          TICKS = 0.
          F-TICK = yes.
          IF PRO-DESP.CL-DATE + 42 >= beg# AND
             PRO-DESP.CL-DATE + 42 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 84 >= beg# AND
             PRO-DESP.CL-DATE + 84 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE =01/01/1901 THEN TICKS = 1.
      END.
      IF PRO-DESP.FREQ = "EVERY_EIGHT_WEEKS" THEN DO:
          H-FREQ = "8W".
          TICKS = 0.
          F-TICK = yes.
          IF PRO-DESP.CL-DATE + 56 >= beg# AND
             PRO-DESP.CL-DATE + 56 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE + 112 >= beg# AND
             PRO-DESP.CL-DATE + 112 <= beg# + 6
             THEN TICKS = TICKS + 1.
          IF PRO-DESP.CL-DATE =01/01/1901 THEN TICKS = 1.
      END.
      IF PRO-DESP.FREQ = "MONTHLY"  and pro-desp.wks[xweek] THEN DO:
          H-FREQ = "M".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "QUARTERLY" AND PRO-DESP.MTH[month(BEG#)] and 
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "Q".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "TWO_TIMES_PER_MONTH" and pro-desp.wks[xweek] THEN DO:
          H-FREQ = "2XM".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "ANNUAL" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "A".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "TWO_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "2XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "THREE_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "3XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "FOUR_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "4XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "FIVE_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "5XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "SIX_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "6XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "SEVEN_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "7XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "EIGHT_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "8XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "NINE_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "9XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "TEN_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "10XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "ELEVEN_TIMES_PER_YEAR" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "11XYR".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "EVERY_TWO_YEARS" THEN
          IF (D5 - YEAR(PRO-DESP.CL-DATE) = 2) AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
              H-FREQ = "1X2YR".
              TICKS = 1.
              F-TICK = yes.
          END.
      IF PRO-DESP.FREQ = "EVERY_THREE_YEARS" THEN
          IF (D5 - YEAR(PRO-DESP.CL-DATE) = 3) AND PRO-DESP.MTH[month(BEG#)] and
              pro-desp.wks[xweek] THEN DO:
              H-FREQ = "1X3YR".
              TICKS = 1.
              F-TICK = yes.
          END.
      IF PRO-DESP.FREQ = "EVERY_FOUR_YEARS" THEN
          IF (D5 - YEAR(PRO-DESP.CL-DATE) = 4) AND PRO-DESP.MTH[month(BEG#)] and
              pro-desp.wks[xweek] THEN DO:
              H-FREQ = "1X4YR".
              TICKS = 1.
              F-TICK = yes.
          END.
      IF PRO-DESP.FREQ = "EVERY_FIVE_YEARS" THEN
          IF (D5 - YEAR(PRO-DESP.CL-DATE) = 5) AND PRO-DESP.MTH[month(BEG#)] and
              pro-desp.wks[xweek] THEN DO:
              H-FREQ = "1X5YR".
              TICKS = 1.
              F-TICK = yes.
          END.
      IF PRO-DESP.FREQ = "EVERY_EIGHTEEN_MONTHS" THEN
          IF PRO-DESP.CL-DATE + 549 >= BEG# AND
             PRO-DESP.CL-DATE + 549 <= BEG# + 6 and pro-desp.mth[month(beg#)] and
             pro-desp.wks[xweek] THEN DO:
               TICKS = 1.
               H-FREQ = "1X18M".
               F-TICK = yes.
          END.
      IF PRO-DESP.FREQ = "SPECIAL_CLEANING" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "SPCL".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "ON_CALL" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "OC".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "INITIAL_CLEANING" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "IC".
          TICKS = 1.
          F-TICK = yes.
      END.
      IF PRO-DESP.FREQ = "ONE_TIME_CLEANING" AND PRO-DESP.MTH[month(BEG#)] and
          pro-desp.wks[xweek] THEN DO:
          H-FREQ = "1X".
          TICKS = 1.
          F-TICK = yes.
      END.
    IF F-TICK THEN DO:
      REPEAT DY = 1 TO TICKS:
      T-DL = T-DL + PRO-DESP.DL.
      T-BILL = T-BILL + PRO-DESP.AMT.
 
      IF NOT OutputToExcel THEN DO:
         IF NOT T-PRT THEN DO:
            IF PrintDescription THEN DO:
               DISPLAY ACCT-RCV.C-NAME SPACE(4)
                 PROPSL.L-NAME SPACE(6)
                 pro-desp.freq format "x(21)" SKIP(0)
                 HAR-DESP SKIP(0)
                 STRING(PRO-DESP.COMP#, ">>") + "-" +
                 TRIM(STRING(PRO-DESP.DIV#, ">>")) + "-" +
                 TRIM(STRING(PRO-DESP.CUST#, ">>>>>>>>>>")) + "-" +
                 TRIM(STRING(PRO-DESP.PROPSL#, ">>>>>>>>>>")) + "-" +
                 TRIM(STRING(PRO-DESP.ITEM#, ">>>>")) + "-" +
                 TRIM(STRING(month(BEG#), ">>")) + "-" +
                 trim(string(xweek, ">>")) + "-" +
                 TRIM(STRING(DY, ">>"))
                   FORMAT "X(35)" SPACE(20)
                 PRO-DESP.AMT FORMAT "$->>>,>>>.99"
                 PRO-DESP.DL FORMAT "$->>>,>>>.99" SKIP(1)
                    WITH FRAME P NO-BOX NO-LABELS.
            END.
            ELSE DO:
               DISPLAY ACCT-RCV.C-NAME SPACE(4)
                 PROPSL.L-NAME SPACE(6)
                 pro-desp.freq format "x(21)" SKIP(0)
                 STRING(PRO-DESP.COMP#, ">>") + "-" +
                 TRIM(STRING(PRO-DESP.DIV#, ">>")) + "-" +
                  TRIM(STRING(PRO-DESP.CUST#, ">>>>>>>>>>")) + "-" +
                 TRIM(STRING(PRO-DESP.PROPSL#, ">>>>>>>>>>")) + "-" +
                 TRIM(STRING(PRO-DESP.ITEM#, ">>>>")) + "-" +
                 TRIM(STRING(month(BEG#), ">>")) + "-" +
                 trim(string(xweek, ">>")) + "-" +
                 TRIM(STRING(DY, ">>"))
                   FORMAT "X(35)" SPACE(20)
                 PRO-DESP.AMT FORMAT "$->>>,>>>.99"
                 PRO-DESP.DL FORMAT "$->>>,>>>.99" SKIP(1)
                  WITH FRAME Q NO-BOX NO-LABELS.
            END.
         END. /* if not OutputToExcel */
      END.
      ELSE DO:
         RUN DayOfWeek.p (INPUT pro-desp.wkday, OUTPUT DayOfWeek).
         IF pro-desp.route# = 1 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            
            /*RUN DayOfWeek.p (INPUT pro-desp.wkday, OUTPUT DayOfWeek).*/
            CREATE RollVol1.
            ASSIGN RollVol1.Location = propsl.l-Name
                   RollVol1.Address = propsl.laddr01
                   RollVol1.City = propsl.laddr02
                   RollVol1.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol1.Freq = h-freq
                   RollVol1.DAY = DayOfWeek
                   RollVol1.CompletedDate = ?
                   RollVol1.StartTime = pro-desp.starttime
                   RollVol1.EndTime = pro-desp.endtime
                   RollVol1.EmployeeName  = ""
                   RollVol1.Vol = pro-desp.amt
                   RollVol1.COD = pro-desp.cod-amt
                   RollVol1.Notes = ""
                   .
         END.
         IF pro-desp.route# = 2 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol2.
            ASSIGN RollVol2.Location = propsl.l-Name
                   RollVol2.Address = propsl.laddr01
                   RollVol2.City = propsl.laddr02
                   RollVol2.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol2.Freq = h-freq
                   RollVol2.DAY = DayOfWeek
                   RollVol2.CompletedDate = ?
                   RollVol2.StartTime = pro-desp.starttime
                   RollVol2.EndTime = pro-desp.endtime
                   RollVol2.EmployeeName  = ""
                   RollVol2.Vol = pro-desp.amt
                   RollVol2.COD = pro-desp.cod-amt
                   RollVol2.Notes = ""
                   .
         END.
         IF pro-desp.route# = 3 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol3.
            ASSIGN RollVol3.Location = propsl.l-Name
                   RollVol3.Address = propsl.laddr01
                   RollVol3.City = propsl.laddr02
                   RollVol3.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol3.Freq = h-freq
                   RollVol3.DAY = DayOfWeek
                   RollVol3.CompletedDate = ?
                   RollVol3.StartTime = pro-desp.starttime
                   RollVol3.EndTime = pro-desp.endtime
                   RollVol3.EmployeeName  = ""
                   RollVol3.Vol = pro-desp.amt
                   RollVol3.COD = pro-desp.cod-amt
                   RollVol3.Notes = ""
                   .
         END.
         IF pro-desp.route# = 4 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol4.
            ASSIGN RollVol4.Location = propsl.l-Name
                   RollVol4.Address = propsl.laddr01
                   RollVol4.City = propsl.laddr02
                   RollVol4.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol4.Freq = h-freq
                   RollVol4.DAY = DayOfWeek
                   RollVol4.CompletedDate = ?
                   RollVol4.StartTime = pro-desp.starttime
                   RollVol4.EndTime = pro-desp.endtime
                   RollVol4.EmployeeName  = ""
                   RollVol4.Vol = pro-desp.amt
                   RollVol4.COD = pro-desp.cod-amt
                   RollVol4.Notes = ""
                   .
         END.
         IF pro-desp.route# = 5 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol5.
            ASSIGN RollVol5.Location = propsl.l-Name
                   RollVol5.Address = propsl.laddr01
                   RollVol5.City = propsl.laddr02
                   RollVol5.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol5.Freq = h-freq
                   RollVol5.DAY = DayOfWeek
                   RollVol5.CompletedDate = ?
                   RollVol5.StartTime = pro-desp.starttime
                   RollVol5.EndTime = pro-desp.endtime
                   RollVol5.EmployeeName  = ""
                   RollVol5.Vol = pro-desp.amt
                   RollVol5.COD = pro-desp.cod-amt
                   RollVol5.Notes = ""
                   .
         END.
         IF pro-desp.route# = 6 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol6.
            ASSIGN RollVol6.Location = propsl.l-Name
                   RollVol6.Address = propsl.laddr01
                   RollVol6.City = propsl.laddr02
                   RollVol6.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol6.Freq = h-freq
                   RollVol6.DAY = DayOfWeek
                   RollVol6.CompletedDate = ?
                   RollVol6.StartTime = pro-desp.starttime
                   RollVol6.EndTime = pro-desp.endtime
                   RollVol6.EmployeeName  = ""
                   RollVol6.Vol = pro-desp.amt
                   RollVol6.COD = pro-desp.cod-amt
                   RollVol6.Notes = ""
                   .
         END.
         IF pro-desp.route# = 7 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol7.
            ASSIGN RollVol7.Location = propsl.l-Name
                   RollVol7.Address = propsl.laddr01
                   RollVol7.City = propsl.laddr02
                   RollVol7.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol7.Freq = h-freq
                   RollVol7.DAY = DayOfWeek
                   RollVol7.CompletedDate = ?
                   RollVol7.StartTime = pro-desp.starttime
                   RollVol7.EndTime = pro-desp.endtime
                   RollVol7.EmployeeName  = ""
                   RollVol7.Vol = pro-desp.amt
                   RollVol7.COD = pro-desp.cod-amt
                   RollVol7.Notes = ""
                   .
         END.
         IF pro-desp.route# = 8 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol8.
            ASSIGN RollVol8.Location = propsl.l-Name
                   RollVol8.Address = propsl.laddr01
                   RollVol8.City = propsl.laddr02
                   RollVol8.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol8.Freq = h-freq
                   RollVol8.DAY = DayOfWeek
                   RollVol8.CompletedDate = ?
                   RollVol8.StartTime = pro-desp.starttime
                   RollVol8.EndTime = pro-desp.endtime
                   RollVol8.EmployeeName  = ""
                   RollVol8.Vol = pro-desp.amt
                   RollVol8.COD = pro-desp.cod-amt
                   RollVol8.Notes = ""
                   .
         END.
         IF pro-desp.route# = 9 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol9.
            ASSIGN RollVol9.Location = propsl.l-Name
                   RollVol9.Address = propsl.laddr01
                   RollVol9.City = propsl.laddr02
                   RollVol9.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol9.Freq = h-freq
                   RollVol9.DAY = DayOfWeek
                   RollVol9.CompletedDate = ?
                   RollVol9.StartTime = pro-desp.starttime
                   RollVol9.EndTime = pro-desp.endtime
                   RollVol9.EmployeeName  = ""
                   RollVol9.Vol = pro-desp.amt
                   RollVol9.COD = pro-desp.cod-amt
                   RollVol9.Notes = ""
                   .
         END.
         IF pro-desp.route# = 10 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol10.
            ASSIGN RollVol10.Location = propsl.l-Name
                   RollVol10.Address = propsl.laddr01
                   RollVol10.City = propsl.laddr02
                   RollVol10.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol10.Freq = h-freq
                   RollVol10.DAY = DayOfWeek
                   RollVol10.CompletedDate = ?
                   RollVol10.StartTime = pro-desp.starttime
                   RollVol10.EndTime = pro-desp.endtime
                   RollVol10.EmployeeName  = ""
                   RollVol10.Vol = pro-desp.amt
                   RollVol10.COD = pro-desp.cod-amt
                   RollVol10.Notes = ""
                   .
         END.
         IF pro-desp.route# = 11 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol11.
            ASSIGN RollVol11.Location = propsl.l-Name
                   RollVol11.Address = propsl.laddr01
                   RollVol11.City = propsl.laddr02
                   RollVol11.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol11.Freq = h-freq
                   RollVol11.DAY = DayOfWeek
                   RollVol11.CompletedDate = ?
                   RollVol11.StartTime = pro-desp.starttime
                   RollVol11.EndTime = pro-desp.endtime
                   RollVol11.EmployeeName  = ""
                   RollVol11.Vol = pro-desp.amt
                   RollVol11.COD = pro-desp.cod-amt
                   RollVol11.Notes = ""
                   .
         END.
         IF pro-desp.route# = 12 THEN DO:
            IF CodOnly AND pro-desp.cod-amt = 0 THEN NEXT.
            CREATE RollVol12.
            ASSIGN RollVol12.Location = propsl.l-Name
                   RollVol12.Address = propsl.laddr01
                   RollVol12.City = propsl.laddr02
                   RollVol12.tICKET = string(pro-desp.propsl#) + "-" + string(pro-desp.item#)
                   RollVol12.Freq = h-freq
                   RollVol12.DAY = DayOfWeek
                   RollVol12.CompletedDate = ?
                   RollVol12.StartTime = pro-desp.starttime
                   RollVol12.EndTime = pro-desp.endtime
                   RollVol12.EmployeeName  = ""
                   RollVol12.Vol = pro-desp.amt
                   RollVol12.COD = pro-desp.cod-amt
                   RollVol12.Notes = ""
                   .
         END.         
END.

END.
END.
END.
END.
IF T-PRT THEN DO:
      FORM HEADER "ROLLING VOLUME SUB & ROUTE LIST" AT 24 H-MON AT 70 SKIP(1)
      XCOM-N AT 01 XDIV-N AT 40 SKIP(1)
      "SUB-DIVISION" AT 20 XSUB "ROUTE" AT 50 XROUTE SKIP(1)
      "CUSTOMER" AT 1 "LOCATION" AT 36 "FREQUENCY" AT 60 SKIP(0)
      "TICKET #" AT 1 "BILLING" AT 61 "D/L" AT 76 SKIP(1)
      WITH FRAME XX PAGE-TOP NO-BOX NO-LABELS NO-UNDERLINE.
      VIEW FRAME XX.
 END.
      DISPLAY SKIP(1) SPACE(51) T-BILL T-DL WITH NO-BOX NO-LABELS.
IF OutputToExcel THEN DO:
   REPEAT BlankLines = 1 to 10:
       CREATE RollVol1.
       CREATE RollVol2.
       CREATE RollVol3.
       CREATE RollVol4.
       CREATE RollVol5.
       CREATE RollVol6.
       CREATE RollVol7.
       CREATE RollVol8.
       CREATE RollVol9.
       CREATE RollVol10.
       CREATE RollVol11.
       CREATE RollVol12.
   END.
END.

IF OutputToExcel THEN RUN REPLACE_BASIC.


PROCEDURE REPLACE_BASIC:
/**
 * replace_basic.p -
 *
 * (c) Copyright ABC Alon Blich Consulting Tech Ltd.
 *
 * Contact Information
 * Email: alonblich@gmail.com
 * Phone: +972-54-218-8086
 */



define var cError       as char no-undo.
define var cErrorMsg    as char no-undo.
define var cStackTrace  as char no-undo.
DEF VAR FILENAME AS CHAR NO-UNDO.

/* Catch and handle any thrown exceptions */

{slib/err_try}:

    /* 1. Every file starts out as a template */

    run xlsx_copyTemplate(

        input "stXlsx",                                 /* Stream name */
        input "template\rollvoltab6.xlsx" ). /* Template file */

/* The field columns location and ranges are defined in Excel, using named ranges. 
       You can create an Excel named range quickly by typing in the Excel name box (to the left of the formula bar). 

        1. Select the cell(s) to be named 
        2. Click in the Excel name box (to the left of the formula bar)
        3. Type a one-word name for the list, for example: ItemNum
        4. Press the Enter key.
      
       Another way to create and also edit and delete Excel named ranges is to use the Excel define name dialog box.
       In the Excel menu bar - Insert > Name > Define. */


    /* 2. Replace template data with temp-table data */

    run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol1:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location1       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address1        = Address,"
            + "City1           = City,"
            + "Ticket1         = Ticket,"
            + "Freq1           = Freq,"
            + "Employee1       = EmployeeName,"
            + "Volume1         = Vol,"
            + "Cash1           = COD,"
            + "Notes1          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol2:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location2       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address2        = Address,"
            + "City2           = City,"
            + "Ticket2         = Ticket,"
            + "Freq2           = Freq,"            
            + "Employee2       = EmployeeName,"
            + "Volume2         = Vol,"
            + "Cash2           = COD,"
            + "Notes2          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(
        
        input "stXlsx",                                 /* Stream name */
        input buffer RollVol3:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location3       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address3        = Address,"
            + "City3           = City,"
            + "Ticket3         = Ticket,"
            + "Freq3           = Freq,"          
            + "Employee3   = EmployeeName,"
            + "Volume3            = Vol,"
            + "Cash3            = COD,"
            + "Notes3          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol4:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location4       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address4        = Address,"
            + "City4           = City,"
            + "Ticket4         = Ticket,"
            + "Freq4           = Freq,"
            + "Employee4   = EmployeeName,"
            + "Volume4            = Vol,"
            + "Cash4            = COD,"
            + "Notes4          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol5:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location5       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address5        = Address,"
            + "City5           = City,"
            + "Ticket5         = Ticket,"
            + "Freq5           = Freq,"
            + "Employee5   = EmployeeName,"
            + "Volume5            = Vol,"
            + "Cash5            = COD,"
            + "Notes5          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol6:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location6       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address6        = Address,"
            + "City6           = City,"
            + "Ticket6         = Ticket,"
            + "Freq6           = Freq,"
            + "Employee6   = EmployeeName,"
            + "Volume6            = Vol,"
            + "Cash6            = COD,"
            + "Notes6          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol7:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location7       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address7        = Address,"
            + "City7           = City,"
            + "Ticket7         = Ticket,"
            + "Freq7           = Freq,"
            + "Employee7   = EmployeeName,"
            + "Volume7            = Vol,"
            + "Cash7            = COD,"
            + "Notes7          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

        run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol8:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location8       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address8        = Address,"
            + "City8           = City,"
            + "Ticket8         = Ticket,"
            + "Freq8           = Freq,"
            + "Employee8   = EmployeeName,"
            + "Volume8            = Vol,"
            + "Cash8            = COD,"
            + "Notes8          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

                run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol9:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location9       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address9        = Address,"
            + "City9           = City,"
            + "Ticket9         = Ticket,"
            + "Freq9           = Freq,"
            + "Employee9   = EmployeeName,"
            + "Volume9            = Vol,"
            + "Cash9            = COD,"
            + "Notes9          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

     run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol10:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location10       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address10        = Address,"
            + "City10           = City,"
            + "Ticket10         = Ticket,"
            + "Freq10           = Freq,"
            + "Employee10       = EmployeeName,"
            + "Volume10         = Vol,"
            + "Cash10           = COD,"
            + "Notes10          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

      run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol11:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location11       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address11        = Address,"
            + "City11           = City,"
            + "Ticket11         = Ticket,"
            + "Freq11           = Freq,"
            + "Employee11   = EmployeeName,"
            + "Volume11            = Vol,"
            + "Cash11            = COD,"
            + "Notes11          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

     run xlsx_replaceLongRange(

        input "stXlsx",                                 /* Stream name */
        input buffer RollVol12:handle,                       /* Dataset handle or temp-table handle or query handle or buffer handle */
        input "Location12       = Location,"                /* <named range> = <buffer field> mapping */
            + "Address12        = Address,"
            + "City12           = City,"
            + "Ticket12         = Ticket,"
            + "Freq12           = Freq,"
            + "Employee12       = EmployeeName,"
            + "Volume12         = Vol,"
            + "Cash12           = COD,"
            + "Notes12          = Notes"
            
            ,
        input "",                                       /* Buffer can-do list */
        input "" ).                                     /* Field  can-do list */

    /* 3. save file */
    FILENAME = os_getNextFile( "c:\rollvol\RollingVolume-" + "All Routes Week " + "-" + string(xweek) + ".xlsx" ). 
    run xlsx_save(

        input "stXlsx",
        input FILENAME).

           /* os_getNextFile( ) adds a counter to the file name incase the file already exists */

{slib/err_catch cError cErrorMsg cStackTrace}:

    message
        cErrorMsg
        skip(1)
        cStackTrace
    view-as alert-box.

{slib/err_end}.

   /* Open file to add headers */
create "Excel.Application" chExcel.
chWorkbook  = chExcel:Workbooks.
chExcel:Workbooks:open(FILENAME).

REPEAT SheetCount = 1 TO 12:
   chWorkSheet = chExcel:Sheets:Item(SheetCount).
   chWorkSheet:activate.
   chExcel:SELECTION:Value =  "Route " + 
                              string(SheetCount)  +
                              " - Summary ". 
   chExcel:Selection:Offset(0,1):Select.                           
   chExcel:SELECTION:Value =  MonthName           + 
                              " Week "            +
                              STRING(XWeek).       
   chExcel:Selection:Offset(0,1):Select.
   chExcel:SELECTION:Value =  IF CodOnly THEN " COD Only"
                              ELSE "".
      
   chExcel:SELECTION:Offset(1,3):SELECT.
   chExcel:SELECTION:VALUE = DayDate[1].
   chExcel:SELECTION:Offset(0,1):SELECT.
   chExcel:SELECTION:VALUE = DayDate[2].
   chExcel:SELECTION:Offset(0,1):SELECT.
   chExcel:SELECTION:VALUE = DayDate[3].
   chExcel:SELECTION:Offset(0,1):SELECT.
   chExcel:SELECTION:VALUE = DayDate[4].
   chExcel:SELECTION:Offset(0,1):SELECT.
   chExcel:SELECTION:VALUE = DayDate[5].
   chExcel:SELECTION:Offset(0,1):SELECT.
   chExcel:SELECTION:VALUE = DayDate[6].
   
   /***********************
   chExcel:SELECTION:Offset(0,13):SELECT.
   chExcel:SELECTION:VALUE = "Sat".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"1-Sat~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"1-Sat~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(p2:p3)'.
   chExcel:SELECTION:VALUE = ExcelCode.

   chExcel:SELECTION:Offset(-3,1):SELECT.
   chExcel:SELECTION:VALUE = "Sun".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"2-Sun~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"2-Sun~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(q2:q3)'.
   chExcel:SELECTION:VALUE = ExcelCode.

   chExcel:SELECTION:Offset(-3,1):SELECT.
   chExcel:SELECTION:VALUE = "Mon".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"3-Mon~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"3-Mon~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode. 
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(r2:r3)'.
   chExcel:SELECTION:VALUE = ExcelCode.

   chExcel:SELECTION:Offset(-3,1):SELECT.
   chExcel:SELECTION:VALUE = "Tue".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"4-Tue~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"4-Tue~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode. 
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(s2:s3)'.
   chExcel:SELECTION:VALUE = ExcelCode.

   chExcel:SELECTION:Offset(-3,1):SELECT.
   chExcel:SELECTION:VALUE = "Wed".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"5-Wed~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"5-Wed~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode. 
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(t2:t3)'.
   chExcel:SELECTION:VALUE = ExcelCode.

   chExcel:SELECTION:Offset(-3,1):SELECT.
   chExcel:SELECTION:VALUE = "Thu".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"6-Thu~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"6-Thu~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode. 
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(u2:u3)'.
   chExcel:SELECTION:VALUE = ExcelCode.

   chExcel:SELECTION:Offset(-3,1):SELECT.
   chExcel:SELECTION:VALUE = "Fri".
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"7-Fri~",Volume' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode.  
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUMIF(Dayw' + STRING(SheetCount) + ',~"7-Fri~",Cash' + STRING(SheetCount)+ ')'.
   chExcel:SELECTION:VALUE = ExcelCode. 
   chExcel:SELECTION:Offset(1,0):SELECT.
   ExcelCode = '=SUM(v2:v3)'.
   chExcel:SELECTION:VALUE = ExcelCode.
   ***************************/
   /*****************************
   chExcel:Range("P1:V4"):Style = "Comma".
   chExcel:Range("P1:V4"):Interior:ColorIndex = 42.
   chExcel:Range("P1:V4"):Borders(5):LineStyle = -4142.
   chExcel:Range("P1:V4"):Borders(6):LineStyle = -4142.
   chExcel:Range("P1:V4"):Borders(7):WEIGHT = 2.
   chExcel:Range("P1:V4"):Borders(7):ColorIndex = 0.
   chExcel:Range("P1:V4"):Borders(8):LineStyle = 1.
   chExcel:Range("P1:V4"):Borders(8):WEIGHT = 2.
   chExcel:Range("P1:V4"):Borders(8):ColorIndex = 0.
   chExcel:Range("P1:V4"):Borders(9):LineStyle = 1.
   chExcel:Range("P1:V4"):Borders(9):WEIGHT = 2.
   chExcel:Range("P1:V4"):Borders(9):ColorIndex = 0.
   chExcel:Range("P1:V4"):Borders(10):LineStyle = 1.
   chExcel:Range("P1:V4"):Borders(10):WEIGHT = 2.
   chExcel:Range("P1:V4"):Borders(10):ColorIndex = 0.
   chExcel:Range("P1:V4"):Borders(11):LineStyle = 1.
   chExcel:Range("P1:V4"):Borders(11):WEIGHT = 2.
   chExcel:Range("P1:V4"):Borders(11):ColorIndex = 0.
   chExcel:Range("P1:V4"):Borders(12):LineStyle = 1.
   chExcel:Range("P1:V4"):Borders(12):WEIGHT = 2.
   chExcel:Range("P1:V4"):Borders(12):ColorIndex = 0.
   chExcel:Range("P1:V4"):Font:Bold = TRUE.
   chExcel:Range("P1:V4"):Font:Bold = TRUE.   
   chWorksheet:Range ("m:m"):ColumnWidth=8.
   ***************************/
   chWorksheet:Range ("a1:e1"):SELECT.
   chWorksheet:Columns:AutoFit.
   chWorksheet:Range ("f1:k1"):SELECT.
   chWorksheet:Columns:AutoFit.
   chWorksheet:Range ("o:o"):ColumnWidth=22. /* Notes */
   /*chWorksheet:Range ("p:v"):ColumnWidth=8.*/
END.
chExcel:Visible = TRUE.
MESSAGE "".

END.
