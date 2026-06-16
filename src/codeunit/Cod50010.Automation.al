
codeunit 50011 "Automation"
{
    trigger OnRun()
    begin
        //UpdateFixedAssets();
        GetMileage();
    end;

    // local procedure UpdateFixedAssets()
    // var
    //     FixedAsset: Record "Fixed Asset";
    // begin
    //     // Your processing logic here
    // end;

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
     end;
}

