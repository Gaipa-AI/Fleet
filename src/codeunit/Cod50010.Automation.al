
codeunit 50011 "Automation"
{
    trigger OnRun()
    begin
        //UpdateFixedAssets();
        GetMileage();
        UpdateExpiryDays();
        LicenseExpiry();
    end;

    
    local procedure GetMileage()
    var
    FixedAsset: Record "Fixed Asset";
    PerformanceLine: Record "Performance Line";
    TotalKMCovered: Decimal;
    begin
    if FixedAsset.FindSet() then
        repeat
            TotalKMCovered := 0;

            PerformanceLine.Reset();
            PerformanceLine.SetRange(
                "Document Type",
                PerformanceLine."Document Type"::"Performance Monitoring");
            PerformanceLine.SetRange(
                "Employee No.",
                FixedAsset."Responsible Employee");

            if PerformanceLine.FindSet() then
                repeat
                    TotalKMCovered += PerformanceLine."KM Covered";
                until PerformanceLine.Next() = 0;

            FixedAsset."Vehicle Mileage" += TotalKMCovered;
            if FixedAsset."No." = '' then
              Error('Fixed Asset No. is blank.');
            FixedAsset.Modify();
        until FixedAsset.Next() = 0;
        Message('All Fixed assets mileage updated');
     end;

    procedure UpdateExpiryDays()
    var
        LicenseRec: Record "Employee";
    begin
        if LicenseRec.FindSet() then
            repeat
                if LicenseRec."License Validity End date" <> 0D then begin
                    LicenseRec."Days to License expiry" :=
                        LicenseRec."License Validity End date" - Today;
                    LicenseRec.Modify();
                end else begin
                    LicenseRec."Days to License expiry" := 0;
                    LicenseRec.Modify();
                end;
                if LicenseRec."DefensiveDrive ValidEndDate" <> 0D then begin
                    LicenseRec."Defensive Driving Days" := LicenseRec."DefensiveDrive ValidEndDate" - Today;
                    LicenseRec.Modify();
                end else begin
                    LicenseRec."Defensive Driving Days" := 0;
                    LicenseRec.Modify();
                end;
                if LicenseRec."Fitness Validity End Date" <> 0D then begin
                    LicenseRec."Medical Fitness Days" := (LicenseRec."Fitness Validity End Date" - Today);
                    LicenseRec.Modify();
                end else begin
                    LicenseRec."Medical Fitness Days" := 0;
                    LicenseRec.Modify();
                end;

            until LicenseRec.Next() = 0;
            Message('Licenses updated');
    end;
    procedure LicenseExpiry()
    var
      Rec: Record "Employee";
    begin
            begin
                if Rec."Days to License expiry" <= 0 then begin
                    Rec."License Expired" := true;
                    Rec.Modify();
                end else begin
                    Rec."License Expired" := false;
                    Rec.Modify();
                end;
            end;
    end;
}

