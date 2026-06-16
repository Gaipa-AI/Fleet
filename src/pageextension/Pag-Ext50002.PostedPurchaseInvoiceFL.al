pageextension 50002 "Posted Purchase Invoice FL" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor Invoice No.")
        {
            field("Purchase Requisition No."; Rec."Purchase Requisition No.")
            {
                ApplicationArea = All;
                Editable = false;
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
}