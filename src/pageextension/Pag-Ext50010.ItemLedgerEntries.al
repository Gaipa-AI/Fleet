pageextension 50010 "Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Entry No.")
        {
            field("Store Req. No"; Rec."Store Req. No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store Req. No field.', Comment = '%';
            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
            }
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
            field("From Store Req"; Rec."From Store Req")
            {
                ApplicationArea = All;
            }
            field("Responsible Employee"; Rec."Responsible Employee")
            {
                ApplicationArea = All;
            }
            field("Purchase Requisition No."; Rec."Purchase Requisition No.")
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