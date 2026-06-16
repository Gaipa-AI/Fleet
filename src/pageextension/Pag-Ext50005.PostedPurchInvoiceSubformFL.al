pageextension 50005 "Posted PurchInvoice Subform FL" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Description 2")
        {
            field("Advance Code"; Rec."Advance Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Advance Code field.';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Equipment No."; Rec."Equipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                Editable = false;
            }
            field("Equipment Type"; Rec."Equipment Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                Editable = false;
            }
            field("Responsible Employee"; Rec."Responsible Employee")
            {
                ApplicationArea = All;
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