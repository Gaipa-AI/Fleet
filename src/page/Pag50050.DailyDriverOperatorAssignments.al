page 50050 DailyDriverOperatorAssignments
{
    Caption = 'Daily Driver|Operator Assignments';
    PageType = List;
    ApplicationArea = All;
    Editable = false;
    CardPageId = "Daily DriverOperator Assign";
    UsageCategory = Lists;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Daily Assignment"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}