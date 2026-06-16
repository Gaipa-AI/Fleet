table 50014 "Archived Cash Purchase"
{
    Caption = 'Archived Cash Purchase';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(3; "Document Time"; Time)
        {
            Caption = 'Document Time';
            Editable = false;
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(5; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            Editable = false;
        }
        field(6; "Archived Date"; DateTime)
        {
            Caption = 'Archived Date';
            Editable = false;
        }
        // Add other fields as necessary
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}