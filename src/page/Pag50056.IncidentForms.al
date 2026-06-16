page 50056 "Incident Forms"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Incident Form";
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Incident Notification Form"));

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
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
                field("Status"; Rec.Status)
                {
                    Tooltip = 'Specifies the status of the Incident Form', Comment = '%';

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