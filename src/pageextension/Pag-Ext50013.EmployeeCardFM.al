pageextension 50013 "Employee Card FM" extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Company E-Mail")
        {
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        modify(Status)
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("Driver Status"; Rec."Driver Status")
            {
                // Caption = 'Status';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Driver Status field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}