tableextension 50001 "Employee FL" extends Employee
{
    fields
    {
        field(50000; "Employee Type"; Code[20])
        {
            TableRelation = "General value".Code where(Type = filter("Employee Type"));
        }
        field(50001; "Years of Experience"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Driving License ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Driving License Class"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "License validity Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."License validity Start Date" <> 0D then
                    if Rec."License Validity End date" <> 0D then
                        if Rec."License validity Start Date" > Rec."License Validity End date" then
                            Error('License validity Start Date can not be greater than License Validity End date');

                    if Rec."License Validity End date" <> 0D then begin
                    Rec.Validate("Days to License expiry", Rec."License Validity End date" - Today);
                    Rec.Modify();
                end else begin
                    Rec.validate("Days to License expiry", 0);
                    Rec.Modify();
                end;
                LicenseExpiry();
            end;
        }
        field(50005; "License Validity End date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."License Validity End date" <> 0D then
                    if Rec."License validity Start Date" <> 0D then
                        if Rec."License Validity End date" < Rec."License validity Start Date" then
                            Error('License Validity End date can not be less than "License validity Start Date"');

                if Rec."License Validity End date" <> 0D then begin
                    Rec.Validate("Days to License expiry", Rec."License Validity End date" - Today);
                    Rec.Modify();
                end else begin
                    Rec.validate("Days to License expiry", 0);
                    Rec.Modify();
                end;
                LicenseExpiry();
            end;
        }
        field(50006; "DDT Certification(Provider)"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "DefensiveDrive ValidStartDate"; Date)
        {
            Caption = 'Defensive Driving validity Start Date';
            trigger OnValidate()
            begin
                if Rec."DefensiveDrive ValidStartDate" <> 0D then
                    if Rec."DefensiveDrive ValidEndDate" <> 0D then
                        if Rec."DefensiveDrive ValidStartDate" > Rec."DefensiveDrive ValidEndDate" then
                            Error('Defensive Driving Start Date can not be greater than the End Date');

                if Rec."DefensiveDrive ValidEndDate" <> 0D then begin
                    Rec."Defensive Driving Days" := Rec."DefensiveDrive ValidEndDate" - Today;
                    Rec.Modify();
                end else begin
                    Rec."Defensive Driving Days" := 0;
                    Rec.Modify();
                end;
            end;
        }
        field(50008; "DefensiveDrive ValidEndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Defensive Driving validity End Date';
            trigger OnValidate()
            begin
                if Rec."DefensiveDrive ValidEndDate" <> 0D then
                    if Rec."DefensiveDrive ValidStartDate" <> 0D then
                        if Rec."DefensiveDrive ValidEndDate" < Rec."DefensiveDrive ValidStartDate" then
                            Error('Defensive Driving End Date can not be less the the start Date');

                if Rec."DefensiveDrive ValidEndDate" <> 0D then begin
                    Rec."Defensive Driving Days" := Rec."DefensiveDrive ValidEndDate" - Today;
                    Rec.Modify();
                end else begin
                    Rec."Defensive Driving Days" := 0;
                    Rec.Modify();
                end;
            end;
        }
        field(50009; "Medical Fitness (Provider)"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Fitness Validity Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."Fitness Validity Start Date" <> 0D then
                    if Rec."Fitness Validity End Date" <> 0D then
                        if Rec."Fitness Validity Start Date" > Rec."Fitness Validity End Date" then
                            Error('The Fitness Start Date can not be greater than the End Date');

                if Rec."Fitness Validity End Date" <> 0D then begin
                    Rec."Medical Fitness Days" := ("Fitness Validity End Date" - Today);
                    Rec.Modify();
                end else begin
                    Rec."Medical Fitness Days" := 0;
                    Rec.Modify();
                end;
            end;
        }
        field(50011; "Fitness Validity End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."Fitness Validity End Date" <> 0D then
                    if Rec."Fitness Validity Start Date" <> 0D then
                        if Rec."Fitness Validity End Date" < Rec."Fitness Validity Start Date" then
                            Error('The Fitness End Date can not be less than the Start Date');

                if Rec."Fitness Validity End Date" <> 0D then begin
                    Rec."Medical Fitness Days" := ("Fitness Validity End Date" - Today);
                    Rec.Modify();
                end else begin
                    Rec."Medical Fitness Days" := 0;
                    Rec.Modify();
                end;
            end;
        }
        field(50012; "Rewards/Sanctions"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Client; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Subcontractor; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Remarks; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; TIN; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; NIN; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Days to License expiry"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Days to License expiry" <= 0 then begin
                    Rec."License Expired" := true;
                    Rec.Modify();
                end else begin
                    Rec."License Expired" := false;
                    Rec.Modify();
                end;
            end;
        }
        field(50019; "License Expired"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Driver Status"; Enum "Driver Status")
        {
            trigger OnValidate()
            begin
                // if Rec."Driver Status" = Rec."Driver Status"::Inactive then begin
                //     Rec.Validate(Status, Status::Inactive);
                //end
                //else 
                if Rec."Driver Status" = Rec."Driver Status"::Active then begin
                    Rec.Validate(Status, Status::Active);
                end 
                //else if Rec."Driver Status" = Rec."Driver Status"::Terminated then begin
                //     Rec.Validate(Status, Status::Terminated);
                //end 
                else 
                if Rec."Driver Status" = Rec."Driver Status"::OnLeave then begin
                    Rec.Validate(Status, Status::Active);
                end;
            end;
        }
        field(50021; "Medical Fitness Days"; Integer)
        {
            Editable = false;
        }
        field(50022; "Defensive Driving Days"; Integer)
        {
            Editable = false;
        }
        field(50023; "Blocked"; Boolean)
        {
            Caption = 'Blocked';

        }
        
    }

    keys
    {
        // Add changes to keys here
        key(Key2; "Employee Type") { }
    }

    fieldgroups
    {
        
        
        // Add changes to field groups here
    }

    procedure LicenseExpiry()
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


    var
        myInt: Integer;

}