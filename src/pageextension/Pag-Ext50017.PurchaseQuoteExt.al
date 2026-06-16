pageextension 50017 "Purchase Quote Ext" extends "Purchase Quote"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Requisition No."; Rec."Purchase Requisition No.")
            {
                ApplicationArea = All;
                Editable = false;
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