pageextension 50003 "Purchase Order Subform FL" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Advance Code"; Rec."Advance Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Advance Code field.';
            }
        }
        addafter(ShortcutDimCode8)
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