DEFINE VARIABLE SELECTION AS CHAR FORMAT "X".
DEF SHARED VAR XPROG AS LOGICAL.
DEF SHARED VAR XOPR AS CHAR FORMAT "XXX".
IF (USERID = "OPERATIONS") OR (USERID = "LANDMARK") OR (USERID = "GARCIA")
THEN DO:
    MESSAGE "YOU ARE NOT AUTHORIZED TO RUN THIS PROCEDURE".
    RETURN.
END.
REPEAT:
    FORM
                "              OLD TYME SOLUTIONS             "
        SKIP(1) "A.) GENERATE ORDERS FROM COMPLETED JOB ORDERS"
        SKIP(0) "B.) PRINT JOB ORDER AUDIT LIST"
        SKIP(1) "C.) PRINT INVOICES FROM JOB ORDERS"
        SKIP(0) "D.) REPRINT AN INVOICE"
        SKIP(0) "E.) TRANSFER PRINTED INVOICES TO A/R"
        SKIP(1) "F.) ADD NEW CUST/INV DESCRIPTIONS"
        SKIP(0) "G.) MAINTAIN CUST/INV DESCRIPTIONS"
        SKIP(1) "X.) EXIT"
        WITH CENTERED TITLE
        "W E E K L Y   I N V O I C E   P R O C E S S I N G   S C R E E N".
    UPDATE SKIP(1) SPACE(1) SELECTION AUTO-RETURN
        WITH SIDE-LABELS.
    HIDE.
        IF SELECTION = "A" AND NOT XPROG THEN RUN WIN-CRE.P.
   ELSE IF SELECTION = "B" AND NOT XPROG THEN RUN WIN-RPT.P.
   ELSE IF SELECTION = "C" AND NOT XPROG THEN RUN WIN-PRO.P.
   ELSE IF SELECTION = "D" AND NOT XPROG THEN RUN WIN-REPRO.P.
   ELSE IF SELECTION = "E" AND NOT XPROG THEN RUN WIN-TRF.P.
   ELSE IF SELECTION = "F" AND NOT XPROG THEN RUN WIND-ADD.P.
   ELSE IF SELECTION = "G" AND NOT XPROG THEN RUN WIND-CHG.P.
   ELSE IF SELECTION = "X" THEN LEAVE.
   ELSE MESSAGE "INCORRECT CHOICE " SELECTION.
END.