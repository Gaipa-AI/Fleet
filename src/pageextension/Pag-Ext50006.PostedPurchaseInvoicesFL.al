pageextension 50006 "Posted Purchase Invoices FL" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Purchase Requisition No."; Rec."Purchase Requisition No.")
            {
                ApplicationArea = All;
            }
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