table 50010 "Performance Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; enum "Performance Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            
            trigger OnValidate()
            var
                Employee: Record Employee;
                PerformanceLine: Record "Performance Line";
            begin
                TestField("Document No.");
                GetPerformanceHeader();

                if Rec."Employee No." <> '' then begin
                    PerformanceLine.Reset();
                    PerformanceLine.SetRange("Document No.", Rec."Document No.");
                    PerformanceLine.SetRange("Employee No.", Rec."Employee No.");
                    // if PerformanceLine.FindFirst() then
                    //     Error('The Employee already exists.');
                end;

                if Employee.Get(Rec."Employee No.") then begin
                    Rec."Employee Name" := Employee.FullName();
                    Rec.Designation := Employee."Job Title";
                end
                else begin
                    Rec."Employee Name" := '';
                    Rec.Designation := '';
                end;
            end;

            


        }
        field(5; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(6; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Job Expectations"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(14;Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Days Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Jobs Executed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "KM Covered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Hours Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Incidents Caused"; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Form Header"
                where("Document Type" = const("Incident Notification Form"),
                      "Driver No." = field("Employee No."), "Description"= filter(<>'')));
           
        }
        field(13; "No. Of Client Complaints"; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Form Header"
                where("Document Type" = const("Incident Notification Form"),
                      "Driver No." = field("Employee No."), "Complaint No."= filter(<>'')));
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        PerformanceHeader: Record "Performance Header";

    trigger OnInsert()
     
    begin
        if Rec."Document No." <> '' then
        if PerformanceHeader.Get(Rec."Document Type", Rec."Document No.") then
            Rec.Validate("Employee No.", PerformanceHeader."Driver No.");

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetPerformanceHeader(): Record "Performance Header"
    begin
        GetPerformanceHeader(PerformanceHeader);
        exit(PerformanceHeader);
    end;

    procedure GetPerformanceHeader(var OutPerformanceHeader: Record "Performance Header")
    var
        myInt: Integer;
    begin
        TestField("Document No.");
        if ("Document Type" <> PerformanceHeader."Document Type") or ("Document No." <> PerformanceHeader."No.") then begin
            PerformanceHeader.Get(Rec."Document Type", Rec."Document No.");
        end;
        OutPerformanceHeader := PerformanceHeader;
    end;

}