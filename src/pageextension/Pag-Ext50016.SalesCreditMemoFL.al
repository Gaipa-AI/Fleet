pageextension 50016 "Sales Credit Memo FL" extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Equipment Hire No."; Rec."Equipment Hire No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Vehicle Hire No. field.', Comment = '%';
            }
            field("Equipment Hire Invoice"; Rec."Equipment Hire Invoice")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Equipment Hire Invoice field.', Comment = '%';
            }
            field("Equipment Type"; Rec."Equipment Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                Editable = false;
            }
            field("Hire Request No."; Rec."Hire Request No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Hire Request No. field.', Comment = '%';
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