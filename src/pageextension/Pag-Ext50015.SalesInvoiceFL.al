pageextension 50015 "Sales Invoice FL" extends "Sales Invoice"
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
            field("Equipment No."; Rec."Equipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Hire Request No. field.', Comment = '%';
                Editable = true;

            }
            field("Hire Type"; Rec."Hire Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Hire Type field.', Comment = '%';
                Editable = true;

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