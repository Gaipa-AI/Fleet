pageextension 50012 "Vendor Ledger Entries FM" extends "Vendor Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Entry No.")
        {
            field("Equipment No."; Rec."Equipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
            }
            field("Equipment Type"; Rec."Equipment Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
            }
            field("Responsible Employee"; Rec."Responsible Employee")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsible Employee field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}