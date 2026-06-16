tableextension 50003 "Approval Entry FL" extends "Approval Entry"
{
    fields
    {
        field(50000; "Escalated By"; Code[40])
        {
            Caption = 'Escalated By';
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(50001; "Requisition Type"; Enum "Requisition Type")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(50002; "Escalated On"; Date)
        {
            Caption = 'Date Escalated';
            Editable = false;
        }
        field(50003; "Payee Name"; Text[150])
        {
            Editable = false;
        }
        field(50004; "Payee No."; Code[50])
        {
            Editable = false;
        }
        field(50005; Description; Text[245])
        {
            Editable = false;
        }
        field(50006; "Prepared By"; Code[50])
        {
            Editable = false;
        }
        field(50007; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(50009; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                TESTFIELD("Posting Date");
            end;
        }
        field(50010; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
    }

    var
        myInt: Integer;
}