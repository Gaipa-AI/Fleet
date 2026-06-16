table 50015 "Archived Cash Purchase Line"
{
    Caption = 'Archived Cash Purchase Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(3; Type; Option)
        {
            OptionMembers = " ", "G/L Account", Item, "Fixed Asset";
            Caption = 'Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; Location; Code[20])
        {
            Caption = 'Location';
            Editable = false;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            Editable = false;
        }
        field(8; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(10; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(11; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(12; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(13; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        // Add other fields as necessary
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}