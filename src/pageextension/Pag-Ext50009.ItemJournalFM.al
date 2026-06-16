pageextension 50009 "Item Journal FM" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Shortcut Dimension 1 Code")
        {
            field("Equipment No."; Rec."Equipment No.")
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