table 50009 "Performance Header"
{
    DataCaptionFields = "No.", "Start Date", "End Date";

    fields
    {
        field(1; "No."; Code[30])
        {
            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    FleetManagementSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Document Type"; Enum "Performance Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Posting No. Series"; code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Prepared by"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Driver No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
                PerformanceLine: Record "Performance Line";
            begin
                // NC
                if xRec."Driver No." <> Rec."Driver No." then begin
                //if Rec."Driver No." <> '' then begin
                    PerformanceLine.SetRange("Document No.", Rec."No.");
                    PerformanceLine.SetRange("Employee No.", Rec."Driver No.");
                    // NC
                    //PerformanceLine.SetFilter("Employee No.", xRec."Driver No.");

                    if PerformanceLine.FindFirst() then
                        Error('The Driver already exists in the performance line.');

                    //NC
                    if PerformanceLine.FindSet() then
                        repeat
                            PerformanceLine.Validate("Employee No.", Rec."Driver No.");
                            PerformanceLine.Modify();
                        until PerformanceLine.Next() = 0;

                    if Employee.Get(Rec."Driver No.") then begin
                        Rec."Driver Name" := Employee.FullName();
                    end else
                        Rec."Driver Name" := '';
                
                 end;
            end;
            
        }
        field(9; "Driver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable= false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FleetManagementSetup: Record "Fleet Management Setup";
        ANFSetup: Record "Fleet Management Setup";
        Text003: Label 'You cannot rename a %1.';

    trigger OnInsert()
    begin
        "Start Date" := Today;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", Today, "No.", "No. Series");
        END;

        InitRecord;
        Rec."Prepared by" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        ERROR(Text003, TABLECAPTION);
    end;

    procedure AssistEdit(FormHeader: Record "Performance Header"): Boolean;
    begin
        ANFSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, FormHeader."No. Series", "No. Series") THEN BEGIN
            FleetManagementSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    /// <summary>
    /// Description for TestNoSeries.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    local procedure TestNoSeries(): Boolean;
    begin
        FleetManagementSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Performance Monitoring":
                FleetManagementSetup.TESTFIELD("Performance No.");
        END;
    end;

    /// <summary>
    /// Description for GetNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "Code[10]".</returns>
    local procedure GetNoSeriesCode(): Code[10];
    begin

        CASE "Document Type" OF
            "Document Type"::"Performance Monitoring":
                exit(FleetManagementSetup."Performance No.");
        END;
    end;

    procedure InitRecord();
    begin
        ANFSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Performance Monitoring":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Performance No." = ANFSetup."Performance No.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Performance No.");

                    "Prepared by" := UserId;
                END;

        END;
    end;
}