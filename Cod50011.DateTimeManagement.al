codeunit 50012 "Date Time Management"
{

    // Returns whole minutes between StartDT and EndDT (positive if EndDT >= StartDT, negative otherwise)
    procedure MinutesBetween(StartDT: DateTime; EndDT: DateTime): Integer
    var
        DateStart: Date;
        DateEnd: Date;
        DaysDiff: Integer;
        StrStart: Text;
        StrEnd: Text;
        TimeStart: Text;
        TimeEnd: Text;
        PosSpace: Integer;
        HStart: Integer;
        MStart: Integer;
        HEnd: Integer;
        MEnd: Integer;
        Minutes: Integer;
        TempText: Text;
    begin
        if EndDT = StartDT then
            exit(0);

        if EndDT < StartDT then
            exit(-MinutesBetween(EndDT, StartDT));

        DateStart := StartDT.Date();
        DateEnd := EndDT.Date();
        DaysDiff := DateEnd - DateStart;
        Minutes := DaysDiff * 24 * 60;

        // Use FORMAT to get textual representation and extract time portion
        StrStart := Format(StartDT);
        StrEnd := Format(EndDT);

        PosSpace := STRPOS(StrStart, ' ');
        if PosSpace > 0 then
            TimeStart := COPYSTR(StrStart, PosSpace + 1)
        else
            TimeStart := StrStart;

        PosSpace := STRPOS(StrEnd, ' ');
        if PosSpace > 0 then
            TimeEnd := COPYSTR(StrEnd, PosSpace + 1)
        else
            TimeEnd := StrEnd;

        // Extract HH and MM from time string (expected formats like "HH:MM" or "HH:MM:SS" or "H:MM")
        // Safely parse hours
        TempText := DELCHR(TimeStart, '=', ':'); // keep colons for positions but DELCHR used here to ensure length safe - harmless if not found
        if (STRLEN(TimeStart) >= 2) and EVALUATE(HStart, COPYSTR(TimeStart, 1, 2)) = false then begin
            // try single-digit hour
            if STRPOS(TimeStart, ':') > 0 then
                EVALUATE(HStart, COPYSTR(TimeStart, 1, STRPOS(TimeStart, ':') - 1));
        end;
        if (STRLEN(TimeStart) >= 5) and EVALUATE(MStart, COPYSTR(TimeStart, 4, 2)) = false then begin
            if STRPOS(TimeStart, ':') > 0 then
                EVALUATE(MStart, COPYSTR(TimeStart, STRPOS(TimeStart, ':') + 1, 2));
        end;

        if (STRLEN(TimeEnd) >= 2) and EVALUATE(HEnd, COPYSTR(TimeEnd, 1, 2)) = false then begin
            if STRPOS(TimeEnd, ':') > 0 then
                EVALUATE(HEnd, COPYSTR(TimeEnd, 1, STRPOS(TimeEnd, ':') - 1));
        end;
        if (STRLEN(TimeEnd) >= 5) and EVALUATE(MEnd, COPYSTR(TimeEnd, 4, 2)) = false then begin
            if STRPOS(TimeEnd, ':') > 0 then
                EVALUATE(MEnd, COPYSTR(TimeEnd, STRPOS(TimeEnd, ':') + 1, 2));
        end;

        // Fallbacks if parsing failed (set to 0)
        if HStart < 0 then HStart := 0;
        if MStart < 0 then MStart := 0;
        if HEnd < 0 then HEnd := 0;
        if MEnd < 0 then MEnd := 0;

        Minutes += (HEnd * 60 + MEnd) - (HStart * 60 + MStart);

        exit(Minutes);
    end;

    // Returns hours difference as decimal with 2 decimals
    procedure HoursBetween(StartDT: DateTime; EndDT: DateTime): Decimal
    var
        Min: Integer;
        HoursDec: Decimal;
    begin
        Min := MinutesBetween(StartDT, EndDT);
        HoursDec := ROUND(Min / 60.0, 2);
        exit(HoursDec);
    end;

}
